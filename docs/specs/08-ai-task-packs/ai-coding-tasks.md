# AI 编码任务包

> 生成时间: 2026-04-15T09:28:39Z
> 执行范围: mvp
> 目标市场: 东南亚 (Southeast Asia)

## 说明

本文档将需求拆解为可交给 AI 编码助手执行的独立任务包。每个任务包包含明确的输入、输出、依赖和验收标准。

## 任务包列表

### TASK-001: 项目初始化
- **优先级**: P0 (最先执行)
- **描述**: 使用 NestJS CLI 初始化后端项目，配置 TypeORM、PostgreSQL、JWT、i18n
- **输入**: 技术规范文档
- **输出**: 可运行的项目骨架（含 i18n 配置）
- **验收**: `npm run build` 成功, `npm test` 通过
- **预计工作量**: 小

### TASK-002: 数据库 Schema
- **优先级**: P0
- **依赖**: TASK-001
- **描述**: 根据领域模型创建所有 Entity 和 Migration（含仓储/商城实体）
- **输入**: domain-model.md
- **输出**: TypeORM Entity 文件 + Migration
- **验收**: Migration 可成功执行，表结构与模型一致
- **预计工作量**: 大

### TASK-003: 认证模块
- **优先级**: P0
- **依赖**: TASK-002
- **描述**: 实现登录、JWT 签发/刷新、RBAC Guard
- **输入**: base-standards.md (安全规范)
- **输出**: auth module + guards + decorators
- **验收**: 登录/登出 API 可用，权限拦截生效
- **预计工作量**: 中

### TASK-004: 患者管理 API
- **优先级**: P0
- **依赖**: TASK-003
- **描述**: 实现患者 CRUD + 搜索 + 分页，支持多语言档案
- **输入**: domain-model.md, normalized-requirements.md
- **输出**: patient module (controller + service + dto)
- **验收**: 所有 CRUD API 可用，分页/搜索正确
- **预计工作量**: 中

### TASK-005: 预约管理 API
- **优先级**: P0
- **依赖**: TASK-004
- **描述**: 实现预约 CRUD + 冲突检测 + 状态流转
- **输入**: feature-tree.md, domain-model.md
- **输出**: appointment module
- **验收**: 预约全生命周期 API 可用，冲突检测正确
- **预计工作量**: 大

### TASK-006: 收费结算 API（多币种）
- **优先级**: P0
- **依赖**: TASK-005
- **描述**: 实现收费单创建、收款、退款，支持多币种和东南亚支付方式
- **输入**: feature-tree.md, domain-model.md
- **输出**: billing module
- **验收**: 收费全流程 API 可用，多币种金额计算正确
- **预计工作量**: 大

### TASK-007: 仓储管理 API — 仓库与库存
- **优先级**: P0
- **依赖**: TASK-003
- **描述**: 实现仓库 CRUD、库位管理、库存记录、库存变动
- **输入**: domain-model.md, feature-tree.md
- **输出**: warehouse module (warehouse, location, stock-record, stock-movement)
- **验收**: 仓库 CRUD 可用，库存记录准确
- **预计工作量**: 大

### TASK-008: 仓储管理 API — 入出库与盘点
- **优先级**: P0
- **依赖**: TASK-007
- **描述**: 实现入库单、出库单、库存盘点全流程
- **输入**: domain-model.md, feature-tree.md
- **输出**: stock-in / stock-out / inventory-check sub-modules
- **验收**: 入出库库存变动正确，盘点差异处理正确
- **预计工作量**: 大

### TASK-009: 仓储管理 API — 采购与供应商
- **优先级**: P0
- **依赖**: TASK-007
- **描述**: 实现供应商管理、采购申请/审批/订单/到货验收
- **输入**: domain-model.md, feature-tree.md
- **输出**: purchase / supplier sub-modules
- **验收**: 完整采购流程闭环，审批流转正确
- **预计工作量**: 大

### TASK-010: 前端项目初始化
- **优先级**: P0
- **依赖**: TASK-001
- **描述**: 使用 Next.js + Tailwind + shadcn/ui + i18next 初始化前端
- **输入**: base-standards.md
- **输出**: 可运行的前端骨架（含 i18n 配置和多语言文件结构）
- **验收**: `npm run build` 成功
- **预计工作量**: 小

### TASK-011: 前端登录页
- **优先级**: P0
- **依赖**: TASK-003, TASK-010
- **描述**: 实现登录页面 + 认证状态管理 + 语言切换
- **输入**: page-specifications.md (P-001)
- **输出**: login page + auth store + language selector
- **验收**: 可登录并跳转，token 正确管理，语言可切换
- **预计工作量**: 中

### TASK-012: 前端布局与导航
- **优先级**: P0
- **依赖**: TASK-011
- **描述**: 实现侧边栏布局 + 菜单 + 面包屑（含仓储/商城菜单项）
- **输入**: menu-structure.md
- **输出**: layout components + navigation
- **验收**: 菜单展示正确，路由跳转正常
- **预计工作量**: 中

### TASK-013: 前端预约管理
- **优先级**: P0
- **依赖**: TASK-005, TASK-012
- **描述**: 预约日历 + 列表 + 创建/编辑
- **输入**: page-specifications.md (P-003, P-004)
- **输出**: appointment pages + components
- **验收**: 日历视图、创建、编辑功能正常
- **预计工作量**: 大

### TASK-014: 前端仓储管理
- **优先级**: P0
- **依赖**: TASK-008, TASK-012
- **描述**: 仓库列表 + 入库/出库 + 盘点 + 采购管理 + 供应商管理
- **输入**: page-specifications.md (P-008 ~ P-013)
- **输出**: warehouse pages + components
- **验收**: 仓储全流程页面可用
- **预计工作量**: 大

### TASK-015: 商城后端 API
- **优先级**: P1
- **依赖**: TASK-007
- **描述**: 商品管理、订单管理、促销管理 API，与仓储库存联动
- **输入**: domain-model.md, feature-tree.md
- **输出**: mall module
- **验收**: 商品 CRUD、下单、库存扣减正确
- **预计工作量**: 大

### TASK-016: 商城前端 (B2C)
- **优先级**: P1
- **依赖**: TASK-015, TASK-010
- **描述**: B2C 商城前台：商品浏览、购物车、结算、订单跟踪
- **输入**: page-specifications.md (P-017)
- **输出**: mall storefront pages
- **验收**: 完整购物流程可用
- **预计工作量**: 大

## 任务依赖图

```
TASK-001 ─┬── TASK-002 ── TASK-003 ─┬── TASK-004 ── TASK-005 ── TASK-006
          │                          │
          │                          ├── TASK-007 ─┬── TASK-008
          │                          │             ├── TASK-009
          │                          │             └── TASK-015 ── TASK-016
          │                          │
          └── TASK-010 ── TASK-011 ──┘── TASK-012 ─┬── TASK-013
                                                    └── TASK-014
```

## 执行建议

1. 后端和前端初始化可并行
2. 认证模块是最关键的依赖点
3. 仓储模块 (TASK-007/008/009) 和诊所模块 (TASK-004/005/006) 可并行开发
4. 商城模块 (TASK-015/016) 依赖仓储模块完成后再开始
5. 每个任务完成后应立即运行测试
6. API 完成后才开始对应的前端页面

