# 患者列表

## 页面信息
- route: /patients/list
- module: patient
- permission: patient:view
- layout: standard table page

## 搜索栏
| 字段名 | 组件类型 | 占位符 | 说明 |
|--------|----------|--------|------|
| 关键词 | Input | 搜索姓名/手机号/患者编号/WhatsApp/LINE ID | 支持模糊搜索 |

## 筛选器
| 筛选项 | 组件类型 | 选项 | 默认值 |
|--------|----------|------|--------|
| 性别 | Select | 全部/男/女/其他 | 全部 |
| 来源 | MultiSelect | walk_in/referral/online/dental_tourism/family/advertising/social_media | 全部 |
| 会员等级 | Select | 全部/普通/银卡/金卡/铂金 | 全部 |
| 标签 | MultiSelect | 动态标签列表 | 全部 |
| 欠费状态 | Select | 全部/有欠费/无欠费 | 全部 |
| 注册日期 | DateRangePicker | | |
| 最近就诊 | DateRangePicker | | |
| 状态 | Select | active/inactive/blacklisted | active |
| 是否旅游患者 | Select | 全部/是/否 | 全部 |

## 数据表格
| 列标题 | 字段名 | 数据类型 | 宽度 | 可排序 | 说明 |
|--------|--------|----------|------|--------|------|
| 患者编号 | patient_no | string | 100px | 否 | 点击跳转详情 |
| 姓名 | name | string | 120px | 是 | 加粗，点击跳转详情 |
| 性别 | gender | enum | 60px | 否 | 图标展示 |
| 年龄 | age_display | string | 60px | 是 | 根据birth_date计算 |
| 手机号 | phone | string | 120px | 否 | 带国家区号 |
| 会员等级 | vip_level | enum | 90px | 否 | 彩色标签: 普通(灰)/银(银色)/金(金色)/铂金(紫色) |
| 来源 | referral_source | enum | 80px | 否 | |
| 最近就诊 | last_visit_date | date | 100px | 是 | |
| 累计就诊 | total_visits | number | 70px | 是 | |
| 累计消费 | total_spent | money | 100px | 是 | 带币种符号 |
| 欠费 | outstanding_balance | money | 100px | 是 | 红色显示(>0时) |
| 标签 | tags | tags | 150px | 否 | 多标签展示，最多3个+更多 |
| 状态 | status | enum | 70px | 否 | |
| 操作 | - | - | 140px | 否 | 固定右侧 |

## 行操作
| 按钮文本 | 操作类型 | 权限 | 说明 |
|----------|----------|------|------|
| 查看 | 链接 | patient:view | 跳转患者详情页 |
| 预约 | 链接 | appointment:create | 打开新建预约，预填患者 |
| 收费 | 链接 | billing:create | 跳转收费页，预填患者 |

## 批量操作
| 按钮文本 | 权限 | 说明 |
|----------|------|------|
| 批量打标签 | patient:edit | 为选中患者添加标签 |
| 导出 | patient:export | 导出为Excel |

## 工具栏
| 按钮 | 类型 | 权限 | 说明 |
|------|------|------|------|
| 新建患者 | 主按钮 | patient:create | 打开新建患者抽屉 |
| 导入 | 次按钮 | patient:import | 从Excel批量导入 |
| 导出 | 次按钮 | patient:export | 导出当前筛选结果 |

## 新建患者抽屉 (640px)

### 基本信息
| 字段标签 | 字段名 | 组件类型 | 必填 | 验证规则 | 说明 |
|----------|--------|----------|------|----------|------|
| 姓名 | name | Input | 是 | 2-50字符 | 英文/通用名 |
| 本地姓名 | name_local | Input | 否 | | 泰文/越南文等本地语言姓名 |
| 性别 | gender | RadioGroup | 是 | | 男/女/其他 |
| 出生日期 | birth_date | DatePicker | 是 | 不晚于今天 | |
| 证件类型 | id_type | Select | 否 | | passport/national_id/driving_license |
| 证件号码 | id_number | Input | 否 | | 加密存储 |
| 手机号 | phone | PhoneInput | 是 | 带国家区号 | +66/+84/+63/+62/+60/+65 |
| WhatsApp | whatsapp | Input | 否 | | |
| LINE ID | line_id | Input | 否 | | |
| 邮箱 | email | Input | 否 | 邮箱格式 | |
| 首选语言 | preferred_language | Select | 否 | | en/th/vi/id/ms |

### 联系地址
| 字段标签 | 字段名 | 组件类型 | 必填 | 说明 |
|----------|--------|----------|------|------|
| 地址 | address | Textarea | 否 | |
| 城市 | city | Input | 否 | |
| 省/州 | province_state | Input | 否 | |
| 国家 | country | Select | 否 | 国家列表 |
| 邮编 | postal_code | Input | 否 | |

### 医疗信息
| 字段标签 | 字段名 | 组件类型 | 必填 | 说明 |
|----------|--------|----------|------|------|
| 血型 | blood_type | Select | 否 | A/B/O/AB/不详 |
| 过敏史 | allergies | TagInput | 否 | 可多个 |
| 既往病史 | medical_history | Textarea | 否 | |
| 慢性病 | chronic_diseases | TagInput | 否 | |
| 在服药物 | current_medications | Textarea | 否 | |

### 监护人信息 (age < 18 时自动显示必填)
| 字段标签 | 字段名 | 组件类型 | 必填 | 说明 |
|----------|--------|----------|------|------|
| 监护人姓名 | guardian_name | Input | 条件必填 | 未成年必填 |
| 监护人电话 | guardian_phone | PhoneInput | 条件必填 | |
| 关系 | guardian_relationship | Select | 条件必填 | father/mother/grandparent/sibling/other |

### 紧急联系人
| 字段标签 | 字段名 | 组件类型 | 必填 | 说明 |
|----------|--------|----------|------|------|
| 紧急联系人 | emergency_contact_name | Input | 否 | |
| 联系电话 | emergency_contact_phone | PhoneInput | 否 | |
| 关系 | emergency_contact_relationship | Select | 否 | |

### 其他信息
| 字段标签 | 字段名 | 组件类型 | 必填 | 说明 |
|----------|--------|----------|------|------|
| 来源 | referral_source | Select | 否 | walk_in/referral/online/dental_tourism/family/advertising/social_media |
| 推荐人 | referral_patient_id | SearchSelect | 否 | 搜索已有患者 |
| 标签 | tags | TagInput | 否 | |
| 旅游患者 | is_dental_tourist | Switch | 否 | |
| 来源国 | dental_tourist_country | Select | 条件必填 | 旅游患者时必填 |
| 备注 | notes | Textarea | 否 | |
