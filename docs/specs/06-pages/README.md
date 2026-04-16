# 页面设计总览

> 版本: v2.0
> 更新时间: 2026-04-15
> 目标市场: 东南亚 (Southeast Asia)

## 说明

本目录包含所有页面的详细设计规范（DSL），每个页面包含完整的表格列定义、表单字段、操作按钮、交互说明。

页面设计采用统一的 DSL 格式，便于 AI 编码工具精确理解并生成代码。

## 目录结构

```
06-pages/
├── README.md                          # 本文件 — 页面总览与索引
├── _common/                           # 通用规范
│   ├── ui-standards.md                # UI 通用标准（颜色/字体/间距）
│   └── common-patterns.md             # 通用交互模式（搜索/分页/表格/表单）
├── auth/                              # 认证模块
│   └── login.md                       # 登录页
├── dashboard/                         # 工作台模块
│   └── workbench.md                   # 工作台首页
├── appointment/                       # 预约管理模块
│   ├── calendar.md                    # 预约日历
│   ├── list.md                        # 预约列表
│   └── schedule.md                    # 排班管理
├── patient/                           # 患者管理模块
│   ├── list.md                        # 患者列表
│   └── detail.md                      # 患者详情（含家庭关系）
├── medical-record/                    # 病历管理模块
│   ├── dental-chart.md                # 牙位图
│   ├── treatment-plan.md              # 治疗方案
│   └── clinical-images.md             # 临床影像
├── billing/                           # 收费结算模块
│   ├── charge.md                      # 收费开单
│   ├── receivable.md                  # 应收账款/欠费管理
│   └── fee-items.md                   # 费用项目管理
├── membership/                        # 会员管理模块
│   ├── member-list.md                 # 会员列表
│   ├── level-config.md                # 等级配置
│   ├── points.md                      # 积分管理
│   └── packages.md                    # 会员套餐
├── follow-up/                         # 随访管理模块
│   ├── plan-list.md                   # 随访计划
│   └── recall.md                      # 复诊/失约管理
├── warehouse/                         # 仓储管理模块
│   ├── warehouse-list.md              # 仓库列表
│   ├── stock-in.md                    # 入库管理
│   ├── stock-out.md                   # 出库管理
│   ├── inventory-check.md             # 库存盘点
│   ├── purchase.md                    # 采购管理
│   └── supplier.md                    # 供应商管理
├── mall/                              # 商城模块
│   ├── product-manage.md              # 商品管理
│   ├── product-edit.md                # 商品编辑
│   ├── order-manage.md                # 订单管理
│   └── storefront.md                  # 商城前台
└── settings/                          # 系统设置模块
    ├── clinic-info.md                 # 机构信息
    ├── staff.md                       # 员工管理
    └── roles.md                       # 角色权限
```

## DSL 格式说明

每个页面设计文件遵循统一的 DSL 格式：

### 页面头部
- 页面名称、路由、所属模块、权限码、布局类型

### 搜索栏
| 字段名 | 组件类型 | 占位符文本 | 说明 |

### 筛选器
| 筛选项 | 组件类型 | 选项列表 | 默认值 |

### 数据表格
| 列标题 | 字段名 | 数据类型 | 宽度 | 可排序 | 可搜索 | 说明 |

### 行操作按钮
| 按钮文本 | 操作类型 | 权限码 | 确认弹窗 | 说明 |

### 批量操作
| 按钮文本 | 操作类型 | 权限码 | 确认弹窗 | 说明 |

### 新建/编辑表单
| 字段标签 | 字段名 | 组件类型 | 必填 | 验证规则 | 占位符 | 说明 |

### 状态机 / 流转
描述实体的状态流转规则

### 交互说明
列出所有交互行为

### API 数据源
列出页面依赖的 API 接口
