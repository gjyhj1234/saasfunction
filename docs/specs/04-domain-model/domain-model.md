# 领域模型

> 生成时间: 2026-04-15T09:37:41Z
> 执行范围: mvp
> 目标市场: 东南亚 (Southeast Asia)

## 核心实体

### Tenant (租户)
```
Tenant {
  id: UUID [PK]
  name: string
  code: string [unique]
  country: string (ISO 3166-1 alpha-2)
  timezone: string (e.g. Asia/Bangkok)
  default_currency: string (ISO 4217)
  supported_currencies: string[]
  default_locale: string (e.g. en, th, vi)
  status: enum(active, suspended, archived)
  plan: enum(free, basic, pro, enterprise)
  created_at: timestamp
  updated_at: timestamp
}
```

### User (用户)
```
User {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  username: string [unique per tenant]
  password_hash: string
  name: string
  phone: string
  email: string
  preferred_locale: string
  role_id: UUID [FK -> Role]
  status: enum(active, disabled)
  last_login_at: timestamp
  created_at: timestamp
  updated_at: timestamp
}
```

### Role (角色)
```
Role {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string
  permissions: jsonb
  is_system: boolean
  created_at: timestamp
}
```

### Patient (患者)
```
Patient {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  gender: enum(male, female, other)
  birth_date: date
  phone: string
  email: string
  passport_number: string (encrypted, for dental tourism)
  address: string
  country: string
  preferred_language: string
  allergies: text
  medical_history: text
  tags: string[]
  source: enum(walk_in, referral, online, dental_tourism)
  created_by: UUID [FK -> User]
  created_at: timestamp
  updated_at: timestamp
}
```

### Doctor (医生)
```
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
```

### Appointment (预约)
```
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
```

### BillingRecord (收费记录)
```
BillingRecord {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  patient_id: UUID [FK -> Patient]
  appointment_id: UUID [FK -> Appointment]
  items: BillingItem[]
  currency: string (ISO 4217)
  total_amount: bigint (smallest unit)
  discount_amount: bigint
  paid_amount: bigint
  status: enum(pending, paid, partial, refunded)
  payment_method: enum(cash, card, grabpay, gcash, ovo, bank_transfer, other)
  created_by: UUID [FK -> User]
  created_at: timestamp
}
```

### BillingItem (收费明细)
```
BillingItem {
  id: UUID [PK]
  billing_id: UUID [FK -> BillingRecord]
  fee_item_id: UUID [FK -> FeeItem]
  name: string
  quantity: int
  unit_price: bigint (smallest currency unit)
  subtotal: bigint
}
```

### Department (科室)
```
Department {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string
  status: enum(active, disabled)
}
```

### Room (诊室)
```
Room {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  department_id: UUID [FK -> Department]
  name: string
  code: string
  status: enum(available, occupied, maintenance)
}
```

---

## 仓储管理实体

### Warehouse (仓库)
```
Warehouse {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string [unique per tenant]
  address: string
  manager_id: UUID [FK -> User]
  status: enum(active, disabled)
  created_at: timestamp
  updated_at: timestamp
}
```

### WarehouseLocation (库位)
```
WarehouseLocation {
  id: UUID [PK]
  warehouse_id: UUID [FK -> Warehouse]
  code: string (e.g. A-01-01)
  name: string
  capacity: int
  status: enum(active, disabled)
}
```

### Product (产品/耗材)
```
Product {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string [unique per tenant]
  barcode: string
  category_id: UUID [FK -> ProductCategory]
  brand: string
  unit: string (e.g. box, piece, bottle)
  spec: string (规格描述)
  is_for_sale: boolean (是否可在商城销售)
  min_stock: int (最低库存预警值)
  shelf_life_days: int (保质期天数, nullable)
  images: string[]
  description: text
  status: enum(active, disabled)
  created_at: timestamp
  updated_at: timestamp
}
```

### ProductCategory (产品分类)
```
ProductCategory {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  parent_id: UUID [FK -> ProductCategory, nullable]
  sort_order: int
  status: enum(active, disabled)
}
```

### StockRecord (库存记录 — 当前库存快照)
```
StockRecord {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  warehouse_id: UUID [FK -> Warehouse]
  location_id: UUID [FK -> WarehouseLocation, nullable]
  product_id: UUID [FK -> Product]
  batch_number: string
  expiry_date: date (nullable)
  quantity: int
  unit_cost: bigint (smallest currency unit)
  cost_currency: string (ISO 4217)
  updated_at: timestamp
}
```

### StockMovement (库存变动)
```
StockMovement {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  warehouse_id: UUID [FK -> Warehouse]
  product_id: UUID [FK -> Product]
  batch_number: string
  movement_type: enum(purchase_in, return_in, transfer_in, sales_out, usage_out, transfer_out, adjustment)
  quantity: int (正数入库, 负数出库)
  reference_type: string (e.g. purchase_order, mall_order, usage_request)
  reference_id: UUID
  operator_id: UUID [FK -> User]
  notes: text
  created_at: timestamp
}
```

### Supplier (供应商)
```
Supplier {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  name: string
  code: string
  contact_person: string
  phone: string
  email: string
  country: string
  address: string
  payment_terms: string
  rating: int (1-5)
  status: enum(active, disabled)
  created_at: timestamp
  updated_at: timestamp
}
```

### PurchaseOrder (采购订单)
```
PurchaseOrder {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  order_number: string [unique per tenant]
  supplier_id: UUID [FK -> Supplier]
  warehouse_id: UUID [FK -> Warehouse]
  currency: string (ISO 4217)
  total_amount: bigint
  status: enum(draft, pending_approval, approved, ordered, partial_received, received, cancelled)
  requested_by: UUID [FK -> User]
  approved_by: UUID [FK -> User, nullable]
  items: PurchaseOrderItem[]
  notes: text
  created_at: timestamp
  updated_at: timestamp
}
```

### PurchaseOrderItem (采购订单明细)
```
PurchaseOrderItem {
  id: UUID [PK]
  purchase_order_id: UUID [FK -> PurchaseOrder]
  product_id: UUID [FK -> Product]
  quantity: int
  unit_price: bigint
  received_quantity: int (default 0)
}
```

### InventoryCheck (库存盘点)
```
InventoryCheck {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  warehouse_id: UUID [FK -> Warehouse]
  check_number: string
  status: enum(draft, in_progress, completed, cancelled)
  operator_id: UUID [FK -> User]
  items: InventoryCheckItem[]
  notes: text
  created_at: timestamp
  completed_at: timestamp
}
```

---

## 商城实体

### MallProduct (商城商品 — 扩展自 Product)
```
MallProduct {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  product_id: UUID [FK -> Product]
  title: string (商城展示标题, 多语言)
  description: text (商城详细描述)
  selling_price: bigint (售价, smallest unit)
  currency: string
  sales_count: int
  is_published: boolean
  sort_order: int
  published_at: timestamp
}
```

### MallOrder (商城订单)
```
MallOrder {
  id: UUID [PK]
  tenant_id: UUID [FK -> Tenant]
  order_number: string [unique]
  customer_type: enum(patient, clinic)
  customer_id: UUID (Patient or Tenant)
  currency: string
  total_amount: bigint
  discount_amount: bigint
  shipping_fee: bigint
  paid_amount: bigint
  payment_method: string
  payment_status: enum(pending, paid, refunded)
  order_status: enum(pending, confirmed, shipping, delivered, completed, cancelled, returning)
  shipping_address: jsonb
  items: MallOrderItem[]
  notes: text
  created_at: timestamp
  updated_at: timestamp
}
```

### MallOrderItem (商城订单明细)
```
MallOrderItem {
  id: UUID [PK]
  order_id: UUID [FK -> MallOrder]
  mall_product_id: UUID [FK -> MallProduct]
  product_id: UUID [FK -> Product]
  sku_info: string
  quantity: int
  unit_price: bigint
  subtotal: bigint
}
```

---

## 实体关系

```
Tenant 1──N User
Tenant 1──N Patient
Tenant 1──N Role
Tenant 1──N Department
Tenant 1──N Room
Tenant 1──N Warehouse
Tenant 1──N ProductCategory
Tenant 1──N Product
Tenant 1──N Supplier

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

Warehouse 1──N WarehouseLocation
Warehouse 1──N StockRecord
Warehouse 1──N StockMovement
Warehouse 1──N PurchaseOrder

Product 1──N StockRecord
Product 1──N StockMovement
Product 1──1 MallProduct (optional)

Supplier 1──N PurchaseOrder
PurchaseOrder 1──N PurchaseOrderItem

MallProduct 1──N MallOrderItem
MallOrder 1──N MallOrderItem
```

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
| StockRecord | (tenant_id, warehouse_id, product_id) | btree |
| StockRecord | (tenant_id, product_id, expiry_date) | btree |
| StockMovement | (tenant_id, product_id, created_at) | btree |
| StockMovement | (tenant_id, reference_type, reference_id) | btree |
| PurchaseOrder | (tenant_id, supplier_id) | btree |
| PurchaseOrder | (tenant_id, status) | btree |
| Product | (tenant_id, code) | unique |
| MallOrder | (tenant_id, order_number) | unique |
| MallOrder | (tenant_id, customer_id, customer_type) | btree |
| MallProduct | (tenant_id, is_published) | btree |

