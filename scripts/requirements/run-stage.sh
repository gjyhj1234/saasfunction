#!/usr/bin/env bash
# run-stage.sh — Runner for individual pipeline stages
# Usage: ./scripts/requirements/run-stage.sh <job_id> <scope>
#
# This script:
#   1. Sources common utilities
#   2. Checks if the stage is already completed (skip if so)
#   3. Syncs with remote
#   4. Executes the stage-specific script
#   5. Writes status file
#   6. Commits and pushes results
set -euo pipefail
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "${SCRIPT_DIR}/common.sh"

# ─── Parse arguments ─────────────────────────────────────────────────────────
JOB_ID="${1:?Usage: run-stage.sh <job_id> <scope>}"
SCOPE="${2:?Usage: run-stage.sh <job_id> <scope>}"

log_group "阶段: ${JOB_ID} (scope=${SCOPE})"

# ─── Step 1: Check if already completed ──────────────────────────────────────
if is_stage_completed "$JOB_ID" "$SCOPE"; then
  log_info "$JOB_ID" "阶段已完成，跳过执行 (scope=${SCOPE})"
  echo "stage_skipped=true" >> "${GITHUB_OUTPUT:-/dev/null}"
  log_endgroup
  exit 0
fi

echo "stage_skipped=false" >> "${GITHUB_OUTPUT:-/dev/null}"

# ─── Step 2: Sync with remote ────────────────────────────────────────────────
git_sync || {
  log_error "$JOB_ID" "无法同步远端代码，阶段中止"
  exit 1
}

# ─── Step 3: Execute the stage script ────────────────────────────────────────
STAGE_SCRIPT="${SCRIPT_DIR}/stages/${JOB_ID}.sh"
if [[ ! -f "$STAGE_SCRIPT" ]]; then
  log_error "$JOB_ID" "Stage script not found: $STAGE_SCRIPT"
  exit 1
fi

log_info "$JOB_ID" "开始执行阶段脚本..."

# Collect generated files from the stage script
GENERATED_FILES=()
export JOB_ID SCOPE DOCS_DIR OUTPUT_DIR STATUS_DIR

# The stage script should output generated file paths (one per line) to stdout
# and write documents. We capture the file list. Stderr is preserved for diagnostics.
stage_error_log="/tmp/${JOB_ID}_error.log"
stage_output=$("${STAGE_SCRIPT}" "$SCOPE" 2>"$stage_error_log") || {
  local err_detail
  err_detail=$(tail -20 "$stage_error_log" 2>/dev/null || echo "no error details captured")
  write_status "$JOB_ID" "failed" "$SCOPE" "Stage script exited with error: ${err_detail}"
  log_error "$JOB_ID" "阶段执行失败。错误详情:"
  cat "$stage_error_log" >&2 2>/dev/null || true
  local_status_file="$(status_file_path "$JOB_ID")"
  git_commit_and_push "$JOB_ID" "req-pipeline: ${JOB_ID} failed (scope=${SCOPE})" "$local_status_file"
  log_endgroup
  exit 1
}

# Parse generated files list from stage output
while IFS= read -r line; do
  [[ -n "$line" ]] && GENERATED_FILES+=("$line")
done <<< "$stage_output"

# ─── Step 4: Write completion status ─────────────────────────────────────────
write_status "$JOB_ID" "completed" "$SCOPE" "Stage completed successfully"
local_status_file="$(status_file_path "$JOB_ID")"
GENERATED_FILES+=("$local_status_file")

# ─── Step 5: Commit and push ─────────────────────────────────────────────────
git_commit_and_push "$JOB_ID" \
  "req-pipeline: ${JOB_ID} 完成 (scope=${SCOPE})" \
  "${GENERATED_FILES[@]}"

log_info "$JOB_ID" "阶段执行完成 ✓"
log_endgroup
