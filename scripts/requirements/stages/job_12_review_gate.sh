#!/usr/bin/env bash
# job_12_review_gate.sh — 编码前人工审计（冻结记录）
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/09-review"
ensure_dir "$DOC_DIR"
ensure_dir "$OUTPUT_DIR"

# 生成审计冻结记录
FREEZE_TS="$(now_ts)"

write_doc "$DOC_DIR/freeze-record.md" "# 需求冻结记录

> 冻结时间: ${FREEZE_TS}
> 执行范围: ${SCOPE}
> 审批方式: GitHub Actions Environment Gate

## 冻结说明

本记录表示需求工程流水线的所有文档生成阶段已完成，并已通过人工审批环节。

## 冻结范围

以下文档在本次冻结中被确认：

| 阶段 | 文档 | 状态 |
|------|------|------|
| 01 | 竞品分析报告 | ✓ 已生成 |
| 01 | 用户调研摘要 | ✓ 已生成 |
| 02 | 规范化需求清单 | ✓ 已生成 |
| 03 | 产品范围定义 | ✓ 已生成 |
| 04 | 系统蓝图 | ✓ 已生成 |
| 05 | 基础规范 | ✓ 已生成 |
| 06 | 菜单结构 | ✓ 已生成 |
| 07 | 功能树 | ✓ 已生成 |
| 08 | 页面详细设计 | ✓ 已生成 |
| 09 | 领域模型 | ✓ 已生成 |
| 10 | 验收测试文档 | ✓ 已生成 |
| 11 | AI 编码任务包 | ✓ 已生成 |

## 审批说明

- 审批通过后，需求进入冻结状态
- 冻结后的需求变更需要走变更管理流程
- 本记录为自动生成，审批通过动作由 GitHub Environment Gate 保障

## 后续步骤

1. ✅ 需求冻结完成
2. ⏸️ 编码阶段需要另行启动（本流水线不会自动进入编码）
3. 📋 编码前需确认所有需求文档已被相关人员审阅
"

write_doc "$OUTPUT_DIR/freeze-manifest.json" "{
  \"freeze_timestamp\": \"${FREEZE_TS}\",
  \"target_scope\": \"${SCOPE}\",
  \"status\": \"frozen\",
  \"documents\": [
    \"docs/specs/01-research/competitive-analysis.md\",
    \"docs/specs/01-research/user-research-summary.md\",
    \"docs/specs/01-research/normalized-requirements.md\",
    \"docs/specs/02-architecture/product-scope.md\",
    \"docs/specs/02-architecture/system-blueprint.md\",
    \"docs/specs/03-information-architecture/menu-structure.md\",
    \"docs/specs/03-information-architecture/feature-tree.md\",
    \"docs/specs/04-domain-model/domain-model.md\",
    \"docs/specs/05-design-system/base-standards.md\",
    \"docs/specs/06-pages/page-specifications.md\",
    \"docs/specs/07-test-specs/acceptance-tests.md\",
    \"docs/specs/08-ai-task-packs/ai-coding-tasks.md\"
  ],
  \"run_id\": \"${GITHUB_RUN_ID:-0}\",
  \"run_number\": \"${GITHUB_RUN_NUMBER:-0}\"
}"

echo "$DOC_DIR/freeze-record.md"
echo "$OUTPUT_DIR/freeze-manifest.json"
