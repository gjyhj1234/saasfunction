#!/usr/bin/env bash
# job_03_product_scope.sh — 定义产品范围
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/02-architecture"
ensure_dir "$DOC_DIR"

write_doc "$DOC_DIR/product-scope.md" "# 产品范围定义

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}

## 产品愿景

打造一款现代化、AI 增强的口腔诊所 SaaS 管理系统，为口腔医疗机构提供从预约到结算的全流程数字化解决方案。

## MVP 范围定义

### 核心模块 (MVP 必须)

| 模块 | 说明 | 用户角色 |
|------|------|----------|
| 预约管理 | 预约创建、日历视图、冲突检测 | 前台、医生、患者 |
| 患者档案 | 患者信息、就诊历史 | 前台、医生 |
| 收费结算 | 费用计算、账单、收款 | 前台、管理者 |
| 用户与权限 | 登录、RBAC、多角色 | 全部 |

### 二期扩展模块

| 模块 | 说明 |
|------|------|
| 电子病历 | 结构化病历、牙位图 |
| 库存管理 | 耗材追踪、预警 |
| 报表分析 | 经营数据、可视化 |
| 患者沟通 | 短信/微信通知 |

### 远期规划模块

| 模块 | 说明 |
|------|------|
| 影像管理 | DICOM 集成 |
| AI 辅助 | 智能诊断建议 |
| 连锁管理 | 多门店数据汇总 |

## 技术边界

- **前端**: React / Next.js
- **后端**: Node.js / NestJS
- **数据库**: PostgreSQL
- **部署**: Docker + Kubernetes
- **认证**: JWT + OAuth2
- **多租户**: Schema-per-tenant

## 排除项

以下内容明确不在本项目范围内：
- 医疗影像 AI 分析
- 药品管理（非口腔专用）
- 医院 HIS 系统集成
- 硬件设备驱动开发
"

echo "$DOC_DIR/product-scope.md"
