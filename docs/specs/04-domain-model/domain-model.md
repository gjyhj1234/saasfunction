# 领域模型

> 版本: v2.0
> 更新时间: 2026-04-15
> 目标市场: 东南亚 (Southeast Asia)
> 说明: 本文档为业务领域模型，不涉及数据库实现细节

---

## 一、基础平台域

### 1. Tenant (租户)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| name | 租户名称 | String | 是 | |
| code | 租户编码 | String | 是 | 全局唯一 |
| country | 所在国家 | String | 是 | ISO 3166-1 alpha-2，如 TH/VN/PH |
| timezone | 时区 | String | 是 | 如 Asia/Bangkok |
| default_currency | 默认货币 | String | 是 | ISO 4217，如 THB/VND/PHP |
| supported_currencies | 支持的货币列表 | List\<String\> | 是 | ISO 4217 |
| default_locale | 默认语言 | String | 是 | 如 en/th/vi |
| supported_locales | 支持的语言列表 | List\<String\> | 是 | |
| logo_url | 诊所 Logo 地址 | String | 否 | |
| contact_phone | 联系电话 | String | 否 | |
| contact_email | 联系邮箱 | String | 否 | |
| address | 地址 | String | 否 | |
| business_license_no | 营业执照号 | String | 否 | |
| status | 状态 | Enum | 是 | active / suspended / archived |
| plan | 订阅计划 | Enum | 是 | free / basic / pro / enterprise |
| max_users | 最大用户数 | Integer | 是 | 受 plan 限制 |
| max_storage_gb | 最大存储空间(GB) | Integer | 是 | 受 plan 限制 |
| subscription_start | 订阅开始时间 | Date | 否 | |
| subscription_end | 订阅到期时间 | Date | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 2. User (用户)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| username | 用户名 | String | 是 | 租户内唯一 |
| password_hash | 密码散列 | String | 是 | |
| display_name | 显示名称 | String | 是 | |
| avatar_url | 头像地址 | String | 否 | |
| phone | 手机号 | String | 否 | |
| email | 邮箱 | String | 否 | |
| preferred_locale | 偏好语言 | String | 否 | |
| status | 状态 | Enum | 是 | active / disabled / locked |
| failed_login_count | 连续登录失败次数 | Integer | 是 | 默认 0 |
| locked_until | 锁定截止时间 | Timestamp | 否 | 失败次数达阈值后自动设置 |
| last_login_at | 最后登录时间 | Timestamp | 否 | |
| last_login_ip | 最后登录 IP | String | 否 | |
| password_changed_at | 最后修改密码时间 | Timestamp | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 3. Role (角色)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 角色名称 | String | 是 | |
| code | 角色编码 | String | 是 | 租户内唯一 |
| description | 描述 | String | 否 | |
| permissions | 权限列表 | List\<Object\> | 是 | 结构化权限，如 [{resource, actions}] |
| is_system | 是否系统预设 | Boolean | 是 | 系统预设角色不可删除 |
| sort_order | 排序号 | Integer | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 4. UserRole (用户角色关联)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| user_id | 用户 | UUID | 是 | |
| role_id | 角色 | UUID | 是 | |
| assigned_at | 分配时间 | Timestamp | 是 | |
| assigned_by | 分配人 | UUID | 是 | 操作人 User ID |

### 5. Department (科室)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 科室名称 | String | 是 | |
| code | 科室编码 | String | 是 | 租户内唯一 |
| parent_id | 上级科室 | UUID | 否 | 支持树形结构 |
| description | 描述 | String | 否 | |
| manager_id | 科室负责人 | UUID | 否 | 关联 User |
| sort_order | 排序号 | Integer | 是 | |
| status | 状态 | Enum | 是 | active / disabled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 6. Room (诊室)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| department_id | 所属科室 | UUID | 是 | |
| name | 诊室名称 | String | 是 | |
| code | 诊室编码 | String | 是 | 租户内唯一 |
| room_type | 诊室类型 | Enum | 是 | 普通诊室 / 手术室 / 影像室 / VIP诊室 |
| equipment_list | 设备清单 | List\<String\> | 否 | |
| floor | 楼层 | String | 否 | |
| status | 状态 | Enum | 是 | available / occupied / maintenance / disabled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 7. AuditLog (操作日志)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| user_id | 操作用户 | UUID | 是 | |
| user_name | 用户名称 | String | 是 | 冗余存储，便于查询 |
| action | 操作类型 | Enum | 是 | create / update / delete / login / logout / export / print |
| resource_type | 实体类型 | String | 是 | 如 Patient、Appointment |
| resource_id | 实体 ID | String | 是 | |
| resource_name | 实体名称 | String | 否 | 便于展示 |
| before_data | 变更前数据 | JSON | 否 | |
| after_data | 变更后数据 | JSON | 否 | |
| ip_address | IP 地址 | String | 否 | |
| user_agent | 客户端标识 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |

---

## 二、患者域

### 8. Patient (患者)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_no | 患者编号 | String | 是 | 诊所内唯一 |
| name | 姓名 | String | 是 | |
| name_local | 本地语言姓名 | String | 否 | 如泰语/越南语姓名 |
| gender | 性别 | Enum | 是 | male / female / other |
| birth_date | 出生日期 | Date | 否 | |
| age_display | 展示年龄 | String | 否 | 可由 birth_date 计算 |
| id_type | 证件类型 | Enum | 否 | passport / national_id / driving_license |
| id_number | 证件号码 | String | 否 | 加密存储 |
| phone | 手机号 | String | 否 | |
| phone_country_code | 手机国际区号 | String | 否 | 如 +66/+84/+63 |
| email | 邮箱 | String | 否 | |
| whatsapp | WhatsApp 号码 | String | 否 | 东南亚常用 |
| line_id | LINE ID | String | 否 | 泰国/日本常用 |
| address | 地址 | String | 否 | |
| city | 城市 | String | 否 | |
| province_state | 省/州 | String | 否 | |
| country | 国家 | String | 否 | |
| postal_code | 邮编 | String | 否 | |
| preferred_language | 偏好语言 | String | 否 | |
| blood_type | 血型 | String | 否 | A/B/O/AB/未知 |
| allergies | 过敏史 | List\<String\> | 否 | |
| medical_history | 既往病史 | String | 否 | |
| chronic_diseases | 慢性病 | List\<String\> | 否 | |
| current_medications | 在服药物 | List\<String\> | 否 | |
| emergency_contact_name | 紧急联系人姓名 | String | 否 | |
| emergency_contact_phone | 紧急联系人电话 | String | 否 | |
| emergency_contact_relationship | 紧急联系人关系 | String | 否 | |
| guardian_name | 监护人姓名 | String | 否 | 未成年患者必填 |
| guardian_phone | 监护人电话 | String | 否 | 未成年患者必填 |
| guardian_relationship | 监护人关系 | String | 否 | 未成年患者必填 |
| family_group_id | 家庭组 | UUID | 否 | |
| referral_source | 来源渠道 | Enum | 否 | walk_in / referral / online / dental_tourism / family / advertising / social_media |
| referral_patient_id | 推荐人 | UUID | 否 | 关联推荐患者 |
| tags | 标签 | List\<String\> | 否 | 自定义标签 |
| notes | 备注 | String | 否 | |
| vip_level | 当前会员等级 | String | 否 | 关联 MemberLevel |
| first_visit_date | 首次就诊日期 | Date | 否 | |
| last_visit_date | 最近就诊日期 | Date | 否 | |
| total_visits | 总就诊次数 | Integer | 否 | |
| total_spent | 累计消费 | Decimal | 否 | |
| outstanding_balance | 欠费余额 | Decimal | 否 | |
| source_channel | 渠道详情 | String | 否 | 如具体广告来源 |
| is_dental_tourist | 是否牙科旅游患者 | Boolean | 否 | |
| dental_tourist_country | 旅游患者来源国 | String | 否 | 仅牙科旅游患者填写 |
| status | 状态 | Enum | 是 | active / inactive / blacklisted |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 9. FamilyGroup (家庭组)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| group_name | 家庭组名称 | String | 是 | |
| primary_contact_id | 主联系人 | UUID | 是 | 关联 Patient |
| notes | 备注 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 10. FamilyMember (家庭成员关系)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| family_group_id | 家庭组 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| relationship | 与主联系人关系 | Enum | 是 | father / mother / spouse / child / sibling / grandparent / other |
| is_primary_contact | 是否主联系人 | Boolean | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |

---

## 三、预约域

### 11. DoctorSchedule (医生排班)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| doctor_id | 医生 | UUID | 是 | 关联 Doctor |
| room_id | 诊室 | UUID | 否 | |
| schedule_date | 排班日期 | Date | 是 | |
| start_time | 开始时间 | Time | 是 | |
| end_time | 结束时间 | Time | 是 | |
| slot_duration_minutes | 每个时段分钟数 | Integer | 是 | 如 30/60 |
| max_appointments | 最大预约数 | Integer | 是 | |
| status | 状态 | Enum | 是 | available / full / blocked / holiday |
| repeat_rule | 重复规则 | Enum | 否 | none / daily / weekly / biweekly |
| repeat_end_date | 重复结束日期 | Date | 否 | |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 12. Holiday (节假日)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 节假日名称 | String | 是 | |
| date | 日期 | Date | 是 | |
| country | 适用国家 | String | 是 | ISO 3166-1 |
| is_clinic_closed | 是否停诊 | Boolean | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 13. Doctor (医生)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| user_id | 关联用户 | UUID | 是 | 关联 User |
| title | 职称 | String | 否 | |
| specialties | 专长列表 | List\<String\> | 否 | 如: 正畸 / 种植 / 牙周 / 儿牙 / 口外 / 修复 / 美白 |
| license_number | 执业证号 | String | 是 | |
| license_expiry | 执业证到期日 | Date | 否 | |
| department_id | 所属科室 | UUID | 否 | |
| consultation_fee | 诊金 | Decimal | 否 | |
| bio | 简介 | String | 否 | |
| languages_spoken | 会说的语言 | List\<String\> | 否 | |
| working_years | 从业年限 | Integer | 否 | |
| photo_url | 照片地址 | String | 否 | |
| rating | 评分 | Decimal | 否 | |
| review_count | 评价数 | Integer | 否 | |
| status | 状态 | Enum | 是 | active / on_leave / resigned |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 14. Appointment (预约)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| appointment_no | 预约编号 | String | 是 | 租户内唯一 |
| patient_id | 患者 | UUID | 是 | |
| doctor_id | 医生 | UUID | 是 | |
| room_id | 诊室 | UUID | 否 | |
| schedule_date | 预约日期 | Date | 是 | |
| start_time | 开始时间 | Time | 是 | |
| end_time | 结束时间 | Time | 是 | |
| duration_minutes | 时长(分钟) | Integer | 是 | |
| treatment_type | 诊疗类型 | Enum | 是 | checkup / cleaning / filling / extraction / implant / orthodontics / whitening / root_canal / crown / other |
| treatment_type_detail | 诊疗详情描述 | String | 否 | |
| chief_complaint | 主诉 | String | 否 | |
| status | 状态 | Enum | 是 | scheduled / confirmed / checked_in / in_progress / completed / cancelled / no_show |
| cancel_reason | 取消原因 | String | 否 | |
| cancel_time | 取消时间 | Timestamp | 否 | |
| check_in_time | 签到时间 | Timestamp | 否 | |
| start_treatment_time | 开始治疗时间 | Timestamp | 否 | |
| end_treatment_time | 结束治疗时间 | Timestamp | 否 | |
| is_first_visit | 是否初诊 | Boolean | 是 | |
| is_online_booking | 是否在线预约 | Boolean | 是 | |
| source | 预约来源 | Enum | 是 | walk_in / phone / online / whatsapp / line |
| reminder_sent | 是否已发提醒 | Boolean | 是 | 默认 false |
| reminder_sent_at | 提醒发送时间 | Timestamp | 否 | |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

---

## 四、病历与牙位图域

### 15. DentalChart (牙位图)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | 每个患者一个牙位图 |
| chart_type | 牙位图类型 | Enum | 是 | adult(成人32颗) / child(儿童20颗) |
| last_updated_at | 最后更新时间 | Timestamp | 否 | |
| last_updated_by | 最后更新人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 16. ToothRecord (牙齿记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| dental_chart_id | 所属牙位图 | UUID | 是 | |
| tooth_number | 牙位号(FDI编码) | String | 是 | 如 11/12/21 等 |
| tooth_name | 牙齿名称 | String | 否 | |
| quadrant | 象限 | Integer | 是 | 1-4 |
| is_deciduous | 是否乳牙 | Boolean | 是 | |
| current_status | 当前状态 | Enum | 是 | healthy / decayed / missing / filled / crowned / bridged / implant / root_canal / extracted / impacted / fractured |
| surface_conditions | 牙面状态 | JSON | 否 | {mesial, distal, buccal, lingual, occlusal} |
| mobility_grade | 松动度 | Integer | 否 | 0-3 |
| periodontal_pocket_depth | 牙周袋深度 | Decimal | 否 | 单位: mm |
| notes | 备注 | String | 否 | |
| last_treatment_date | 最后治疗日期 | Date | 否 | |
| last_treatment_type | 最后治疗类型 | String | 否 | |
| updated_at | 更新时间 | Timestamp | 是 | |
| updated_by | 更新人 | UUID | 是 | |

### 17. ClinicalImage (临床影像)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| image_type | 影像类型 | Enum | 是 | intraoral_photo / periapical_xray / panoramic_xray / cbct / cephalometric / other |
| file_url | 文件地址 | String | 是 | |
| thumbnail_url | 缩略图地址 | String | 否 | |
| file_size_bytes | 文件大小(字节) | Long | 是 | |
| file_format | 文件格式 | Enum | 是 | jpg / png / dicom |
| original_filename | 原始文件名 | String | 是 | |
| title | 影像标题 | String | 否 | |
| description | 描述 | String | 否 | |
| capture_date | 拍摄日期 | Date | 否 | |
| capture_device | 拍摄设备 | String | 否 | |
| appointment_id | 关联预约 | UUID | 否 | |
| treatment_record_id | 关联治疗记录 | UUID | 否 | |
| annotations | 标注数据 | JSON | 否 | |
| is_before_treatment | 是否治疗前照片 | Boolean | 否 | 用于术前术后对比 |
| paired_image_id | 配对影像 | UUID | 否 | 配对的治疗后照片 ID |
| uploaded_by | 上传人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 18. ImageToothLink (影像-牙位关联)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| image_id | 影像 | UUID | 是 | |
| tooth_record_id | 牙齿记录 | UUID | 是 | |
| tooth_number | 牙位号(FDI编码) | String | 是 | |
| region | 影像区域 | Enum | 是 | full_mouth / upper_jaw / lower_jaw / quadrant_1 / quadrant_2 / quadrant_3 / quadrant_4 / specific_tooth |
| notes | 备注 | String | 否 | |

### 19. MedicalRecord (病历)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| appointment_id | 关联预约 | UUID | 否 | |
| doctor_id | 医生 | UUID | 是 | |
| record_no | 病历编号 | String | 是 | 租户内唯一 |
| record_date | 就诊日期 | Date | 是 | |
| chief_complaint | 主诉 | String | 否 | |
| present_illness | 现病史 | String | 否 | |
| past_medical_history | 既往史 | String | 否 | |
| examination_findings | 检查所见 | String | 否 | |
| diagnosis | 诊断 | List\<String\> | 否 | |
| diagnosis_codes | 诊断编码 | List\<String\> | 否 | ICD-10 编码 |
| treatment_record_ids | 关联治疗记录 | List\<UUID\> | 否 | |
| prescription | 处方/医嘱 | String | 否 | |
| doctor_advice | 医嘱 | String | 否 | |
| follow_up_required | 是否需要随访 | Boolean | 否 | |
| follow_up_date | 建议随访日期 | Date | 否 | |
| template_id | 使用的模板 | UUID | 否 | 关联 MedicalRecordTemplate |
| status | 状态 | Enum | 是 | draft / signed / amended |
| signed_by | 签名医生 | UUID | 否 | |
| signed_at | 签名时间 | Timestamp | 否 | |
| amended_reason | 修改原因 | String | 否 | 状态为 amended 时填写 |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 20. TreatmentRecord (治疗记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| medical_record_id | 所属病历 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| doctor_id | 医生 | UUID | 是 | |
| appointment_id | 关联预约 | UUID | 否 | |
| treatment_plan_id | 关联治疗方案 | UUID | 否 | |
| treatment_plan_step_id | 关联方案步骤 | UUID | 否 | |
| tooth_numbers | 涉及牙位 | List\<String\> | 否 | FDI 编码列表 |
| treatment_type | 治疗类型 | String | 是 | |
| treatment_detail | 治疗详情 | String | 否 | |
| materials_used | 使用材料 | List\<Object\> | 否 | 含名称、数量、批号 |
| before_image_ids | 治疗前影像 | List\<UUID\> | 否 | |
| after_image_ids | 治疗后影像 | List\<UUID\> | 否 | |
| duration_minutes | 耗时(分钟) | Integer | 否 | |
| anesthesia_type | 麻醉方式 | String | 否 | |
| complications | 并发症 | String | 否 | |
| notes | 备注 | String | 否 | |
| fee_amount | 费用 | Decimal | 否 | |
| status | 状态 | Enum | 是 | planned / in_progress / completed / cancelled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 21. TreatmentPlan (治疗方案)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| doctor_id | 医生 | UUID | 是 | |
| plan_name | 方案名称 | String | 是 | |
| description | 描述 | String | 否 | |
| total_estimated_cost | 预估总费用 | Decimal | 否 | |
| currency | 货币 | String | 是 | ISO 4217 |
| total_steps | 总步骤数 | Integer | 是 | |
| completed_steps | 已完成步骤 | Integer | 是 | 默认 0 |
| status | 状态 | Enum | 是 | draft / proposed / accepted / in_progress / completed / cancelled / suspended |
| patient_consent | 患者是否同意 | Boolean | 否 | |
| consent_date | 同意日期 | Date | 否 | |
| consent_signature_url | 签名图片 | String | 否 | |
| start_date | 开始日期 | Date | 否 | |
| estimated_end_date | 预估结束日期 | Date | 否 | |
| actual_end_date | 实际结束日期 | Date | 否 | |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 22. TreatmentPlanStep (治疗方案步骤)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| treatment_plan_id | 所属治疗方案 | UUID | 是 | |
| step_number | 步骤序号 | Integer | 是 | |
| step_name | 步骤名称 | String | 是 | |
| description | 描述 | String | 否 | |
| tooth_numbers | 涉及牙位 | List\<String\> | 否 | FDI 编码列表 |
| treatment_type | 治疗类型 | String | 是 | |
| estimated_cost | 预估费用 | Decimal | 否 | |
| actual_cost | 实际费用 | Decimal | 否 | |
| estimated_duration_minutes | 预估耗时(分钟) | Integer | 否 | |
| scheduled_date | 计划日期 | Date | 否 | |
| actual_date | 实际完成日期 | Date | 否 | |
| appointment_id | 关联预约 | UUID | 否 | |
| treatment_record_id | 关联治疗记录 | UUID | 否 | |
| status | 状态 | Enum | 是 | pending / scheduled / in_progress / completed / skipped / cancelled |
| notes | 备注 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 23. MedicalRecordTemplate (病历模板)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| template_name | 模板名称 | String | 是 | |
| template_type | 模板类型 | Enum | 是 | general / specialty |
| specialty | 适用专科 | String | 否 | |
| content_template | 模板内容 | JSON | 是 | 结构化模板 |
| is_system | 是否系统预设 | Boolean | 是 | |
| usage_count | 使用次数 | Integer | 是 | 默认 0 |
| status | 状态 | Enum | 是 | active / disabled |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

---

## 五、收费与财务域

### 24. FeeItem (收费项目)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 项目名称 | String | 是 | |
| code | 项目编码 | String | 是 | 租户内唯一 |
| category | 类别 | Enum | 是 | 检查 / 治疗 / 手术 / 材料 / 其他 |
| description | 描述 | String | 否 | |
| default_price | 默认价格 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| unit | 单位 | Enum | 是 | 次 / 颗 / 颌 / 全口 |
| is_package | 是否套餐 | Boolean | 是 | |
| package_items | 套餐明细 | List\<Object\> | 否 | 仅 is_package=true 时有值 |
| insurance_code | 保险编码 | String | 否 | |
| tax_rate | 税率 | Decimal | 否 | |
| status | 状态 | Enum | 是 | active / disabled |
| sort_order | 排序号 | Integer | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 25. PriceList (价目表)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 价目表名称 | String | 是 | |
| description | 描述 | String | 否 | |
| effective_from | 生效开始日期 | Date | 是 | |
| effective_to | 生效结束日期 | Date | 否 | |
| is_default | 是否默认 | Boolean | 是 | |
| status | 状态 | Enum | 是 | active / expired / draft |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 26. PriceListItem (价目表明细)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| price_list_id | 所属价目表 | UUID | 是 | |
| fee_item_id | 收费项目 | UUID | 是 | |
| price | 价格 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| member_price | 会员价 | Decimal | 否 | |
| notes | 备注 | String | 否 | |

### 27. BillingRecord (收费记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| bill_no | 账单编号 | String | 是 | 全局唯一 |
| patient_id | 患者 | UUID | 是 | |
| appointment_id | 关联预约 | UUID | 否 | |
| treatment_plan_id | 关联治疗方案 | UUID | 否 | |
| doctor_id | 医生 | UUID | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| subtotal | 小计 | Decimal | 是 | |
| discount_type | 折扣类型 | Enum | 是 | none / percentage / fixed / member / coupon |
| discount_value | 折扣值 | Decimal | 否 | 百分比或固定金额 |
| discount_amount | 折扣金额 | Decimal | 否 | 实际折扣金额 |
| tax_amount | 税额 | Decimal | 否 | |
| total_amount | 应收总额 | Decimal | 是 | |
| paid_amount | 已收金额 | Decimal | 是 | 默认 0 |
| outstanding_amount | 欠费金额 | Decimal | 是 | |
| member_points_earned | 获得积分 | Integer | 否 | |
| member_points_used | 使用积分 | Integer | 否 | |
| stored_value_used | 使用储值金额 | Decimal | 否 | |
| coupon_id | 使用优惠券 | UUID | 否 | |
| payment_status | 支付状态 | Enum | 是 | pending / partial / paid / overdue / refunded / written_off |
| is_installment | 是否分期 | Boolean | 是 | 默认 false |
| installment_plan_id | 分期计划 | UUID | 否 | |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 28. BillingItem (收费明细)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| billing_record_id | 所属收费记录 | UUID | 是 | |
| fee_item_id | 收费项目 | UUID | 是 | |
| name | 项目名称 | String | 是 | 冗余存储 |
| tooth_numbers | 涉及牙位 | List\<String\> | 否 | FDI 编码 |
| quantity | 数量 | Integer | 是 | |
| unit | 单位 | String | 是 | |
| unit_price | 单价 | Decimal | 是 | |
| discount_rate | 单项折扣率 | Decimal | 否 | 如 0.9 表示九折 |
| subtotal | 小计 | Decimal | 是 | |
| notes | 备注 | String | 否 | |

### 29. Payment (支付记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| billing_record_id | 关联收费记录 | UUID | 是 | |
| payment_no | 支付流水号 | String | 是 | 全局唯一 |
| amount | 支付金额 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| payment_method | 支付方式 | Enum | 是 | cash / card / grabpay / gcash / ovo / bank_transfer / stored_value / insurance / other |
| payment_channel | 支付渠道详情 | String | 否 | |
| transaction_id | 第三方交易号 | String | 否 | |
| payment_time | 支付时间 | Timestamp | 是 | |
| status | 状态 | Enum | 是 | success / failed / pending / refunded |
| refund_amount | 退款金额 | Decimal | 否 | 默认 0 |
| refund_reason | 退款原因 | String | 否 | |
| refund_time | 退款时间 | Timestamp | 否 | |
| receipt_number | 收据号 | String | 否 | |
| operator_id | 操作人 | UUID | 是 | |
| notes | 备注 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 30. Receivable (应收账款)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| billing_record_id | 关联收费记录 | UUID | 是 | |
| original_amount | 原始欠款 | Decimal | 是 | |
| outstanding_amount | 当前欠款余额 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| due_date | 到期日 | Date | 是 | |
| overdue_days | 逾期天数 | Integer | 否 | 计算值 |
| status | 状态 | Enum | 是 | pending / partial_paid / paid / overdue / written_off |
| last_reminder_sent_at | 最后催款时间 | Timestamp | 否 | |
| reminder_count | 催款次数 | Integer | 否 | 默认 0 |
| credit_limit | 信用额度 | Decimal | 否 | |
| notes | 备注 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 31. InstallmentPlan (分期计划)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| billing_record_id | 关联收费记录 | UUID | 是 | |
| total_amount | 总金额 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| installment_count | 总期数 | Integer | 是 | |
| paid_count | 已还期数 | Integer | 是 | 默认 0 |
| frequency | 频率 | Enum | 是 | monthly / biweekly / weekly |
| start_date | 开始日期 | Date | 是 | |
| next_due_date | 下次还款日 | Date | 否 | |
| status | 状态 | Enum | 是 | active / completed / overdue / cancelled |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 32. InstallmentPayment (分期还款记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| installment_plan_id | 所属分期计划 | UUID | 是 | |
| installment_number | 期数 | Integer | 是 | 第几期 |
| due_date | 应还日期 | Date | 是 | |
| due_amount | 应还金额 | Decimal | 是 | |
| paid_amount | 实际还款金额 | Decimal | 否 | |
| paid_date | 实际还款日期 | Date | 否 | |
| payment_id | 关联支付记录 | UUID | 否 | |
| status | 状态 | Enum | 是 | pending / paid / overdue / partial |
| reminder_sent | 是否已发提醒 | Boolean | 是 | 默认 false |
| created_at | 创建时间 | Timestamp | 是 | |

---

## 六、会员域

### 33. MemberLevel (会员等级配置)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| level_name | 等级名称 | String | 是 | 如: 普通 / 银卡 / 金卡 / 铂金 |
| level_code | 等级编码 | String | 是 | 租户内唯一 |
| level_icon | 等级图标 | String | 否 | |
| min_spending | 升级最低累计消费 | Decimal | 是 | |
| discount_rate | 折扣率 | Decimal | 是 | 如 0.95 表示 95 折 |
| points_multiplier | 积分倍率 | Decimal | 是 | 如 1.5 表示 1.5 倍积分 |
| free_items | 免费项目列表 | List\<String\> | 否 | |
| privileges | 特权描述 | String | 否 | |
| color | 等级颜色 | String | 否 | 用于前端展示 |
| sort_order | 排序号 | Integer | 是 | |
| status | 状态 | Enum | 是 | active / disabled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 34. MemberCard (会员卡)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| card_no | 会员卡号 | String | 是 | 租户内唯一 |
| level_id | 当前等级 | UUID | 是 | 关联 MemberLevel |
| join_date | 入会日期 | Date | 是 | |
| expiry_date | 到期日期 | Date | 否 | |
| total_points | 当前积分 | Integer | 是 | 默认 0 |
| total_spending | 累计消费 | Decimal | 是 | 默认 0 |
| stored_balance | 储值余额 | Decimal | 是 | 默认 0 |
| stored_currency | 储值货币 | String | 是 | ISO 4217 |
| status | 状态 | Enum | 是 | active / expired / frozen / cancelled |
| activated_by | 激活人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 35. PointsTransaction (积分流水)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| member_card_id | 会员卡 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| type | 类型 | Enum | 是 | earn / redeem / expire / adjust |
| points | 积分变动 | Integer | 是 | 正数为获得，负数为消耗 |
| balance_after | 变动后余额 | Integer | 是 | |
| source | 来源 | Enum | 是 | consumption / sign_in / referral / promotion / manual_adjust / redeem / expiry |
| reference_type | 关联业务类型 | String | 否 | 如 BillingRecord |
| reference_id | 关联业务 ID | UUID | 否 | |
| description | 描述 | String | 否 | |
| operator_id | 操作人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 36. StoredValueTransaction (储值流水)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| member_card_id | 会员卡 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| type | 类型 | Enum | 是 | recharge / consume / refund / adjust |
| amount | 金额 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| balance_after | 变动后余额 | Decimal | 是 | |
| payment_method | 充值时支付方式 | String | 否 | 仅 recharge 时有值 |
| reference_type | 关联业务类型 | String | 否 | |
| reference_id | 关联业务 ID | UUID | 否 | |
| description | 描述 | String | 否 | |
| operator_id | 操作人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 37. MemberPackage (会员套餐配置)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| package_name | 套餐名称 | String | 是 | |
| description | 描述 | String | 否 | |
| original_price | 原价 | Decimal | 是 | |
| selling_price | 售价 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| included_items | 包含项目 | List\<Object\> | 是 | 含名称、次数 |
| total_usage_count | 总可用次数 | Integer | 是 | |
| validity_days | 有效天数 | Integer | 是 | |
| applicable_levels | 适用会员等级 | List\<String\> | 否 | 空表示全部等级 |
| status | 状态 | Enum | 是 | active / disabled / sold_out |
| max_sell_count | 最大销售数量 | Integer | 否 | 0 表示不限 |
| sold_count | 已售数量 | Integer | 是 | 默认 0 |
| sort_order | 排序号 | Integer | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 38. MemberPackageInstance (会员套餐实例)

> 患者购买的套餐

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| member_card_id | 会员卡 | UUID | 是 | |
| package_id | 套餐 | UUID | 是 | 关联 MemberPackage |
| purchase_date | 购买日期 | Date | 是 | |
| expiry_date | 到期日期 | Date | 是 | |
| remaining_count | 剩余次数 | Integer | 是 | |
| remaining_items | 剩余明细 | JSON | 是 | 各项目剩余次数 |
| payment_id | 关联支付记录 | UUID | 否 | |
| status | 状态 | Enum | 是 | active / used_up / expired / refunded |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 39. PackageUsageRecord (套餐使用记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| package_instance_id | 套餐实例 | UUID | 是 | |
| item_name | 使用项目名称 | String | 是 | |
| appointment_id | 关联预约 | UUID | 否 | |
| used_date | 使用日期 | Date | 是 | |
| used_by | 操作人 | UUID | 是 | |
| notes | 备注 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |

---

## 七、随访域

### 40. FollowUpPlan (随访计划)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| doctor_id | 医生 | UUID | 是 | |
| appointment_id | 关联原始预约 | UUID | 否 | |
| treatment_record_id | 关联治疗记录 | UUID | 否 | |
| plan_type | 计划类型 | Enum | 是 | post_treatment / periodic_cleaning / orthodontic_check / implant_check / other |
| plan_name | 计划名称 | String | 是 | |
| description | 描述 | String | 否 | |
| reminder_channel | 提醒渠道 | Enum | 是 | whatsapp / line / sms / email / multi |
| status | 状态 | Enum | 是 | active / completed / cancelled |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 41. FollowUpTask (随访任务)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| follow_up_plan_id | 所属随访计划 | UUID | 是 | |
| task_number | 第几次随访 | Integer | 是 | |
| scheduled_date | 计划日期 | Date | 是 | |
| actual_date | 实际日期 | Date | 否 | |
| reminder_days_before | 提前几天提醒 | Integer | 是 | |
| reminder_sent | 是否已发送 | Boolean | 是 | 默认 false |
| reminder_sent_at | 提醒发送时间 | Timestamp | 否 | |
| appointment_id | 已预约的复诊 | UUID | 否 | |
| result | 结果 | Enum | 是 | pending / completed / no_show / rescheduled / cancelled |
| patient_feedback | 患者反馈 | String | 否 | |
| notes | 备注 | String | 否 | |
| completed_by | 完成人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 42. FollowUpTemplate (随访模板)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| template_name | 模板名称 | String | 是 | |
| treatment_type | 适用治疗类型 | String | 是 | |
| tasks | 任务模板列表 | JSON | 是 | [{days_after, description, reminder_days_before}] |
| is_system | 是否系统预设 | Boolean | 是 | |
| status | 状态 | Enum | 是 | active / disabled |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 43. NotificationRecord (通知记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| patient_id | 患者 | UUID | 是 | |
| channel | 发送渠道 | Enum | 是 | whatsapp / line / sms / email / in_app |
| template_id | 通知模板 | UUID | 否 | |
| recipient | 接收人联系方式 | String | 是 | 电话或邮箱 |
| subject | 标题 | String | 否 | |
| content | 内容 | String | 是 | |
| purpose | 用途 | Enum | 是 | appointment_reminder / follow_up / overdue_payment / membership_expiry / package_expiry / general |
| reference_type | 关联业务类型 | String | 否 | |
| reference_id | 关联业务 ID | UUID | 否 | |
| status | 状态 | Enum | 是 | pending / sent / delivered / failed / read |
| sent_at | 发送时间 | Timestamp | 否 | |
| delivered_at | 送达时间 | Timestamp | 否 | |
| read_at | 阅读时间 | Timestamp | 否 | |
| failure_reason | 失败原因 | String | 否 | |
| retry_count | 重试次数 | Integer | 否 | 默认 0 |
| created_at | 创建时间 | Timestamp | 是 | |

### 44. NotificationTemplate (通知模板)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 模板名称 | String | 是 | |
| channel | 渠道 | Enum | 是 | whatsapp / line / sms / email / in_app |
| purpose | 用途 | Enum | 是 | appointment_reminder / follow_up / overdue_payment / membership_expiry / package_expiry / general |
| subject_template | 标题模板 | String | 否 | |
| content_template | 内容模板 | String | 是 | 支持变量占位符，如 {{patient_name}} |
| language | 语言 | String | 是 | |
| is_system | 是否系统预设 | Boolean | 是 | |
| status | 状态 | Enum | 是 | active / disabled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

---

## 八、仓储域

### 45. Warehouse (仓库)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 仓库名称 | String | 是 | |
| code | 仓库编码 | String | 是 | 租户内唯一 |
| type | 仓库类型 | Enum | 是 | main / sub / clinical |
| address | 地址 | String | 否 | |
| area_sqm | 面积(平方米) | Decimal | 否 | |
| temperature_controlled | 是否恒温 | Boolean | 是 | |
| manager_id | 仓库管理员 | UUID | 否 | |
| status | 状态 | Enum | 是 | active / disabled |
| created_by | 创建人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 46. WarehouseLocation (库位)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| warehouse_id | 所属仓库 | UUID | 是 | |
| name | 库位名称 | String | 是 | |
| code | 库位编码 | String | 是 | 仓库内唯一 |
| zone | 区域 | String | 否 | A / B / C |
| shelf | 货架号 | String | 否 | |
| layer | 层 | String | 否 | |
| max_weight_kg | 最大承重(kg) | Decimal | 否 | |
| temperature_zone | 温度区 | Enum | 否 | 常温 / 冷藏 / 冷冻 |
| current_occupancy | 当前占用率 | Decimal | 否 | 百分比 |
| status | 状态 | Enum | 是 | active / disabled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 47. Product (产品/耗材)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 产品名称 | String | 是 | |
| code | 产品编码 | String | 是 | 租户内唯一 |
| category_id | 类别 | UUID | 是 | 关联 ProductCategory |
| brand | 品牌 | String | 否 | |
| specification | 规格 | String | 否 | |
| unit | 单位 | String | 是 | 如: 个/瓶/盒/支 |
| barcode | 条形码 | String | 否 | |
| origin_country | 原产国 | String | 否 | |
| manufacturer | 生产厂家 | String | 否 | |
| registration_number | 注册证号 | String | 否 | |
| storage_conditions | 储存条件 | String | 否 | |
| is_imported | 是否进口 | Boolean | 否 | |
| import_license | 进口许可证 | String | 否 | |
| tax_category | 税务类别 | String | 否 | |
| purchase_price | 参考采购价 | Decimal | 否 | |
| selling_price | 参考售价 | Decimal | 否 | |
| price_currency | 价格货币 | String | 否 | ISO 4217 |
| weight | 重量 | Decimal | 否 | |
| dimensions | 尺寸 | String | 否 | |
| min_stock | 最低库存 | Integer | 否 | 低于此值预警 |
| max_stock | 最高库存 | Integer | 否 | |
| expiry_alert_days | 过期预警天数 | Integer | 否 | |
| is_for_clinical | 是否诊室用 | Boolean | 是 | |
| is_for_sale | 是否可商城销售 | Boolean | 是 | |
| image_url | 产品图片 | String | 否 | |
| description | 描述 | String | 否 | |
| status | 状态 | Enum | 是 | active / disabled / discontinued |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 48. ProductCategory (产品类别)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 类别名称 | String | 是 | |
| code | 类别编码 | String | 是 | |
| parent_id | 上级类别 | UUID | 否 | 支持树形结构 |
| sort_order | 排序号 | Integer | 是 | |
| status | 状态 | Enum | 是 | active / disabled |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 49. StockRecord (库存记录)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| product_id | 产品 | UUID | 是 | |
| warehouse_id | 仓库 | UUID | 是 | |
| location_id | 库位 | UUID | 否 | |
| batch_number | 批号 | String | 否 | |
| quantity | 数量 | Integer | 是 | |
| reserved_quantity | 预留数量 | Integer | 否 | 已下单未出库，默认 0 |
| available_quantity | 可用数量 | Integer | 是 | quantity - reserved_quantity |
| unit | 单位 | String | 是 | |
| cost_price | 成本价 | Decimal | 否 | |
| expiry_date | 有效期 | Date | 否 | |
| last_check_date | 最近盘点日期 | Date | 否 | |
| status | 状态 | Enum | 是 | normal / low / expired / frozen |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 50. StockMovement (库存变动)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| movement_no | 单据编号 | String | 是 | |
| product_id | 产品 | UUID | 是 | |
| warehouse_id | 仓库 | UUID | 是 | |
| location_id | 库位 | UUID | 否 | |
| type | 变动类型 | Enum | 是 | in / out / transfer / adjust / return |
| quantity | 数量 | Integer | 是 | 正数入库，负数出库 |
| batch_number | 批号 | String | 否 | |
| reference_type | 关联业务类型 | String | 否 | 如 PurchaseOrder、TreatmentRecord |
| reference_id | 关联业务 ID | UUID | 否 | |
| reason | 原因 | String | 否 | |
| approved_by | 审批人 | UUID | 否 | |
| cost_amount | 成本金额 | Decimal | 否 | |
| cost_currency | 成本货币 | String | 否 | ISO 4217 |
| operator_id | 操作人 | UUID | 是 | |
| created_at | 创建时间 | Timestamp | 是 | |

### 51. Supplier (供应商)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| name | 供应商名称 | String | 是 | |
| code | 供应商编码 | String | 是 | 租户内唯一 |
| contact_person | 联系人 | String | 否 | |
| phone | 电话 | String | 否 | |
| email | 邮箱 | String | 否 | |
| address | 地址 | String | 否 | |
| tax_id | 税号 | String | 否 | |
| bank_name | 开户行 | String | 否 | |
| bank_account | 银行账号 | String | 否 | |
| payment_method | 偏好付款方式 | String | 否 | |
| lead_time_days | 交期(天) | Integer | 否 | |
| min_order_amount | 最小起订金额 | Decimal | 否 | |
| currency | 货币 | String | 否 | ISO 4217 |
| contract_start | 合同开始日期 | Date | 否 | |
| contract_end | 合同结束日期 | Date | 否 | |
| qualification_docs | 资质文件列表 | List\<String\> | 否 | 文件地址 |
| is_domestic | 是否本地供应商 | Boolean | 否 | |
| country | 所在国家 | String | 否 | |
| rating | 评级 | String | 否 | |
| notes | 备注 | String | 否 | |
| status | 状态 | Enum | 是 | active / disabled / blacklisted |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 52. PurchaseOrder (采购订单)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| order_no | 订单编号 | String | 是 | 租户内唯一 |
| supplier_id | 供应商 | UUID | 是 | |
| warehouse_id | 入库仓库 | UUID | 是 | |
| order_date | 下单日期 | Date | 是 | |
| expected_delivery_date | 预计到货日期 | Date | 否 | |
| actual_delivery_date | 实际到货日期 | Date | 否 | |
| total_amount | 总金额 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| shipping_method | 运输方式 | String | 否 | |
| shipping_cost | 运费 | Decimal | 否 | |
| tax_amount | 税额 | Decimal | 否 | |
| payment_status | 付款状态 | Enum | 是 | unpaid / partial / paid |
| payment_due_date | 付款截止日 | Date | 否 | |
| status | 状态 | Enum | 是 | draft / submitted / approved / receiving / completed / cancelled |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| approved_by | 审批人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 53. PurchaseOrderItem (采购订单明细)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| purchase_order_id | 所属采购订单 | UUID | 是 | |
| product_id | 产品 | UUID | 是 | |
| quantity | 采购数量 | Integer | 是 | |
| received_quantity | 已收数量 | Integer | 是 | 默认 0 |
| unit_price | 单价 | Decimal | 是 | |
| subtotal | 小计 | Decimal | 是 | |
| batch_number | 批号 | String | 否 | |
| expiry_date | 有效期 | Date | 否 | |
| inspection_result | 验收结果 | Enum | 否 | passed / failed / pending |
| inspection_notes | 验收备注 | String | 否 | |
| notes | 备注 | String | 否 | |

### 54. InventoryCheck (库存盘点)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| check_no | 盘点单号 | String | 是 | |
| warehouse_id | 仓库 | UUID | 是 | |
| check_type | 盘点类型 | Enum | 是 | full / partial / spot |
| check_method | 盘点方式 | Enum | 是 | manual / barcode_scan |
| check_date | 盘点日期 | Date | 是 | |
| total_items | 盘点项数 | Integer | 否 | |
| difference_items | 差异项数 | Integer | 否 | |
| status | 状态 | Enum | 是 | in_progress / completed / cancelled |
| notes | 备注 | String | 否 | |
| created_by | 创建人 | UUID | 是 | |
| approved_by | 审批人 | UUID | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 55. InventoryCheckItem (盘点明细)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| inventory_check_id | 所属盘点单 | UUID | 是 | |
| product_id | 产品 | UUID | 是 | |
| location_id | 库位 | UUID | 否 | |
| batch_number | 批号 | String | 否 | |
| system_quantity | 系统数量 | Integer | 是 | |
| actual_quantity | 实际数量 | Integer | 是 | |
| difference | 差异 | Integer | 是 | actual_quantity - system_quantity |
| difference_reason | 差异原因 | Enum | 否 | 损耗 / 丢失 / 计量误差 / 其他 |
| adjustment_status | 调整状态 | Enum | 是 | pending / approved / rejected |
| notes | 备注 | String | 否 | |

---

## 九、商城域

### 56. MallProduct (商城商品)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| product_id | 关联产品 | UUID | 是 | 关联 Product |
| title | 商品标题 | String | 是 | |
| subtitle | 副标题 | String | 否 | |
| description | 描述 | String | 否 | |
| mall_images | 商城展示图列表 | List\<String\> | 否 | |
| specifications | 规格参数 | JSON | 否 | |
| price | 售价 | Decimal | 是 | |
| original_price | 原价 | Decimal | 否 | |
| currency | 货币 | String | 是 | ISO 4217 |
| stock_quantity | 可售库存 | Integer | 是 | |
| min_buy_quantity | 最小购买数量 | Integer | 否 | 默认 1 |
| max_buy_quantity | 最大购买数量 | Integer | 否 | 0 表示不限 |
| shipping_template_id | 运费模板 | UUID | 否 | |
| weight_for_shipping | 计费重量 | Decimal | 否 | |
| sales_count | 销量 | Integer | 否 | 默认 0 |
| sort_order | 排序号 | Integer | 是 | |
| is_featured | 是否推荐 | Boolean | 否 | |
| status | 状态 | Enum | 是 | on_sale / off_sale / sold_out |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 57. MallOrder (商城订单)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| tenant_id | 所属租户 | UUID | 是 | |
| order_no | 订单编号 | String | 是 | 全局唯一 |
| patient_id | 购买患者 | UUID | 是 | |
| buyer_name | 购买人姓名 | String | 是 | |
| buyer_phone | 购买人电话 | String | 是 | |
| buyer_email | 购买人邮箱 | String | 否 | |
| total_amount | 商品总额 | Decimal | 是 | |
| shipping_amount | 运费 | Decimal | 否 | |
| discount_amount | 优惠金额 | Decimal | 否 | |
| actual_amount | 实付金额 | Decimal | 是 | |
| currency | 货币 | String | 是 | ISO 4217 |
| payment_method | 支付方式 | String | 否 | |
| payment_time | 支付时间 | Timestamp | 否 | |
| delivery_method | 配送方式 | Enum | 是 | express / pickup / in_clinic |
| shipping_address | 收货地址 | String | 否 | |
| estimated_delivery_date | 预计送达日 | Date | 否 | |
| actual_delivery_date | 实际送达日 | Date | 否 | |
| tracking_number | 物流单号 | String | 否 | |
| express_company | 快递公司 | String | 否 | |
| cancel_reason | 取消原因 | String | 否 | |
| refund_amount | 退款金额 | Decimal | 否 | |
| status | 状态 | Enum | 是 | pending / paid / shipping / delivered / completed / cancelled / refunding / refunded |
| notes | 备注 | String | 否 | |
| created_at | 创建时间 | Timestamp | 是 | |
| updated_at | 更新时间 | Timestamp | 是 | |

### 58. MallOrderItem (商城订单明细)

| 属性 | 说明 | 类型 | 必填 | 备注 |
|------|------|------|------|------|
| id | 唯一标识 | UUID | 是 | |
| mall_order_id | 所属订单 | UUID | 是 | |
| mall_product_id | 商城商品 | UUID | 是 | |
| product_name | 商品名称 | String | 是 | 冗余存储 |
| quantity | 数量 | Integer | 是 | |
| unit_price | 单价 | Decimal | 是 | |
| subtotal | 小计 | Decimal | 是 | |
| item_status | 明细状态 | Enum | 是 | pending / shipped / delivered / returned |
| return_quantity | 退货数量 | Integer | 否 | 默认 0 |
| return_reason | 退货原因 | String | 否 | |
| notes | 备注 | String | 否 | |

---

## 实体关系

### 一、基础平台域

```
Tenant 1──N User        (一个租户拥有多个用户)
Tenant 1──N Role        (一个租户定义多个角色)
Tenant 1──N Department  (一个租户设置多个科室)
Tenant 1──N Room        (一个租户拥有多个诊室)
Tenant 1──N AuditLog    (一个租户产生多条操作日志)
User   1──N UserRole    (一个用户可拥有多个角色)
Role   1──N UserRole    (一个角色可分配给多个用户)
Department 1──N Department  (科室自关联，支持上下级)
Department 1──N Room        (一个科室包含多个诊室)
Department 0──1 User        (科室负责人关联用户)
User   1──N AuditLog    (一个用户产生多条操作日志)
```

### 二、患者域

```
Tenant      1──N Patient       (一个租户管理多个患者)
Tenant      1──N FamilyGroup   (一个租户拥有多个家庭组)
FamilyGroup 1──N FamilyMember  (一个家庭组包含多个成员)
FamilyGroup 0──1 Patient       (家庭组主联系人关联患者)
FamilyMember N──1 Patient      (家庭成员关联患者)
Patient     0──1 FamilyGroup   (患者可属于一个家庭组)
Patient     0──1 Patient       (推荐人自关联)
```

### 三、预约域

```
Tenant        1──N Doctor          (一个租户拥有多个医生)
Tenant        1──N DoctorSchedule  (一个租户定义多个排班)
Tenant        1──N Holiday         (一个租户配置多个节假日)
Tenant        1──N Appointment     (一个租户产生多个预约)
Doctor        1──1 User            (一个医生关联一个用户)
Doctor        0──1 Department      (医生可属于一个科室)
Doctor        1──N DoctorSchedule  (一个医生有多个排班)
Doctor        1──N Appointment     (一个医生有多个预约)
DoctorSchedule 0──1 Room           (排班可指定诊室)
Patient       1──N Appointment     (一个患者有多个预约)
Appointment   0──1 Room            (预约可指定诊室)
```

### 四、病历与牙位图域

```
Patient        1──1 DentalChart          (一个患者一个牙位图)
DentalChart    1──N ToothRecord          (一个牙位图包含多个牙齿记录)
Patient        1──N ClinicalImage        (一个患者有多张临床影像)
ClinicalImage  1──N ImageToothLink       (一张影像可关联多个牙位)
ToothRecord    1──N ImageToothLink       (一个牙齿记录可被多张影像关联)
Patient        1──N MedicalRecord        (一个患者有多份病历)
MedicalRecord  0──1 Appointment          (病历可关联一个预约)
MedicalRecord  1──N TreatmentRecord      (一份病历包含多个治疗记录)
Doctor         1──N MedicalRecord        (一个医生书写多份病历)
MedicalRecord  0──1 MedicalRecordTemplate (病历可使用模板)
Patient        1──N TreatmentPlan        (一个患者有多个治疗方案)
Doctor         1──N TreatmentPlan        (一个医生创建多个治疗方案)
TreatmentPlan  1──N TreatmentPlanStep    (一个治疗方案包含多个步骤)
TreatmentPlanStep 0──1 Appointment       (方案步骤可关联预约)
TreatmentPlanStep 0──1 TreatmentRecord   (方案步骤可关联治疗记录)
TreatmentRecord 0──1 TreatmentPlan       (治疗记录可关联治疗方案)
TreatmentRecord 0──1 TreatmentPlanStep   (治疗记录可关联方案步骤)
TreatmentRecord 0──1 Appointment         (治疗记录可关联预约)
ClinicalImage   0──1 Appointment         (影像可关联预约)
ClinicalImage   0──1 TreatmentRecord     (影像可关联治疗记录)
ClinicalImage   0──1 ClinicalImage       (治疗前后照片配对)
Tenant          1──N MedicalRecordTemplate (租户定义多个病历模板)
```

### 五、收费与财务域

```
Tenant         1──N FeeItem            (一个租户定义多个收费项目)
Tenant         1──N PriceList          (一个租户拥有多个价目表)
PriceList      1──N PriceListItem      (一个价目表包含多个明细)
PriceListItem  N──1 FeeItem            (价目表明细关联收费项目)
Tenant         1──N BillingRecord      (一个租户产生多个收费记录)
Patient        1──N BillingRecord      (一个患者有多个收费记录)
BillingRecord  0──1 Appointment        (收费记录可关联预约)
BillingRecord  0──1 TreatmentPlan      (收费记录可关联治疗方案)
BillingRecord  1──N BillingItem        (一个收费记录包含多个明细)
BillingItem    N──1 FeeItem            (收费明细关联收费项目)
BillingRecord  1──N Payment            (一个收费记录可有多笔支付)
Patient        1──N Receivable         (一个患者可有多笔应收)
Receivable     N──1 BillingRecord      (应收账款关联收费记录)
Patient        1──N InstallmentPlan    (一个患者可有多个分期计划)
InstallmentPlan N──1 BillingRecord     (分期计划关联收费记录)
InstallmentPlan 1──N InstallmentPayment (一个分期计划包含多笔还款)
InstallmentPayment 0──1 Payment        (分期还款可关联支付记录)
BillingRecord  0──1 InstallmentPlan    (收费记录可关联分期计划)
```

### 六、会员域

```
Tenant              1──N MemberLevel          (一个租户配置多个会员等级)
Tenant              1──N MemberPackage        (一个租户配置多个会员套餐)
Patient             1──1 MemberCard           (一个患者一张会员卡)
MemberCard          N──1 MemberLevel          (会员卡关联会员等级)
MemberCard          1──N PointsTransaction    (一张会员卡有多笔积分流水)
MemberCard          1──N StoredValueTransaction (一张会员卡有多笔储值流水)
MemberCard          1──N MemberPackageInstance (一张会员卡可购买多个套餐)
MemberPackageInstance N──1 MemberPackage      (套餐实例关联套餐配置)
MemberPackageInstance 1──N PackageUsageRecord  (一个套餐实例有多条使用记录)
MemberPackageInstance 0──1 Payment            (套餐购买可关联支付记录)
PackageUsageRecord  0──1 Appointment          (套餐使用可关联预约)
```

### 七、随访域

```
Tenant           1──N FollowUpPlan        (一个租户有多个随访计划)
Tenant           1──N FollowUpTemplate    (一个租户配置多个随访模板)
Tenant           1──N NotificationTemplate (一个租户配置多个通知模板)
Patient          1──N FollowUpPlan        (一个患者有多个随访计划)
Doctor           1──N FollowUpPlan        (一个医生创建多个随访计划)
FollowUpPlan     0──1 Appointment         (随访计划可关联原始预约)
FollowUpPlan     0──1 TreatmentRecord     (随访计划可关联治疗记录)
FollowUpPlan     1──N FollowUpTask        (一个随访计划包含多个任务)
FollowUpTask     0──1 Appointment         (随访任务可关联复诊预约)
Patient          1──N NotificationRecord  (一个患者有多条通知记录)
NotificationRecord 0──1 NotificationTemplate (通知记录可使用模板)
```

### 八、仓储域

```
Tenant           1──N Warehouse           (一个租户拥有多个仓库)
Tenant           1──N Supplier            (一个租户管理多个供应商)
Tenant           1──N Product             (一个租户管理多个产品)
Tenant           1──N ProductCategory     (一个租户定义多个产品类别)
Warehouse        1──N WarehouseLocation   (一个仓库包含多个库位)
Warehouse        1──N StockRecord         (一个仓库有多条库存记录)
Warehouse        1──N StockMovement       (一个仓库有多条库存变动)
Warehouse        1──N InventoryCheck      (一个仓库进行多次盘点)
Product          N──1 ProductCategory     (产品归属类别)
Product          1──N StockRecord         (一个产品在多个仓库有库存)
Product          1──N StockMovement       (一个产品有多次库存变动)
ProductCategory  1──N ProductCategory     (类别自关联，支持上下级)
Supplier         1──N PurchaseOrder       (一个供应商有多个采购订单)
PurchaseOrder    1──N PurchaseOrderItem   (一个采购订单包含多个明细)
PurchaseOrderItem N──1 Product            (采购明细关联产品)
InventoryCheck   1──N InventoryCheckItem  (一次盘点包含多个明细)
InventoryCheckItem N──1 Product           (盘点明细关联产品)
InventoryCheckItem 0──1 WarehouseLocation (盘点明细可关联库位)
StockRecord      0──1 WarehouseLocation   (库存记录可关联库位)
```

### 九、商城域

```
Tenant          1──N MallProduct    (一个租户发布多个商城商品)
MallProduct     N──1 Product        (商城商品关联产品)
Patient         1──N MallOrder      (一个患者有多个商城订单)
MallOrder       1──N MallOrderItem  (一个订单包含多个明细)
MallOrderItem   N──1 MallProduct    (订单明细关联商城商品)
```

### 跨域核心关联

```
Doctor    N──1 User              (医生关联系统用户)
Doctor    0──1 Department        (医生可归属科室)
Appointment ──> MedicalRecord    (预约产生病历)
Appointment ──> BillingRecord    (预约产生收费)
Appointment ──> FollowUpPlan     (预约触发随访)
TreatmentRecord ──> StockMovement (治疗消耗库存)
MallOrder ──> Payment            (商城订单关联支付)
BillingRecord ──> MemberCard     (消费更新会员积分和等级)
```
