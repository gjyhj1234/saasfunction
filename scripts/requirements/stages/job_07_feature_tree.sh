#!/usr/bin/env bash
# job_07_feature_tree.sh — 扩展功能树
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/03-information-architecture"
ensure_dir "$DOC_DIR"

write_doc "$DOC_DIR/feature-tree.md" "# 功能树

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}

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
│   ├── contact-info            # 联系方式
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
│   ├── apply-discount          # 优惠/折扣
│   └── confirm-charge          # 确认收费
├── payment                     # 收款
│   ├── cash                    # 现金
│   ├── card                    # 刷卡
│   ├── wechat-pay              # 微信支付
│   └── alipay                  # 支付宝
├── charge-history              # 收费记录
├── refund                      # 退款管理
├── fee-item-manage             # 费用项目管理
└── invoice                     # 发票管理
\`\`\`

### 4. 用户与权限 (auth)

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
| 收费创建/收款 | ✓ | | |
| 用户登录/权限 | ✓ | | |
| 病历管理 | | ✓ | |
| 库存管理 | | ✓ | |
| 报表分析 | | ✓ | |
| 影像管理 | | | ✓ |
| AI 辅助 | | | ✓ |
"

echo "$DOC_DIR/feature-tree.md"
