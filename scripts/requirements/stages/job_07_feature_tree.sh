#!/usr/bin/env bash
# job_07_feature_tree.sh — 扩展功能树（含仓储/商城）
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/03-information-architecture"
ensure_dir "$DOC_DIR"

write_doc "$DOC_DIR/feature-tree.md" "# 功能树

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}
> 目标市场: 东南亚 (Southeast Asia)

## 完整功能树

### 1. 预约管理 (appointment)

\`\`\`
appointment/
├── appointment-create          # 创建预约
│   ├── select-patient          # 选择/新建患者
│   ├── select-doctor           # 选择医生
│   ├── select-time-slot        # 选择时段
│   ├── select-treatment-type   # 选择诊疗类型
│   └── confirm-booking         # 确认预约
├── appointment-calendar        # 日历视图
│   ├── day-view                # 日视图
│   ├── week-view               # 周视图
│   └── month-view              # 月视图
├── appointment-list            # 预约列表
│   ├── filter-by-status        # 按状态筛选
│   ├── filter-by-doctor        # 按医生筛选
│   └── filter-by-date          # 按日期筛选
├── appointment-detail          # 预约详情
│   ├── reschedule              # 改期
│   ├── cancel                  # 取消
│   ├── check-in                # 签到
│   └── complete                # 完成
├── online-booking              # 在线预约 (牙科旅游)
│   ├── public-booking-page     # 公开预约页面
│   └── multi-lang-support      # 多语言支持
└── schedule-manage             # 排班管理
    ├── doctor-schedule         # 医生排班
    ├── room-schedule           # 诊室排班
    └── holiday-setting         # 节假日设置
\`\`\`

### 2. 患者管理 (patient)

\`\`\`
patient/
├── patient-list                # 患者列表
│   ├── search                  # 搜索
│   ├── filter                  # 筛选
│   └── export                  # 导出
├── patient-create              # 新建患者
│   ├── basic-info              # 基本信息
│   ├── contact-info            # 联系方式 (WhatsApp/LINE/电话)
│   └── medical-history         # 病史
├── patient-detail              # 患者详情
│   ├── profile                 # 个人资料
│   ├── visit-history           # 就诊记录
│   ├── billing-history         # 费用记录
│   ├── medical-records         # 病历记录
│   └── images                  # 影像资料
└── patient-tags                # 患者标签
    ├── tag-manage              # 标签管理
    └── batch-tag               # 批量打标
\`\`\`

### 3. 收费结算 (billing)

\`\`\`
billing/
├── pending-charges             # 待收费
├── charge-create               # 创建账单
│   ├── select-items            # 选择收费项
│   ├── select-currency         # 选择币种
│   ├── apply-discount          # 优惠/折扣
│   └── confirm-charge          # 确认收费
├── payment                     # 收款
│   ├── cash                    # 现金
│   ├── card                    # 刷卡
│   ├── grabpay                 # GrabPay
│   ├── gcash                   # GCash
│   ├── ovo                     # OVO
│   ├── bank-transfer           # 银行转账
│   └── other                   # 其他
├── charge-history              # 收费记录
├── refund                      # 退款管理
├── fee-item-manage             # 费用项目管理
└── invoice                     # 发票管理
\`\`\`

### 4. 仓储管理 (warehouse)

\`\`\`
warehouse/
├── warehouse-manage            # 仓库管理
│   ├── warehouse-list          # 仓库列表
│   ├── warehouse-create        # 新建仓库
│   ├── location-manage         # 库位管理
│   └── warehouse-detail        # 仓库详情
├── stock-in                    # 入库管理
│   ├── purchase-stock-in       # 采购入库
│   ├── return-stock-in         # 退货入库
│   ├── transfer-in             # 调拨入库
│   └── stock-in-history        # 入库记录
├── stock-out                   # 出库管理
│   ├── sales-stock-out         # 销售出库 (商城订单)
│   ├── usage-stock-out         # 领用出库 (临床使用)
│   ├── transfer-out            # 调拨出库
│   └── stock-out-history       # 出库记录
├── inventory-check             # 库存盘点
│   ├── create-check            # 创建盘点单
│   ├── check-execution         # 执行盘点
│   └── check-result            # 盘点结果/差异处理
├── stock-alert                 # 库存预警
│   ├── low-stock-alert         # 低库存预警
│   ├── expiry-alert            # 效期预警
│   └── auto-replenish-suggest  # 自动补货建议
├── purchase                    # 采购管理
│   ├── purchase-request        # 采购申请
│   ├── purchase-approval       # 采购审批
│   ├── purchase-order          # 采购订单
│   ├── goods-receiving         # 到货验收
│   └── purchase-history        # 采购记录
├── supplier                    # 供应商管理
│   ├── supplier-list           # 供应商列表
│   ├── supplier-create         # 新建供应商
│   ├── supplier-rating         # 供应商评级
│   └── supplier-contracts      # 合同管理
├── batch-management            # 批次效期管理
│   ├── batch-tracking          # 批次追踪
│   └── expiry-management       # 有效期管理
└── warehouse-reports           # 仓储报表
    ├── stock-report            # 库存报表
    ├── turnover-report         # 周转率报表
    └── purchase-report         # 采购报表
\`\`\`

### 5. 商城系统 (mall)

\`\`\`
mall/
├── product-manage              # 商品管理
│   ├── product-list            # 商品列表
│   ├── product-create          # 新建商品 (SPU/SKU)
│   ├── product-edit            # 编辑商品
│   ├── category-manage         # 分类管理
│   └── brand-manage            # 品牌管理
├── product-listing             # 商品上下架
│   ├── pricing                 # 定价管理
│   ├── publish                 # 上架
│   └── unpublish               # 下架
├── order-manage                # 订单管理
│   ├── order-list              # 订单列表
│   ├── order-detail            # 订单详情
│   ├── order-fulfill           # 订单履约 (发货)
│   ├── order-return            # 退换货
│   └── order-history           # 订单历史
├── mall-frontend               # 商城前台
│   ├── b2c-storefront          # B2C 商城 (患者购买护理产品)
│   ├── b2b-catalog             # B2B 采购目录 (诊所间耗材)
│   ├── shopping-cart           # 购物车
│   ├── checkout                # 结算
│   └── order-tracking          # 订单跟踪
├── promotion                   # 促销管理
│   ├── coupon-manage           # 优惠券
│   └── campaign-manage         # 活动管理
├── logistics                   # 物流管理
│   ├── shipping-config         # 配送配置
│   └── logistics-tracking      # 物流跟踪
└── mall-settings               # 商城设置
    ├── payment-config          # 支付配置
    └── display-config          # 展示配置
\`\`\`

### 6. 用户与权限 (auth)

\`\`\`
auth/
├── login                       # 登录
│   ├── password-login          # 密码登录
│   └── sms-login               # 短信登录
├── user-manage                 # 用户管理
│   ├── user-list               # 用户列表
│   ├── user-create             # 创建用户
│   └── user-edit               # 编辑用户
├── role-manage                 # 角色管理
│   ├── role-list               # 角色列表
│   ├── role-create             # 创建角色
│   └── permission-assign       # 权限分配
└── department-manage           # 科室管理
\`\`\`

## 功能优先级标注

| 功能 | MVP | 二期 | 远期 |
|------|-----|------|------|
| 预约创建/修改/取消 | ✓ | | |
| 预约日历视图 | ✓ | | |
| 患者 CRUD | ✓ | | |
| 收费创建/多币种收款 | ✓ | | |
| 用户登录/权限 | ✓ | | |
| 仓库管理/入库/出库 | ✓ | | |
| 采购管理/供应商管理 | ✓ | | |
| 库存盘点/预警 | ✓ | | |
| 批次效期管理 | ✓ | | |
| 商城商品管理 | | ✓ | |
| 商城订单管理 | | ✓ | |
| B2C 商城前台 | | ✓ | |
| B2B 采购平台 | | ✓ | |
| 病历管理 | | ✓ | |
| 临床库存 | | ✓ | |
| 报表分析 | | ✓ | |
| 多语言支持(基础) | ✓ | | |
| 牙科旅游在线预约 | | | ✓ |
| 影像管理 | | | ✓ |
| AI 辅助 | | | ✓ |
| WhatsApp/LINE 集成 | | | ✓ |
| Shopee/Lazada 对接 | | | ✓ |
"

echo "$DOC_DIR/feature-tree.md"
