#!/usr/bin/env bash
# job_06_menu_structure.sh — 建立菜单结构（含仓储/商城）
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/03-information-architecture"
ensure_dir "$DOC_DIR"

write_doc "$DOC_DIR/menu-structure.md" "# 系统菜单结构

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}
> 目标市场: 东南亚 (Southeast Asia)

## 菜单树

\`\`\`
📁 Dental SaaS Management System (口腔 SaaS 管理系统)
├── 🏠 Dashboard (工作台)
│   ├── Today Overview (今日概览)
│   ├── To-Do List (待办事项)
│   └── Quick Actions (快捷操作)
│
├── 📅 Appointments (预约管理)
│   ├── Calendar (预约日历)
│   ├── Appointment List (预约列表)
│   ├── New Appointment (新建预约)
│   └── Schedule Management (排班管理)
│
├── 👤 Patients (患者管理)
│   ├── Patient List (患者列表)
│   ├── New Patient (新建患者)
│   ├── Patient Detail (患者详情)
│   │   ├── Profile (基本信息)
│   │   ├── Visit History (就诊记录)
│   │   ├── Billing History (费用记录)
│   │   └── Images (影像资料)
│   └── Patient Tags (患者标签)
│
├── 📋 Medical Records (病历管理)
│   ├── Record List (病历列表)
│   ├── New Record (新建病历)
│   ├── Templates (病历模板)
│   └── Dental Chart (牙位图)
│
├── 💰 Billing (收费结算)
│   ├── Pending Charges (待收费)
│   ├── Charge History (收费记录)
│   ├── Refund Management (退款管理)
│   ├── Fee Items Setup (费用项目设置)
│   └── Invoice Management (发票管理)
│
├── 🏭 Warehouse (仓储管理)
│   ├── Warehouse List (仓库列表)
│   ├── Stock In (入库管理)
│   │   ├── Purchase Stock-In (采购入库)
│   │   ├── Return Stock-In (退货入库)
│   │   └── Transfer In (调拨入库)
│   ├── Stock Out (出库管理)
│   │   ├── Sales Stock-Out (销售出库)
│   │   ├── Usage Stock-Out (领用出库)
│   │   └── Transfer Out (调拨出库)
│   ├── Inventory Check (库存盘点)
│   ├── Stock Alerts (库存预警)
│   ├── Purchase Management (采购管理)
│   │   ├── Purchase Requests (采购申请)
│   │   ├── Purchase Orders (采购订单)
│   │   └── Receiving (到货验收)
│   ├── Supplier Management (供应商管理)
│   └── Batch/Expiry Tracking (批次效期管理)
│
├── 📦 Clinical Inventory (临床库存)
│   ├── Department Stock (科室库存)
│   ├── Usage Request (领用申请)
│   ├── Usage History (领用记录)
│   └── Low Stock Alert (低库存预警)
│
├── 🛒 Mall (商城管理)
│   ├── Products (商品管理)
│   │   ├── Product List (商品列表)
│   │   ├── Categories (商品分类)
│   │   └── Brands (品牌管理)
│   ├── Orders (订单管理)
│   │   ├── Order List (订单列表)
│   │   ├── Order Detail (订单详情)
│   │   └── Refund/Return (退换管理)
│   ├── Promotions (促销管理)
│   │   ├── Coupons (优惠券)
│   │   └── Campaigns (活动)
│   └── Mall Settings (商城设置)
│
├── 📊 Reports (数据报表)
│   ├── Revenue Report (营收报表)
│   ├── Patient Stats (患者统计)
│   ├── Doctor Workload (医生工作量)
│   ├── Inventory Report (库存报表)
│   ├── Mall Sales Report (商城销售报表)
│   └── Custom Reports (自定义报表)
│
├── 🔔 Notifications (消息中心)
│   ├── System Notifications (系统通知)
│   ├── Appointment Reminders (预约提醒)
│   └── Message Templates (消息模板)
│
├── 🌐 Localization (语言设置)
│   └── Language Selector (语言切换)
│
└── ⚙️ Settings (系统设置)
    ├── Clinic Info (机构信息)
    ├── Departments (科室管理)
    ├── Staff Management (员工管理)
    ├── Roles & Permissions (角色权限)
    ├── Currency Settings (币种设置)
    ├── Payment Channels (支付渠道配置)
    ├── System Parameters (系统参数)
    └── Audit Log (操作日志)
\`\`\`

## 角色与菜单权限矩阵

| 菜单 | 管理员 | 医生 | 前台 | 助理 | 库管 | 商城运营 | 患者(App) |
|------|--------|------|------|------|------|----------|-----------|
| Dashboard | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | - |
| Appointments | ✓ | ✓(R) | ✓ | ✓ | - | - | My Appts |
| Patients | ✓ | ✓ | ✓ | ✓(R) | - | - | My Profile |
| Medical Records | ✓ | ✓ | ✓(R) | ✓(R) | - | - | - |
| Billing | ✓ | ✓(R) | ✓ | - | - | - | My Bills |
| Warehouse | ✓ | - | - | - | ✓ | - | - |
| Clinical Inventory | ✓ | ✓(R) | ✓ | ✓ | ✓(R) | - | - |
| Mall (Backend) | ✓ | - | - | - | - | ✓ | - |
| Mall (Frontend) | - | - | - | - | - | - | ✓(Shop) |
| Reports | ✓ | Self | Desk | - | WH | Mall | - |
| Notifications | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Settings | ✓ | - | - | - | - | - | - |

> R = Read Only; Self/Desk/WH/Mall = 仅限各自领域的报表

## 导航设计说明

- 主导航: 左侧固定菜单栏
- 面包屑: 所有页面显示路径
- 快捷搜索: 顶部全局搜索
- 最近访问: 快捷入口
- 语言切换: 顶栏右上角
- 币种显示: 根据租户配置自动匹配
"

echo "$DOC_DIR/menu-structure.md"
