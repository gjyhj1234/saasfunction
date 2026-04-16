# 角色权限

> 版本: v2.0
> 更新时间: 2026-04-15

---

## 页面信息

| 属性 | 值 |
|------|-----|
| 页面名称 | 角色权限 |
| 路由 | `/settings/roles` |
| 所属模块 | 系统设置 (settings) |
| 布局类型 | 侧边栏 + 顶部导航 + 左右分栏 (sidebar-topbar-split) |
| 权限要求 | `role:view` |
| 页面标题 | `角色权限 - {产品名称}` |
| 分页默认 | 不适用 |

---

## 页面结构

```
┌──────┬──────────────────────────────────────────────────────────────┐
│      │ [顶部导航: Logo  搜索  通知🔔  语言🌐  用户头像 ▼]            │
│      ├──────────────────────────────────────────────────────────────┤
│      │ 角色权限                                                      │
│ 侧   ├────────────┬─────────────────────────────────────────────────┤
│ 边   │ 角色列表    │ 角色详情: 管理员                                 │
│ 栏   │ (240px)    │                                                 │
│      │            │ ┌─── 角色信息 ───────────────────────────────┐  │
│ 菜   │ [+ 新建角色]│ │ 名称: 管理员    编码: admin                 │  │
│ 单   │            │ │ 描述: 系统管理员，拥有全部管理权限            │  │
│      │ ┌────────┐ │ │ 用户数: 2       🏷 系统角色                 │  │
│      │ │●管理员  │ │ │                    [编辑] [克隆]            │  │
│      │ │ 系统角色│ │ └──────────────────────────────────────────┘  │
│      │ │ 2 人   │ │                                                 │
│      │ └────────┘ │ ┌─── 权限配置 ───────────────────────────────┐  │
│      │ ┌────────┐ │ │                                            │  │
│      │ │ 医生   │ │ │ [全选] [取消全选]                [保存权限]  │  │
│      │ │ 系统角色│ │ │                                            │  │
│      │ │ 5 人   │ │ │ 资源模块      查看 新建 编辑 删除 导出 导入 │  │
│      │ └────────┘ │ │ ─────────────────────────────────────────  │  │
│      │ ┌────────┐ │ │ ▶ 患者管理                                 │  │
│      │ │ 前台   │ │ │   ├ 患者       ☑   ☑   ☑   ☑   ☑   ☑    │  │
│      │ │ 系统角色│ │ │   ├ 预约       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │ │ 3 人   │ │ │   ├ 病历       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │ └────────┘ │ │   ├ 牙位图     ☑   ☑   ☑   ☐   ☐   ☐    │  │
│      │ ┌────────┐ │ │   ├ 临床影像   ☑   ☑   ☑   ☑   ☑   ☑    │  │
│      │ │ 助理   │ │ │   └ 治疗方案   ☑   ☑   ☑   ☑   ☐   ☐    │  │
│      │ │ 系统角色│ │ │ ▶ 收费管理                                 │  │
│      │ │ 2 人   │ │ │   ├ 账单       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │ └────────┘ │ │   ├ 应收款     ☑   ☑   ☑   ☐   ☑   ☐    │  │
│      │ ┌────────┐ │ │   ├ 收费项目   ☑   ☑   ☑   ☑   ☑   ☑    │  │
│      │ │ 库管   │ │ │   └ 会员       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │ │ 系统角色│ │ │ ▶ 随访管理                                 │  │
│      │ │ 1 人   │ │ │   └ 随访       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │ └────────┘ │ │ ▶ 仓库管理                                 │  │
│      │ ┌────────┐ │ │   ├ 仓库       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │ │商城运营 │ │ │   ├ 入库       ☑   ☑   ☑   ☐   ☑   ☐    │  │
│      │ │ 系统角色│ │ │   ├ 出库       ☑   ☑   ☑   ☐   ☑   ☐    │  │
│      │ │ 1 人   │ │ │   ├ 盘点       ☑   ☑   ☑   ☐   ☑   ☐    │  │
│      │ └────────┘ │ │   ├ 采购       ☑   ☑   ☑   ☑   ☑   ☐    │  │
│      │            │ │   └ 供应商     ☑   ☑   ☑   ☑   ☑   ☑    │  │
│      │            │ │ ▶ 商城管理                                 │  │
│      │            │ │   ├ 商城商品   ☑   ☑   ☑   ☑   ☑   ☑    │  │
│      │            │ │   └ 商城订单   ☑   ☑   ☑   ☐   ☑   ☐    │  │
│      │            │ │ ▶ 系统设置                                 │  │
│      │            │ │   ├ 员工       ☑   ☑   ☑   ☑   ☐   ☐    │  │
│      │            │ │   ├ 角色       ☑   ☑   ☑   ☑   ☐   ☐    │  │
│      │            │ │   ├ 系统设置   ☑   ☐   ☑   ☐   ☐   ☐    │  │
│      │            │ │   └ 审计日志   ☑   ☐   ☐   ☐   ☑   ☐    │  │
│      │            │ │                                            │  │
│      │            │ └──────────────────────────────────────────┘  │
└──────┴────────────┴─────────────────────────────────────────────────┘

--- 新建/编辑角色弹窗 (480px) ---
┌──────────────────────────────────────────────────────┐
│ 新建角色 / 编辑角色                           [✕ 关闭] │
├──────────────────────────────────────────────────────┤
│ 角色名称 *    [                                    ] │
│ 角色编码 *    [                                    ] │
│ 角色描述      [                                    ] │
│               [                                    ] │
├──────────────────────────────────────────────────────┤
│                                  [取消]  [保存]       │
└──────────────────────────────────────────────────────┘
```

---

## 工具栏

| 序号 | 按钮文本 | 类型 | 图标 | 权限 | 说明 |
|------|----------|------|------|------|------|
| 1 | 新建角色 | 主按钮 (Primary) | ➕ | `role:create` | 位于左侧面板顶部; 打开新建角色弹窗 |

---

## 搜索栏

> 不适用 (角色数量有限，无需搜索)

---

## 筛选器

> 不适用 (角色数量有限，无需筛选)

---

## 数据表格

> 不适用 (使用左右分栏布局，非标准表格页)

---

## 行操作

> 不适用 (操作集成在右侧面板中)

---

## 批量操作

> 不适用

---

## 左侧面板 — 角色列表

### 角色卡片定义

| 元素 | 说明 |
|------|------|
| 角色名称 | 加粗显示; 选中时高亮背景色 #EFF6FF |
| 系统角色标识 | 系统角色显示 🏷 "系统角色" 小标签; 自定义角色不显示 |
| 用户数 | 显示分配该角色的用户数 "{N} 人" |
| 选中状态 | 左侧蓝色竖条 (4px) + 浅蓝背景 |

### 系统预置角色

| 角色编码 | 角色名称 | 描述 | 可删除 |
|----------|----------|------|--------|
| `admin` | 管理员 | 系统管理员，拥有全部管理权限 | 否 |
| `doctor` | 医生 | 医生角色，可管理患者和病历 | 否 |
| `receptionist` | 前台 | 前台接待，可管理预约和收费 | 否 |
| `assistant` | 助理 | 医生助理，协助诊疗工作 | 否 |
| `warehouse_keeper` | 库管 | 仓库管理员，管理库存进出 | 否 |
| `mall_operator` | 商城运营 | 商城运营，管理商品和订单 | 否 |

---

## 右侧面板 — 权限配置

### 角色信息区

| 元素 | 说明 |
|------|------|
| 角色名称 | 大号字体显示 |
| 角色编码 | 灰色文本; code 格式 |
| 角色描述 | 描述文字 |
| 用户数 | "{N} 人" |
| 系统角色 Badge | 系统角色显示蓝色标签 "系统角色" |
| 操作按钮 | [编辑] [克隆] [删除] (系统角色不显示删除) |

### 权限矩阵

| 序号 | 资源模块 | 资源代码 | 可用操作 | 说明 |
|------|----------|----------|----------|------|
| 1 | 患者 | `patient` | view, create, edit, delete, export, import | 患者信息管理 |
| 2 | 预约 | `appointment` | view, create, edit, delete, export | 预约挂号管理 |
| 3 | 病历 | `medical_record` | view, create, edit, delete, export | 电子病历管理 |
| 4 | 牙位图 | `dental_chart` | view, create, edit | 口腔牙位图记录 |
| 5 | 临床影像 | `clinical_image` | view, create, edit, delete, export, import | 临床影像资料 |
| 6 | 治疗方案 | `treatment_plan` | view, create, edit, delete | 治疗计划管理 |
| 7 | 账单 | `billing` | view, create, edit, delete, export | 账单收费管理 |
| 8 | 应收款 | `receivable` | view, create, edit, export | 应收账款管理 |
| 9 | 收费项目 | `fee_item` | view, create, edit, delete, export, import | 收费项目维护 |
| 10 | 会员 | `membership` | view, create, edit, delete, export | 会员管理 |
| 11 | 随访 | `follow_up` | view, create, edit, delete, export | 随访计划管理 |
| 12 | 仓库 | `warehouse` | view, create, edit, delete, export | 仓库管理 |
| 13 | 入库 | `stock_in` | view, create, edit, export | 入库单管理 |
| 14 | 出库 | `stock_out` | view, create, edit, export | 出库单管理 |
| 15 | 盘点 | `inventory_check` | view, create, edit, export | 库存盘点管理 |
| 16 | 采购 | `purchase` | view, create, edit, delete, export | 采购订单管理 |
| 17 | 供应商 | `supplier` | view, create, edit, delete, export, import | 供应商管理 |
| 18 | 商城商品 | `mall_product` | view, create, edit, delete, export, import | 商城商品管理 |
| 19 | 商城订单 | `mall_order` | view, create, edit, export | 商城订单管理 |
| 20 | 员工 | `user` | view, create, edit, delete | 员工账号管理 |
| 21 | 角色 | `role` | view, create, edit, delete | 角色权限管理 |
| 22 | 系统设置 | `settings` | view, edit | 系统配置管理 |
| 23 | 审计日志 | `audit_log` | view, export | 操作日志查看 |

### 权限矩阵操作列

| 列标题 | 操作代码 | 说明 |
|--------|----------|------|
| 查看 | `view` | 查看列表和详情 |
| 新建 | `create` | 创建新记录 |
| 编辑 | `edit` | 修改已有记录 |
| 删除 | `delete` | 删除记录 |
| 导出 | `export` | 导出数据为文件 |
| 导入 | `import` | 从文件导入数据 |

### 权限矩阵分组

| 分组名称 | 包含资源 |
|----------|----------|
| 患者管理 | patient, appointment, medical_record, dental_chart, clinical_image, treatment_plan |
| 收费管理 | billing, receivable, fee_item, membership |
| 随访管理 | follow_up |
| 仓库管理 | warehouse, stock_in, stock_out, inventory_check, purchase, supplier |
| 商城管理 | mall_product, mall_order |
| 系统设置 | user, role, settings, audit_log |

---

## 表单字段

### 新建/编辑角色弹窗 (480px)

| 字段标签 | 字段名 | 组件类型 | 必填 | 验证规则 | 说明 |
|----------|--------|----------|------|----------|------|
| 角色名称 | `name` | Input | 是 | 2-30 字符; 唯一性校验 | 角色显示名称 |
| 角色编码 | `code` | Input | 是 | 2-30 字符; 仅字母数字下划线; 唯一性校验 | 新建时可编辑; 编辑时只读; 系统角色不可修改 |
| 角色描述 | `description` | Textarea | 否 | 最多 200 字符 | 角色用途描述 |

---

## 状态机/流转

> 不适用 (角色无状态流转)

---

## 交互说明

### INT-01: 页面加载

| 步骤 | 行为 |
|------|------|
| 1 | 页面加载时请求角色列表 API |
| 2 | 左侧面板显示角色列表; 按 sort_order 排序; 系统角色在前 |
| 3 | 自动选中第一个角色; 右侧加载该角色的权限配置 |
| 4 | 左侧面板使用骨架屏加载; 右侧权限矩阵使用骨架屏加载 |
| 5 | 如 URL 中有 `role_id` 参数，优先选中该角色 |

### INT-02: 选择角色

| 步骤 | 行为 |
|------|------|
| 1 | 点击左侧角色卡片 → 卡片高亮选中; URL 更新 `?role_id={id}` |
| 2 | 右侧面板显示 loading → 加载选中角色详情和权限数据 |
| 3 | 权限矩阵根据角色数据勾选对应权限复选框 |
| 4 | 如当前角色有未保存的权限变更，弹出确认: "当前角色有未保存的权限变更，是否放弃？" |

### INT-03: 新建角色

| 步骤 | 行为 |
|------|------|
| 1 | 点击 [+ 新建角色] → 打开新建角色弹窗 (480px) |
| 2 | 填写角色名称、编码、描述 |
| 3 | 编码输入时实时查重 (300ms 防抖) |
| 4 | 点击 [保存] → 表单验证 → 调用创建角色 API |
| 5 | 成功 → Toast "角色创建成功"; 关闭弹窗; 刷新左侧列表; 自动选中新角色 |
| 6 | 新角色默认无任何权限; 需在右侧面板配置 |

### INT-04: 编辑角色

| 步骤 | 行为 |
|------|------|
| 1 | 点击右侧面板 [编辑] → 打开编辑角色弹窗，预填当前数据 |
| 2 | 角色编码字段只读不可修改 |
| 3 | 系统角色: 名称和描述可修改 |
| 4 | 点击 [保存] → 调用更新角色 API |
| 5 | 成功 → Toast "角色信息已更新"; 关闭弹窗; 刷新左侧列表和右侧详情 |

### INT-05: 克隆角色

| 步骤 | 行为 |
|------|------|
| 1 | 点击 [克隆] → 打开新建角色弹窗，预填 "名称_副本" 和原角色描述 |
| 2 | 编码字段清空，需手动输入新编码 |
| 3 | 创建成功后，新角色自动继承原角色的全部权限配置 |
| 4 | 成功 → Toast "角色克隆成功"; 选中新角色 |

### INT-06: 删除角色

| 步骤 | 行为 |
|------|------|
| 1 | 点击 [删除] → 弹出确认弹窗 (仅非系统角色可见) |
| 2 | 校验: 该角色是否有分配用户 |
| 3 | 如有用户 → 弹窗警告 "该角色已分配给 {N} 个用户，删除后这些用户将失去该角色的权限" + [取消] [确认删除] |
| 4 | 如无用户 → 确认弹窗 "确认删除角色 {角色名称}？此操作不可撤销" |
| 5 | 确认后调用删除 API |
| 6 | 成功 → Toast "角色已删除"; 从列表移除; 自动选中第一个角色 |
| 7 | 系统角色 (is_system=true) 不显示删除按钮 |

### INT-07: 权限配置

| 步骤 | 行为 |
|------|------|
| 1 | 权限矩阵以树形表格展示; 按资源分组折叠/展开 |
| 2 | 点击分组行的展开箭头 ▶ → 展开该分组下的资源列表 |
| 3 | 勾选/取消复选框 → 权限变更标记为"未保存" (保存按钮高亮) |
| 4 | 勾选 "查看" 以外的权限时，自动勾选 "查看" 权限 (依赖关系) |
| 5 | 取消 "查看" 权限时，自动取消该资源的所有其他权限 |
| 6 | 点击 [全选] → 该角色获得所有资源的所有权限 |
| 7 | 点击 [取消全选] → 清空所有权限; 需确认 "确认清空所有权限？" |
| 8 | 分组行复选框: 勾选/取消 → 该分组下所有资源的全部权限勾选/取消 |
| 9 | 资源行不可用的操作 (如审计日志无 create) 显示为灰色禁用复选框 |

### INT-08: 保存权限

| 步骤 | 行为 |
|------|------|
| 1 | 权限有变更时 [保存权限] 按钮变为主按钮样式 (高亮) |
| 2 | 点击 [保存权限] → 调用更新角色权限 API |
| 3 | 保存成功 → Toast "权限配置已保存"; 按钮恢复默认样式 |
| 4 | 保存失败 → Toast 错误信息; 权限状态不变 |
| 5 | 离开页面或切换角色时，如有未保存变更则弹出确认 |

---

## 空状态

| 场景 | 展示内容 |
|------|----------|
| 无自定义角色 | 左侧仅显示系统角色; 底部提示 "可创建自定义角色满足特殊需求" |
| 角色无权限 | 权限矩阵全部未勾选; 提示 "该角色暂无任何权限，请配置后保存" |
| 未选中角色 | 右侧面板显示引导插画 + "请从左侧选择一个角色查看权限配置" |

---

## 响应式适配

| 断点 | 布局调整 |
|------|----------|
| ≥ 1280px (桌面) | 左侧 240px + 右侧自适应; 权限矩阵完整显示所有列 |
| 768-1279px (平板) | 左侧 200px + 右侧自适应; 权限矩阵横向滚动 |
| < 768px (手机) | 左侧全宽列表; 点击角色进入权限详情页 (路由跳转); 权限矩阵纵向排列 |

### 移动端权限卡片布局

```
┌──────────────────────────────┐
│ ← 返回角色列表                │
│ 管理员 🏷系统角色   2 人       │
│ 系统管理员，拥有全部管理权限   │
│ [编辑] [克隆]                 │
├──────────────────────────────┤
│ ▶ 患者管理                    │
│   患者: ☑查看 ☑新建 ☑编辑 ...│
│   预约: ☑查看 ☑新建 ☑编辑 ...│
│ ▶ 收费管理                    │
│   ...                        │
├──────────────────────────────┤
│          [保存权限]            │
└──────────────────────────────┘
```

---

## API 数据源

| 接口 | 方法 | 路径 | 请求参数 | 说明 |
|------|------|------|----------|------|
| 获取角色列表 | GET | `/api/v1/roles` | - | 获取所有角色 (含用户计数) |
| 获取角色详情 | GET | `/api/v1/roles/:id` | - | 含权限配置详情 |
| 创建角色 | POST | `/api/v1/roles` | 见下方请求体 | 新建自定义角色 |
| 更新角色 | PUT | `/api/v1/roles/:id` | `name`, `description` | 编辑角色基本信息 |
| 删除角色 | DELETE | `/api/v1/roles/:id` | - | 删除自定义角色; 系统角色拒绝 |
| 克隆角色 | POST | `/api/v1/roles/:id/clone` | `name`, `code`, `description` | 克隆角色及权限 |
| 获取角色权限 | GET | `/api/v1/roles/:id/permissions` | - | 获取角色的权限矩阵 |
| 更新角色权限 | PUT | `/api/v1/roles/:id/permissions` | `permissions[]` | 更新角色权限配置 |
| 校验角色编码 | GET | `/api/v1/roles/check-code` | `code` | 编码唯一性校验 |
| 获取权限资源列表 | GET | `/api/v1/permissions/resources` | - | 获取所有可配置的资源和操作定义 |

### 创建角色请求体

```json
{
  "name": "实习医生",
  "code": "intern_doctor",
  "description": "实习医生角色，仅有查看权限"
}
```

### 更新权限请求体

```json
{
  "permissions": [
    { "resource": "patient", "actions": ["view", "create", "edit", "delete", "export", "import"] },
    { "resource": "appointment", "actions": ["view", "create", "edit", "delete", "export"] },
    { "resource": "medical_record", "actions": ["view", "create", "edit"] },
    { "resource": "dental_chart", "actions": ["view", "create", "edit"] },
    { "resource": "clinical_image", "actions": ["view", "create"] },
    { "resource": "treatment_plan", "actions": ["view", "create", "edit"] },
    { "resource": "billing", "actions": ["view"] },
    { "resource": "settings", "actions": ["view"] },
    { "resource": "audit_log", "actions": ["view"] }
  ]
}
```

### 角色列表响应示例

```json
{
  "code": 200,
  "data": [
    {
      "id": "role_admin",
      "name": "管理员",
      "code": "admin",
      "description": "系统管理员，拥有全部管理权限",
      "is_system": true,
      "sort_order": 1,
      "user_count": 2,
      "created_at": "2026-01-01T00:00:00Z",
      "updated_at": "2026-04-10T08:00:00Z"
    },
    {
      "id": "role_doctor",
      "name": "医生",
      "code": "doctor",
      "description": "医生角色，可管理患者和病历",
      "is_system": true,
      "sort_order": 2,
      "user_count": 5,
      "created_at": "2026-01-01T00:00:00Z",
      "updated_at": "2026-04-08T14:00:00Z"
    },
    {
      "id": "role_receptionist",
      "name": "前台",
      "code": "receptionist",
      "description": "前台接待，可管理预约和收费",
      "is_system": true,
      "sort_order": 3,
      "user_count": 3,
      "created_at": "2026-01-01T00:00:00Z",
      "updated_at": "2026-03-20T10:00:00Z"
    },
    {
      "id": "role_assistant",
      "name": "助理",
      "code": "assistant",
      "description": "医生助理，协助诊疗工作",
      "is_system": true,
      "sort_order": 4,
      "user_count": 2,
      "created_at": "2026-01-01T00:00:00Z",
      "updated_at": "2026-03-15T09:00:00Z"
    },
    {
      "id": "role_warehouse_keeper",
      "name": "库管",
      "code": "warehouse_keeper",
      "description": "仓库管理员，管理库存进出",
      "is_system": true,
      "sort_order": 5,
      "user_count": 1,
      "created_at": "2026-01-01T00:00:00Z",
      "updated_at": "2026-02-28T11:00:00Z"
    },
    {
      "id": "role_mall_operator",
      "name": "商城运营",
      "code": "mall_operator",
      "description": "商城运营，管理商品和订单",
      "is_system": true,
      "sort_order": 6,
      "user_count": 1,
      "created_at": "2026-01-01T00:00:00Z",
      "updated_at": "2026-04-01T15:00:00Z"
    },
    {
      "id": "role_custom_001",
      "name": "实习医生",
      "code": "intern_doctor",
      "description": "实习医生角色，仅有查看权限",
      "is_system": false,
      "sort_order": 100,
      "user_count": 0,
      "created_at": "2026-04-10T08:00:00Z",
      "updated_at": "2026-04-10T08:00:00Z"
    }
  ]
}
```

### 角色权限响应示例

```json
{
  "code": 200,
  "data": {
    "role_id": "role_doctor",
    "permissions": [
      { "resource": "patient", "actions": ["view", "create", "edit", "export"] },
      { "resource": "appointment", "actions": ["view", "create", "edit"] },
      { "resource": "medical_record", "actions": ["view", "create", "edit", "delete", "export"] },
      { "resource": "dental_chart", "actions": ["view", "create", "edit"] },
      { "resource": "clinical_image", "actions": ["view", "create", "edit", "delete"] },
      { "resource": "treatment_plan", "actions": ["view", "create", "edit", "delete"] },
      { "resource": "billing", "actions": ["view"] },
      { "resource": "follow_up", "actions": ["view", "create", "edit"] },
      { "resource": "settings", "actions": ["view"] }
    ]
  }
}
```

### 权限资源定义响应示例

```json
{
  "code": 200,
  "data": {
    "groups": [
      {
        "group_name": "患者管理",
        "resources": [
          { "code": "patient", "name": "患者", "available_actions": ["view", "create", "edit", "delete", "export", "import"] },
          { "code": "appointment", "name": "预约", "available_actions": ["view", "create", "edit", "delete", "export"] },
          { "code": "medical_record", "name": "病历", "available_actions": ["view", "create", "edit", "delete", "export"] },
          { "code": "dental_chart", "name": "牙位图", "available_actions": ["view", "create", "edit"] },
          { "code": "clinical_image", "name": "临床影像", "available_actions": ["view", "create", "edit", "delete", "export", "import"] },
          { "code": "treatment_plan", "name": "治疗方案", "available_actions": ["view", "create", "edit", "delete"] }
        ]
      },
      {
        "group_name": "收费管理",
        "resources": [
          { "code": "billing", "name": "账单", "available_actions": ["view", "create", "edit", "delete", "export"] },
          { "code": "receivable", "name": "应收款", "available_actions": ["view", "create", "edit", "export"] },
          { "code": "fee_item", "name": "收费项目", "available_actions": ["view", "create", "edit", "delete", "export", "import"] },
          { "code": "membership", "name": "会员", "available_actions": ["view", "create", "edit", "delete", "export"] }
        ]
      },
      {
        "group_name": "随访管理",
        "resources": [
          { "code": "follow_up", "name": "随访", "available_actions": ["view", "create", "edit", "delete", "export"] }
        ]
      },
      {
        "group_name": "仓库管理",
        "resources": [
          { "code": "warehouse", "name": "仓库", "available_actions": ["view", "create", "edit", "delete", "export"] },
          { "code": "stock_in", "name": "入库", "available_actions": ["view", "create", "edit", "export"] },
          { "code": "stock_out", "name": "出库", "available_actions": ["view", "create", "edit", "export"] },
          { "code": "inventory_check", "name": "盘点", "available_actions": ["view", "create", "edit", "export"] },
          { "code": "purchase", "name": "采购", "available_actions": ["view", "create", "edit", "delete", "export"] },
          { "code": "supplier", "name": "供应商", "available_actions": ["view", "create", "edit", "delete", "export", "import"] }
        ]
      },
      {
        "group_name": "商城管理",
        "resources": [
          { "code": "mall_product", "name": "商城商品", "available_actions": ["view", "create", "edit", "delete", "export", "import"] },
          { "code": "mall_order", "name": "商城订单", "available_actions": ["view", "create", "edit", "export"] }
        ]
      },
      {
        "group_name": "系统设置",
        "resources": [
          { "code": "user", "name": "员工", "available_actions": ["view", "create", "edit", "delete"] },
          { "code": "role", "name": "角色", "available_actions": ["view", "create", "edit", "delete"] },
          { "code": "settings", "name": "系统设置", "available_actions": ["view", "edit"] },
          { "code": "audit_log", "name": "审计日志", "available_actions": ["view", "export"] }
        ]
      }
    ]
  }
}
```
