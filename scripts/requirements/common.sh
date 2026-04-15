#!/usr/bin/env bash
# common.sh — Shared utilities for the requirements engineering pipeline
# All identifiers are English; Chinese is used only in display messages and docs.
set -euo pipefail
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ─── Constants ───────────────────────────────────────────────────────────────
STATUS_DIR="${STATUS_DIR:-.github/requirements-status}"
DOCS_DIR="${DOCS_DIR:-docs/specs}"
OUTPUT_DIR="${OUTPUT_DIR:-artifacts/requirements/latest}"
MAX_GIT_RETRIES=3
GIT_RETRY_DELAY=5

# ─── Logging helpers ─────────────────────────────────────────────────────────
log_info()  { echo "::notice::[$1] $2"; }
log_warn()  { echo "::warning::[$1] $2"; }
log_error() { echo "::error::[$1] $2"; }
log_group() { echo "::group::$1"; }
log_endgroup() { echo "::endgroup::"; }

# ─── Status file helpers ─────────────────────────────────────────────────────

# Returns the path to the status file for a given job id
status_file_path() {
  local job_id="$1"
  echo "${STATUS_DIR}/${job_id}.json"
}

# Read the status value from a job's status file. Returns empty string if missing.
read_status() {
  local job_id="$1"
  local sf
  sf="$(status_file_path "$job_id")"
  if [[ -f "$sf" ]]; then
    python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print(d.get('status',''))" "$sf" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

# Read the target_scope from a job's status file. Returns empty string if missing.
read_status_scope() {
  local job_id="$1"
  local sf
  sf="$(status_file_path "$job_id")"
  if [[ -f "$sf" ]]; then
    python3 -c "import json,sys; d=json.load(open(sys.argv[1])); print(d.get('target_scope',''))" "$sf" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

# Check if a stage is already completed for the given scope
is_stage_completed() {
  local job_id="$1"
  local scope="$2"
  local status scope_in_file
  status="$(read_status "$job_id")"
  scope_in_file="$(read_status_scope "$job_id")"
  if [[ "$status" == "completed" && "$scope_in_file" == "$scope" ]]; then
    return 0
  fi
  return 1
}

# Write a status file for a stage
write_status() {
  local job_id="$1"
  local status="$2"
  local scope="$3"
  local description="${4:-}"
  local sf
  sf="$(status_file_path "$job_id")"
  mkdir -p "$(dirname "$sf")"
  cat > "$sf" <<STATUSEOF
{
  "job_id": "${job_id}",
  "status": "${status}",
  "target_scope": "${scope}",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "description": "${description}",
  "runner": "${RUNNER_NAME:-local}",
  "run_id": "${GITHUB_RUN_ID:-0}",
  "run_number": "${GITHUB_RUN_NUMBER:-0}"
}
STATUSEOF
  log_info "$job_id" "Status written: $status (scope=$scope)"
}

# ─── Git helpers ──────────────────────────────────────────────────────────────

# Sync with remote: fetch + rebase with retry logic
git_sync() {
  local branch="${1:-${GITHUB_REF_NAME:-$(git rev-parse --abbrev-ref HEAD)}}"
  local attempt=0
  log_info "git" "Syncing with remote branch: $branch"
  while (( attempt < MAX_GIT_RETRIES )); do
    attempt=$((attempt + 1))
    if git fetch origin "$branch" 2>/dev/null; then
      if git rebase "origin/$branch" 2>/dev/null; then
        log_info "git" "Sync successful (attempt $attempt)"
        return 0
      else
        log_warn "git" "Rebase conflict on attempt $attempt, aborting rebase and retrying..."
        git rebase --abort 2>/dev/null || true
      fi
    else
      log_warn "git" "Fetch failed on attempt $attempt"
    fi
    if (( attempt < MAX_GIT_RETRIES )); then
      log_info "git" "Waiting ${GIT_RETRY_DELAY}s before retry..."
      sleep "$GIT_RETRY_DELAY"
    fi
  done
  log_error "git" "Failed to sync after $MAX_GIT_RETRIES attempts"
  return 1
}

# Commit and push changes for a specific stage
git_commit_and_push() {
  local job_id="$1"
  local message="$2"
  shift 2
  local files=("$@")
  local branch="${GITHUB_REF_NAME:-$(git rev-parse --abbrev-ref HEAD)}"

  # Configure git identity
  git config user.name "requirements-pipeline[bot]"
  git config user.email "requirements-pipeline[bot]@users.noreply.github.com"

  # Add specified files
  for f in "${files[@]}"; do
    if [[ -e "$f" ]]; then
      git add "$f"
    fi
  done

  # Check if there are changes to commit
  if git diff --cached --quiet; then
    log_info "$job_id" "No changes to commit"
    return 0
  fi

  git commit -m "$message"

  # Push with retry
  local attempt=0
  while (( attempt < MAX_GIT_RETRIES )); do
    attempt=$((attempt + 1))
    if git push origin "HEAD:$branch" 2>/dev/null; then
      log_info "$job_id" "Push successful (attempt $attempt)"
      return 0
    fi
    log_warn "$job_id" "Push failed on attempt $attempt, trying pull + push..."
    if git pull --rebase origin "$branch" 2>/dev/null; then
      if git push origin "HEAD:$branch" 2>/dev/null; then
        log_info "$job_id" "Push successful after pull (attempt $attempt)"
        return 0
      fi
    else
      git rebase --abort 2>/dev/null || true
    fi
    if (( attempt < MAX_GIT_RETRIES )); then
      sleep "$GIT_RETRY_DELAY"
    fi
  done
  log_error "$job_id" "Failed to push after $MAX_GIT_RETRIES attempts"
  return 1
}

# ─── Document generation helpers ──────────────────────────────────────────────

# Ensure a directory exists
ensure_dir() {
  local dir="$1"
  mkdir -p "$dir"
}

# Write a markdown document (creates parent dirs as needed)
write_doc() {
  local filepath="$1"
  local content="$2"
  ensure_dir "$(dirname "$filepath")"
  printf '%s' "$content" > "$filepath"
  log_info "doc" "Generated: $filepath"
}

# Generate a timestamp string
now_ts() {
  date -u +%Y-%m-%dT%H:%M:%SZ
}
