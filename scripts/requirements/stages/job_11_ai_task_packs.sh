#!/usr/bin/env bash
# job_11_ai_task_packs.sh — 生成 AI 编码任务包
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/08-ai-task-packs"
ensure_dir "$DOC_DIR"
ensure_dir "$OUTPUT_DIR"

write_doc "$DOC_DIR/ai-coding-tasks.md" "# AI 编码任务包

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}

## 说明

本文档将需求拆解为可交给 AI 编码助手执行的独立任务包。每个任务包包含明确的输入、输出、依赖和验收标准。

## 任务包列表

### TASK-001: 项目初始化
- **优先级**: P0 (最先执行)
- **描述**: 使用 NestJS CLI 初始化后端项目，配置 TypeORM、PostgreSQL、JWT
- **输入**: 技术规范文档
- **输出**: 可运行的项目骨架
- **验收**: \`npm run build\` 成功, \`npm test\` 通过
- **预计工作量**: 小

### TASK-002: 数据库 Schema
- **优先级**: P0
- **依赖**: TASK-001
- **描述**: 根据领域模型创建所有 Entity 和 Migration
- **输入**: domain-model.md
- **输出**: TypeORM Entity 文件 + Migration
- **验收**: Migration 可成功执行，表结构与模型一致
- **预计工作量**: 中

### TASK-003: 认证模块
- **优先级**: P0
- **依赖**: TASK-002
- **描述**: 实现登录、JWT 签发/刷新、RBAC Guard
- **输入**: base-standards.md (安全规范)
- **输出**: auth module + guards + decorators
- **验收**: 登录/登出 API 可用，权限拦截生效
- **预计工作量**: 中

### TASK-004: 患者管理 API
- **优先级**: P0
- **依赖**: TASK-003
- **描述**: 实现患者 CRUD + 搜索 + 分页
- **输入**: domain-model.md, normalized-requirements.md
- **输出**: patient module (controller + service + dto)
- **验收**: 所有 CRUD API 可用，分页/搜索正确
- **预计工作量**: 中

### TASK-005: 预约管理 API
- **优先级**: P0
- **依赖**: TASK-004
- **描述**: 实现预约 CRUD + 冲突检测 + 状态流转
- **输入**: feature-tree.md, domain-model.md
- **输出**: appointment module
- **验收**: 预约全生命周期 API 可用，冲突检测正确
- **预计工作量**: 大

### TASK-006: 收费结算 API
- **优先级**: P0
- **依赖**: TASK-005
- **描述**: 实现收费单创建、收款、退款
- **输入**: feature-tree.md, domain-model.md
- **输出**: billing module
- **验收**: 收费全流程 API 可用，金额计算正确
- **预计工作量**: 大

### TASK-007: 前端项目初始化
- **优先级**: P0
- **依赖**: TASK-001
- **描述**: 使用 Next.js + Tailwind + shadcn/ui 初始化前端
- **输入**: base-standards.md
- **输出**: 可运行的前端骨架
- **验收**: \`npm run build\` 成功
- **预计工作量**: 小

### TASK-008: 前端登录页
- **优先级**: P0
- **依赖**: TASK-003, TASK-007
- **描述**: 实现登录页面 + 认证状态管理
- **输入**: page-specifications.md (P-001)
- **输出**: login page + auth store
- **验收**: 可登录并跳转，token 正确管理
- **预计工作量**: 中

### TASK-009: 前端布局与导航
- **优先级**: P0
- **依赖**: TASK-008
- **描述**: 实现侧边栏布局 + 菜单 + 面包屑
- **输入**: menu-structure.md
- **输出**: layout components + navigation
- **验收**: 菜单展示正确，路由跳转正常
- **预计工作量**: 中

### TASK-010: 前端预约管理
- **优先级**: P0
- **依赖**: TASK-005, TASK-009
- **描述**: 预约日历 + 列表 + 创建/编辑
- **输入**: page-specifications.md (P-003, P-004)
- **输出**: appointment pages + components
- **验收**: 日历视图、创建、编辑功能正常
- **预计工作量**: 大

## 任务依赖图

\`\`\`
TASK-001 ─┬── TASK-002 ── TASK-003 ─┬── TASK-004 ── TASK-005 ── TASK-006
          │                          │
          └── TASK-007 ── TASK-008 ──┘── TASK-009 ── TASK-010
\`\`\`

## 执行建议

1. 后端和前端初始化可并行
2. 认证模块是最关键的依赖点
3. 每个任务完成后应立即运行测试
4. API 完成后才开始对应的前端页面
"

# 生成摘要到 artifacts
write_doc "$OUTPUT_DIR/task-summary.md" "# 任务包摘要

> 生成时间: $(now_ts)

共 10 个任务包，覆盖 MVP 范围。
详细内容请参见: docs/specs/08-ai-task-packs/ai-coding-tasks.md
"

echo "$DOC_DIR/ai-coding-tasks.md"
echo "$OUTPUT_DIR/task-summary.md"
