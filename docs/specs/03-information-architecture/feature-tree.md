# 功能树

> 版本: v2.0
> 更新时间: 2026-04-15
> 执行范围: mvp
> 目标市场: 东南亚 (Southeast Asia)

## 完整功能树

### 1. 预约管理 (appointment)

```
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
```

### 2. 患者管理 (patient)

```
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
├── patient-tags                # 患者标签
│   ├── tag-manage              # 标签管理
│   └── batch-tag               # 批量打标
└── patient-family              # 家庭关系（轻量级）
    ├── guardian-info            # 监护人/紧急联系人
    ├── family-link             # 家庭成员关联（同一家庭患者关联）
    └── referral-source         # 推荐来源（含家庭推荐）
```

### 3. 收费结算 (billing)

```
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
├── invoice                     # 发票管理
├── receivable                  # 应收账款
│   ├── outstanding-list        # 欠费列表
│   ├── patient-balance         # 患者余额查看
│   ├── overdue-alert           # 逾期提醒
│   └── bad-debt                # 坏账核销
└── installment                 # 分期付款
    ├── installment-plan        # 分期方案设置
    ├── installment-track       # 分期还款跟踪
    └── installment-reminder    # 还款提醒
```

### 4. 仓储管理 (warehouse)

```
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
```

### 5. 商城系统 (mall)

```
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
```

### 6. 用户与权限 (auth)

```
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
```

### 7. 病历管理 (medical-record)

```
medical-record/
├── dental-chart                # 牙位图管理
│   ├── chart-view              # 牙位图查看（FDI编码，成人32颗/儿童20颗）
│   ├── tooth-status            # 牙齿状态记录（健康/龋齿/缺失/修复/种植/冠/桥/根管等）
│   ├── tooth-history           # 单颗牙历史记录（按时间线展示）
│   └── batch-update            # 批量更新牙齿状态
├── clinical-image              # 临床影像
│   ├── image-upload            # 影像上传（口内照/根尖片/全景片/CBCT）
│   ├── image-tooth-bind        # 影像与牙位关联（必须关联具体牙位或区域）
│   ├── image-annotation        # 影像标注
│   ├── before-after            # 治疗前后对比
│   └── image-timeline          # 同一牙位影像时间线
├── treatment-plan              # 治疗方案
│   ├── plan-create             # 创建治疗方案（多步骤）
│   ├── plan-cost-estimate      # 费用预估
│   ├── plan-progress           # 进度跟踪
│   ├── plan-consent            # 患者知情同意
│   └── plan-adjust             # 方案调整
├── medical-record-create       # 病历录入
│   ├── chief-complaint         # 主诉
│   ├── examination             # 检查
│   ├── diagnosis               # 诊断
│   ├── treatment-record        # 治疗记录（关联牙位、影像）
│   └── prescription            # 处方/医嘱
├── record-template             # 病历模板
│   ├── template-manage         # 模板管理
│   └── template-apply          # 套用模板
└── record-print                # 病历打印/导出
```

### 8. 会员体系 (membership)

```
membership/
├── member-level                # 会员等级
│   ├── level-config            # 等级配置（普通/银卡/金卡/铂金）
│   ├── upgrade-rule            # 升级规则（按消费金额自动升级）
│   └── level-privilege         # 等级权益（折扣比例/积分倍率/免费项目）
├── points                      # 积分系统
│   ├── points-earn             # 积分获取（消费/签到/推荐）
│   ├── points-redeem           # 积分使用（抵扣/兑换）
│   └── points-history          # 积分流水
├── stored-value                # 储值卡
│   ├── recharge                # 充值（多币种）
│   ├── consume                 # 消费扣款
│   ├── balance-query           # 余额查询
│   └── recharge-history        # 充值/消费记录
├── member-package              # 会员套餐
│   ├── package-config          # 套餐配置（洁牙套餐/美白套餐等）
│   ├── package-purchase        # 套餐购买
│   ├── package-usage           # 套餐使用（次数扣减）
│   └── package-expiry          # 套餐到期管理
└── member-report               # 会员报表
    ├── member-stats            # 会员统计
    └── consumption-analysis    # 消费分析
```

### 9. 随访管理 (follow-up)

```
follow-up/
├── follow-up-plan              # 随访计划
│   ├── auto-generate           # 根据治疗类型自动生成
│   ├── manual-create           # 手动创建
│   └── plan-template           # 随访模板（洁牙半年、种植术后1/3/6月等）
├── reminder                    # 提醒通知
│   ├── whatsapp-notify         # WhatsApp 提醒
│   ├── line-notify             # LINE 提醒
│   ├── sms-notify              # SMS 提醒
│   └── reminder-config         # 提醒配置（提前天数、重复次数）
├── recall-management           # 复诊管理
│   ├── pending-recall          # 待复诊列表
│   ├── overdue-recall          # 逾期未复诊
│   └── recall-history          # 复诊记录
└── no-show-tracking            # 失约管理
    ├── no-show-list            # 失约列表
    └── re-contact              # 重新联系
```

## 功能优先级标注

| 功能 | MVP | 二期 | 远期 |
|------|-----|------|------|
| 预约创建/修改/取消 | ✓ | | |
| 预约日历视图 | ✓ | | |
| 患者 CRUD | ✓ | | |
| 患者家庭关系/推荐来源 | ✓ | | |
| 收费创建/多币种收款 | ✓ | | |
| 应收账款/分期付款 | ✓ | | |
| 用户登录/权限 | ✓ | | |
| 仓库管理/入库/出库 | ✓ | | |
| 采购管理/供应商管理 | ✓ | | |
| 库存盘点/预警 | ✓ | | |
| 批次效期管理 | ✓ | | |
| 牙位图/临床影像/治疗方案 | ✓ | | |
| 会员等级/积分/储值/套餐 | ✓ | | |
| 随访计划/提醒/复诊管理 | ✓ | | |
| 商城商品管理 | | ✓ | |
| 商城订单管理 | | ✓ | |
| B2C 商城前台 | | ✓ | |
| B2B 采购平台 | | ✓ | |
| 病历录入/模板/打印 | | ✓ | |
| 临床库存 | | ✓ | |
| 报表分析 | | ✓ | |
| 多语言支持(基础) | ✓ | | |
| 牙科旅游在线预约 | | | ✓ |
| 影像标注/前后对比 | | | ✓ |
| AI 辅助 | | | ✓ |
| WhatsApp/LINE 集成 | | | ✓ |
| Shopee/Lazada 对接 | | | ✓ |
