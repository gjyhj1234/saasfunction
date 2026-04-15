#!/usr/bin/env bash
# job_09_domain_model.sh — 生成底层模型
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/04-domain-model"
ensure_dir "$DOC_DIR"

write_doc "$DOC_DIR/domain-model.md" "# 领域模型

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}

## 核心实体

### Tenant (租户)
\`\`\`
Tenant {
  id: UUID [PK]
  name: string
  code: string [unique]
  status: enum(active, suspended, archived)
  plan: enum(free, basic, pro, enterprise)
  created_at: timestamp
  updated_at: timestamp
}
\`\`\`

### User (用户)
\`\`\`
User {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  username: string [unique per tenant]
  password_hash: string
  name: string
  phone: string
  email: string
  role_id: UUID [FK -> Role]
  status: enum(active, disabled)
  last_login_at: timestamp
  created_at: timestamp
  updated_at: timestamp
}
\`\`\`

### Role (角色)
\`\`\`
Role {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string
  permissions: jsonb
  is_system: boolean
  created_at: timestamp
}
\`\`\`

### Patient (患者)
\`\`\`
Patient {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  gender: enum(male, female, other)
  birth_date: date
  phone: string
  id_card: string (encrypted)
  address: string
  allergies: text
  medical_history: text
  tags: string[]
  source: enum(walk_in, referral, online)
  created_by: UUID [FK -> User]
  created_at: timestamp
  updated_at: timestamp
}
\`\`\`

### Doctor (医生)
\`\`\`
Doctor {
  id: UUID [PK]
  user_id: UUID [FK -> User]
  tenant_id: UUID [FK -> Tenant]
  title: string
  specialties: string[]
  license_number: string
  department_id: UUID [FK -> Department]
  status: enum(active, on_leave, resigned)
}
\`\`\`

### Appointment (预约)
\`\`\`
Appointment {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  patient_id: UUID [FK -> Patient]
  doctor_id: UUID [FK -> Doctor]
  room_id: UUID [FK -> Room]
  start_time: timestamp
  end_time: timestamp
  treatment_type: string
  status: enum(scheduled, confirmed, checked_in, in_progress, completed, cancelled, no_show)
  notes: text
  created_by: UUID [FK -> User]
  created_at: timestamp
  updated_at: timestamp
}
\`\`\`

### BillingRecord (收费记录)
\`\`\`
BillingRecord {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  patient_id: UUID [FK -> Patient]
  appointment_id: UUID [FK -> Appointment]
  items: BillingItem[]
  total_amount: decimal
  discount_amount: decimal
  paid_amount: decimal
  status: enum(pending, paid, partial, refunded)
  payment_method: enum(cash, card, wechat, alipay, insurance)
  created_by: UUID [FK -> User]
  created_at: timestamp
}
\`\`\`

### BillingItem (收费明细)
\`\`\`
BillingItem {
  id: UUID [PK]
  billing_id: UUID [FK -> BillingRecord]
  fee_item_id: UUID [FK -> FeeItem]
  name: string
  quantity: int
  unit_price: decimal
  subtotal: decimal
}
\`\`\`

### Department (科室)
\`\`\`
Department {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string
  status: enum(active, disabled)
}
\`\`\`

### Room (诊室)
\`\`\`
Room {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  department_id: UUID [FK -> Department]
  name: string
  code: string
  status: enum(available, occupied, maintenance)
}
\`\`\`

## 实体关系

\`\`\`
Tenant 1──N User
Tenant 1──N Patient
Tenant 1──N Role
Tenant 1──N Department
Tenant 1──N Room

User N──1 Role
User 1──1 Doctor (optional)

Patient 1──N Appointment
Doctor 1──N Appointment
Room 1──N Appointment

Patient 1──N BillingRecord
Appointment 1──1 BillingRecord (optional)
BillingRecord 1──N BillingItem

Department 1──N Room
Department 1──N Doctor
\`\`\`

## 索引策略

| 表 | 索引 | 类型 |
|----|------|------|
| Patient | (tenant_id, phone) | unique |
| Patient | (tenant_id, name) | btree |
| Appointment | (tenant_id, doctor_id, start_time) | btree |
| Appointment | (tenant_id, patient_id) | btree |
| Appointment | (tenant_id, status) | btree |
| BillingRecord | (tenant_id, patient_id) | btree |
| User | (tenant_id, username) | unique |
"

echo "$DOC_DIR/domain-model.md"
