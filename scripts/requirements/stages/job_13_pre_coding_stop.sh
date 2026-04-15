#!/usr/bin/env bash
# job_13_pre_coding_stop.sh — 编码前停止
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/09-review"
ensure_dir "$DOC_DIR"
ensure_dir "$OUTPUT_DIR"

STOP_TS="$(now_ts)"

write_doc "$DOC_DIR/pre-coding-stop-record.md" "# 编码前停止记录

> 停止时间: ${STOP_TS}
> 执行范围: ${SCOPE}

## 说明

需求工程流水线已完成所有阶段，在编码前主动停止。

## 状态总结

- ✅ 需求收集与调研: 完成
- ✅ 需求规范化: 完成
- ✅ 产品范围定义: 完成
- ✅ 系统蓝图设计: 完成
- ✅ 基础规范制定: 完成
- ✅ 菜单结构设计: 完成
- ✅ 功能树扩展: 完成
- ✅ 页面详细设计: 完成
- ✅ 领域模型设计: 完成
- ✅ 验收测试编写: 完成
- ✅ AI 任务包生成: 完成
- ✅ 人工审计通过: 完成
- ✅ 需求冻结: 完成
- ⛔ 编码阶段: 未启动（按设计停止）

## 下一步

要启动编码阶段，请：
1. 确认所有需求文档已经过团队审阅
2. 创建新的编码 workflow 或手动启动编码流程
3. 本流水线不会也不应该自动进入编码
"

write_doc "$OUTPUT_DIR/pipeline-complete.json" "{
  \"stop_timestamp\": \"${STOP_TS}\",
  \"target_scope\": \"${SCOPE}\",
  \"pipeline_status\": \"stopped_before_coding\",
  \"all_stages_completed\": true,
  \"coding_started\": false,
  \"run_id\": \"${GITHUB_RUN_ID:-0}\",
  \"run_number\": \"${GITHUB_RUN_NUMBER:-0}\"
}"

echo "$DOC_DIR/pre-coding-stop-record.md"
echo "$OUTPUT_DIR/pipeline-complete.json"
