# 生产级口腔 SaaS 系统  
## AI 需求工程与 GitHub Actions 执行规范

- 文档版本：v1.0
- 状态：Draft
- 适用范围：口腔 SaaS 系统需求采集、需求整理、需求深化、需求冻结前流程
- 执行方式：GitHub Actions Workflow 串行执行
- 流程终点：编码前停止，进入人工审计
- 核心目标：通过标准化、结构化、可审计的流程，持续生成高质量需求文档，最终形成可供 AI 稳定编码的详细规格，且避免需求漂移、遗漏和自由发挥

---

# 1. 背景与目标

本规范用于指导生产级口腔 SaaS 系统在正式编码前的需求工程流程。  
整个流程通过 GitHub Actions 的多个 Jobs 按顺序执行，每个 Job 输出固定格式的产物（Artifacts / Markdown 文档 / JSON 清单），并在关键节点进行人工审计。

本流程的最终目标不是直接生成代码，而是：

1. 收集和整理行业资料、竞品资料与业务资料。
2. 建立完整的系统范围、业务蓝图与功能树。
3. 形成页面级、弹窗级、组件级的详细需求文档。
4. 建立统一的数据字典、权限矩阵、状态机、交互规范与组件规范。
5. 形成可供 AI 编码使用的标准任务包与提示词。
6. 在进入编码前强制停止，并等待人工审计确认。

---

# 2. 总体原则

## 2.1 基本原则

1. 先调研，后定义，后细化，后冻结，后编码。
2. 所有需求必须结构化、可追踪、可比对、可审计。
3. 所有产物必须写入仓库，不允许仅存在于临时对话或临时输出中。
4. 所有页面必须遵循统一模板描述，不允许随意发挥。
5. 所有功能必须明确数据、权限、状态、交互和验收标准。
6. 所有 AI 输出必须受约束，不允许擅自扩展未定义范围。
7. 所有关键阶段完成后必须允许人工审计。
8. 在编码前必须强制停止，不允许 workflow 自动进入代码生成阶段。

## 2.2 GitHub Actions 执行原则

1. 每个阶段对应一个或多个独立 Job。
2. Job 之间必须有明确依赖关系。
3. 每个 Job 必须有明确输入、处理逻辑、输出产物和完成标准。
4. 每个 Job 的输出必须可被下游 Job 消费。
5. 所有关键结果必须保存为仓库文件或 workflow artifact。
6. 编码前必须设置人工审计 Gate。
7. 审计未通过时不得进入下一阶段。
8. 本流程默认只推进到“编码任务包冻结前”。

---

# 3. 流程边界

## 3.1 本流程包含

- 竞品调研
- 业务信息收集
- 系统范围定义
- 系统架构与基础能力定义
- 菜单与功能树拆解
- 页面级详细设计
- 子窗口与组件设计
- 通用组件规范
- 数据字典
- 权限矩阵
- 状态机
- 视觉验收与轻交互验收设计
- AI 编码任务包设计
- 编码前人工审计

## 3.2 本流程不包含

- 自动生成生产代码
- 自动合并代码到主分支
- 自动发布应用
- 自动执行真实业务上线
- 自动通过需求冻结审计

---

# 4. 仓库目录规范

建议在仓库中采用如下目录结构：

```text
docs/
  specs/
    ai-requirements-workflow-plan.md
    00-governance/
      scope-definition.md
      glossary.md
      naming-conventions.md
      change-control.md
    01-research/
      competitors/
        competitor-template.md
        product-a.md
        product-b.md
      market-summary.md
      feature-comparison-matrix.md
      menu-comparison-matrix.md
      role-comparison-matrix.md
    02-architecture/
      product-boundary.md
      system-overview.md
      tenant-model.md
      organization-model.md
      non-functional-requirements.md
      security-and-audit.md
    03-information-architecture/
      menu-tree.md
      module-map.md
      feature-tree.md
    04-domain-model/
      data-dictionary.md
      enums.md
      code-rules.md
      state-machines.md
      permission-matrix.md
    05-design-system/
      design-principles.md
      layout-spec.md
      form-spec.md
      table-spec.md
      modal-drawer-spec.md
      interaction-spec.md
      copywriting-spec.md
      common-components.md
    06-pages/
      module-workbench/
      module-appointments/
      module-patients/
      module-clinical/
      module-treatment-plan/
      module-billing/
      module-insurance/
      module-inventory/
      module-crm/
      module-reporting/
      module-system/
    07-test-specs/
      visual-test-guidelines.md
      interaction-test-guidelines.md
      module-workbench/
      module-appointments/
      module-patients/
    08-ai-task-packs/
      prompt-template.md
      module-workbench/
      module-appointments/
      module-patients/
    09-review/
      review-checklists/
      freeze-records/
      audit-records/
.github/
  workflows/
    requirements-pipeline.yml
artifacts/
  requirements/
    latest/
```

---

# 5. 角色定义

## 5.1 人工角色

### 产品负责人
负责确认产品目标、范围边界、优先级和需求冻结。

### 领域审计人
负责检查业务合理性、医疗/口腔场景完整性、术语准确性。

### 设计审计人
负责检查页面结构、组件规范、交互一致性、视觉规则。

### 技术审计人
负责检查需求是否可实现、是否存在系统级矛盾、接口契约是否合理。

### 合规/安全审计人
负责检查权限、日志、审计、安全、敏感信息处理等要求是否完整。

## 5.2 AI 执行角色

### 资料整理 Agent
负责对资料进行整理、归档、摘要与结构化输出。

### 架构归纳 Agent
负责形成系统架构、模块划分和通用能力说明。

### 页面设计 Agent
负责将功能拆解为页面、子窗口、状态和交互。

### 规范统一 Agent
负责统一组件、表单、表格、交互和命名规范。

### 测试设计 Agent
负责输出视觉验收和轻交互验收文档。

### Prompt 打包 Agent
负责将冻结前需求转换为 AI 编码任务包。

---

# 6. 阶段划分

本流程划分为以下阶段：

1. 阶段 A：资料收集与竞品调研
2. 阶段 B：产品边界与系统蓝图定义
3. 阶段 C：通用能力与基础规范定义
4. 阶段 D：菜单体系与功能树拆解
5. 阶段 E：页面级详细设计
6. 阶段 F：底层模型定义
7. 阶段 G：验收文档设计
8. 阶段 H：AI 编码任务包生成
9. 阶段 I：人工审计 Gate
10. 阶段 J：流程停止，等待编码阶段人工触发

---

# 7. Job 设计总览

以下 Job 需要在 GitHub Actions 中按顺序执行。

| Job ID | Job 名称 | 目标 | 主要输出 | 是否需要人工审计 |
|---|---|---|---|---|
| job_01_research_collect | 收集资料与竞品信息 | 建立调研输入集 | 竞品文档、资料索引、对比矩阵初稿 | 否 |
| job_02_research_normalize | 规范化调研结果 | 统一调研模板与术语 | 标准化竞品文档、特性矩阵 | 是 |
| job_03_define_scope | 定义产品范围与边界 | 明确系统做什么、不做什么 | 范围文档、MVP 文档 | 是 |
| job_04_define_architecture | 定义系统蓝图 | 明确租户、组织、模块、非功能要求 | 系统概览、架构说明、NFR 文档 | 是 |
| job_05_define_foundation | 定义基础能力与通用规范 | 明确通用组件、交互、表单、表格等 | 通用规范文档 | 是 |
| job_06_build_menu_tree | 建立菜单和信息架构 | 形成完整菜单树与模块图 | 菜单树、模块地图 | 是 |
| job_07_expand_feature_tree | 扩展功能树 | 将菜单拆为功能 -> 页面 -> 子窗口 -> 组件 | 功能树文档 | 是 |
| job_08_page_spec_generation | 生成页面级详细设计 | 形成页面级完整规格 | 页面规格文档 | 是 |
| job_09_domain_modeling | 生成数据字典/权限矩阵/状态机 | 建立底层模型 | 数据字典、权限矩阵、状态机 | 是 |
| job_10_test_spec_generation | 生成视觉/轻交互验收文档 | 建立验收基线 | 测试规格文档 | 是 |
| job_11_prompt_packaging | 生成 AI 编码任务包 | 为编码准备标准 Prompt 包 | Prompt 包、任务清单 | 是 |
| job_12_precode_audit_gate | 编码前人工审计关卡 | 冻结前复核 | 审计记录、冻结记录 | 是 |
| job_13_stop_before_coding | 编码前停止 | 明确流程终止 | 停止说明文档 | 否 |

---

# 8. 各 Job 详细规范

## 8.1 job_01_research_collect

### 目标
收集口腔 SaaS、医疗 SaaS、CRM、收费/库存/报表相关资料，建立原始资料集。

### 输入
- 调研关键词清单
- 候选竞品名单
- 已知业务方向清单

### 处理要求
1. 收集不同类型竞品资料。
2. 按统一命名存储资料来源。
3. 输出资料索引，不直接进入实现层。
4. 记录资料来源类别、产品定位、主要功能点。

### 输出
- `docs/specs/01-research/competitors/*.md`
- `docs/specs/01-research/market-summary.md`
- `artifacts/requirements/latest/research-index.json`

### 完成标准
- 至少形成可覆盖核心业务域的资料集合。
- 每份资料都有来源标记、功能摘要和分类标签。

---

## 8.2 job_02_research_normalize

### 目标
将调研结果统一格式化，形成可比对的功能矩阵。

### 输入
- 阶段 A 原始调研资料

### 处理要求
1. 使用统一竞品模板整理文档。
2. 抽取一级菜单、二级菜单、角色、关键页面。
3. 输出功能对比矩阵。
4. 输出角色对比矩阵。
5. 输出页面模式归纳。

### 输出
- `feature-comparison-matrix.md`
- `menu-comparison-matrix.md`
- `role-comparison-matrix.md`

### 人工审计重点
- 是否遗漏关键业务域
- 是否有明显错误归类
- 是否术语统一

---

## 8.3 job_03_define_scope

### 目标
明确产品范围边界，定义本系统做什么、不做什么。

### 输入
- 调研归纳结果
- 业务目标说明

### 必须回答的问题
1. 产品服务对象是谁
2. 是否多租户
3. 是否多门店
4. 是否集团化
5. 是否有患者端
6. 是否包含保险理赔
7. 是否包含库存
8. 是否包含 CRM
9. 是否包含 BI
10. 哪些是 MVP
11. 哪些明确不在当前阶段

### 输出
- `docs/specs/00-governance/scope-definition.md`
- `docs/specs/02-architecture/product-boundary.md`

### 审计通过标准
- 范围边界清晰
- 模块边界可判断
- 不存在重大歧义

---

## 8.4 job_04_define_architecture

### 目标
定义系统级蓝图与非功能要求。

### 内容要求
1. 租户架构
2. 组织架构
3. 门店架构
4. 角色与权限架构
5. 模块架构
6. 文件与附件策略
7. 日志与审计策略
8. 通知机制
9. 非功能要求
10. 安全要求
11. 可扩展策略

### 输出
- `system-overview.md`
- `tenant-model.md`
- `organization-model.md`
- `non-functional-requirements.md`
- `security-and-audit.md`

### 审计重点
- 是否支撑生产级 SaaS
- 是否覆盖审计、安全、权限、性能、日志

---

## 8.5 job_05_define_foundation

### 目标
定义平台级通用能力与统一规范。

### 必须包含
1. 设计原则
2. 布局规范
3. 表单规范
4. 表格规范
5. 弹窗/抽屉规范
6. 交互规范
7. 文案规范
8. 通用组件清单
9. 命名规范
10. 编码规则规范（仅需求层，不进入真实编码）

### 输出
- `docs/specs/05-design-system/*.md`
- `docs/specs/00-governance/naming-conventions.md`

### 审计重点
- 是否统一
- 是否能支撑后续页面级设计
- 是否足够细致以约束 AI

---

## 8.6 job_06_build_menu_tree

### 目标
构建完整菜单树和信息架构。

### 必须覆盖
- 一级菜单
- 二级菜单
- 关键页面入口
- 菜单权限可见性说明
- 模块关系图

### 输出
- `menu-tree.md`
- `module-map.md`

### 审计重点
- 信息架构是否合理
- 菜单是否重复/冲突
- 是否覆盖 MVP

---

## 8.7 job_07_expand_feature_tree

### 目标
将菜单拆到可执行粒度。

### 拆解规则
统一采用以下结构：
- 模块
- 功能
- 页面
- 子窗口
- 组件

### 输出
- `feature-tree.md`
- 各模块功能树文档

### 审计重点
- 是否已拆解到足够细粒度
- 是否还能继续拆到页面级实现单元

---

## 8.8 job_08_page_spec_generation

### 目标
为每个页面、弹窗、抽屉生成完整详细设计。

### 页面模板必须包含

#### A. 基本信息
- 模块名称
- 功能名称
- 页面名称
- 页面类型
- 页面路由
- 适用角色
- 前置条件
- 进入方式

#### B. 页面目标
- 页面解决的问题
- 用户目标
- 页面输出结果

#### C. 布局结构
- 顶部区域
- 筛选区域
- 主体区域
- 详情区域
- 底部操作区
- 弹窗/抽屉关系

#### D. 数据展示
- 字段
- 列配置
- 排序/筛选/复制/跳转规则
- 空值/截断/提示规则

#### E. 查询与筛选
- 默认条件
- 高级筛选
- 重置逻辑
- 保存查询逻辑

#### F. 操作按钮
- 按钮名称
- 位置
- 显示条件
- 可用条件
- 点击行为
- 成功/失败提示
- 二次确认要求

#### G. 表单设计
- 字段名
- key
- 类型
- 必填
- 默认值
- 联动逻辑
- 校验规则
- 错误提示
- 权限可见性

#### H. 状态设计
- 初始态
- 加载态
- 空态
- 错误态
- 无权限态
- 只读态
- 禁用态
- 网络异常态

#### I. 交互逻辑
- 点击
- 悬停
- 双击
- 拖拽
- 快捷键
- 自动保存
- 离开拦截
- 返回记忆

#### J. 业务规则
- 字段依赖
- 状态流转
- 时间限制
- 删除限制
- 审批限制
- 并发编辑规则

#### K. 审计日志
- 记录哪些操作
- 记录哪些字段
- 是否记录前后值
- 记录的上下文信息

#### L. API 契约
- 接口名
- 方法
- 请求参数
- 返回结构
- 分页规则
- 错误码

#### M. 验收标准
- 视觉完整性
- 字段完整性
- 按钮完整性
- 状态完整性
- 交互完整性
- 文案一致性
- 权限正确性

### 输出
- `docs/specs/06-pages/**/**/*.md`

### 审计重点
- 页面规格是否已足够详细
- 是否仍存在 AI 自由发挥空间
- 是否存在未定义字段或未定义规则

---

## 8.9 job_09_domain_modeling

### 目标
建立页面设计依赖的底层模型。

### 必须输出
1. 数据字典
2. 枚举定义
3. 编码规则
4. 权限矩阵
5. 状态机文档

### 核心实体建议最少包含
- 租户
- 组织
- 门店
- 用户
- 角色
- 患者
- 家庭
- 预约
- 就诊
- 病历
- 牙位记录
- 治疗计划
- 账单
- 收款
- 退款
- 保险计划
- 理赔单
- 耗材
- 采购单
- 库存流水
- 通知
- 审计日志

### 输出
- `data-dictionary.md`
- `enums.md`
- `code-rules.md`
- `permission-matrix.md`
- `state-machines.md`

### 审计重点
- 是否支持全部页面
- 字段是否统一
- 是否存在字段命名冲突
- 状态与权限是否能闭环

---

## 8.10 job_10_test_spec_generation

### 目标
为前端实现准备验收文档。

### 测试范围
本阶段以：
1. 视觉验收
2. 轻交互验收

为主，不进入深度业务联调。

### 必须覆盖
- 布局
- 表单结构
- 表格列
- 按钮
- 弹窗
- 抽屉
- 标签页
- 空态
- 错误态
- 加载态
- 禁用态
- 基础点击交互

### 输出
- `visual-test-guidelines.md`
- `interaction-test-guidelines.md`
- 各模块测试规格文档

### 审计重点
- 是否可用于前端阶段验收
- 是否覆盖关键状态
- 是否能约束页面实现偏差

---

## 8.11 job_11_prompt_packaging

### 目标
将需求文档整理成 AI 编码任务包。

### 每个任务包必须包含
1. 任务名称
2. 模块名称
3. 页面名称
4. 实现目标
5. 输入依赖文档
6. 页面布局要求
7. 字段要求
8. 组件要求
9. 状态要求
10. 交互要求
11. 权限要求
12. 输出约束
13. 禁止事项
14. 验收标准

### 禁止事项必须明确
- 不得新增未定义字段
- 不得自行修改菜单结构
- 不得自行发明业务规则
- 不得擅自替换公共组件
- 不得超出任务包边界生成额外页面
- 不得修改未授权模块

### 输出
- `docs/specs/08-ai-task-packs/**/**/*.md`
- `prompt-template.md`
- `task-pack-index.json`

### 审计重点
- 是否足够让 AI 直接执行
- 是否边界清晰
- 是否可分批编码

---

## 8.12 job_12_precode_audit_gate

### 目标
在编码前进行人工审计与冻结确认。

### 审计维度
1. 范围是否冻结
2. 页面是否冻结
3. 数据字典是否冻结
4. 权限矩阵是否冻结
5. 状态机是否冻结
6. 测试规格是否冻结
7. Prompt 包是否冻结

### 输出
- `docs/specs/09-review/audit-records/precode-audit-YYYY-MM-DD.md`
- `docs/specs/09-review/freeze-records/requirements-freeze-YYYY-MM-DD.md`

### 通过规则
只有人工审计明确通过，才允许视为“可进入编码准备态”。

### 失败规则
如果审计未通过，workflow 必须结束，等待人工修订后再次触发。

---

## 8.13 job_13_stop_before_coding

### 目标
明确流程在编码前停止。

### 要求
1. 输出停止说明。
2. 标记当前流程已完成“需求冻结前准备”。
3. 不触发任何编码 Agent 或代码生成步骤。
4. 等待人工后续决定是否进入编码 workflow。

### 输出
- `docs/specs/09-review/freeze-records/stop-before-coding.md`

---

# 9. 人工审计机制

## 9.1 审计节点

建议至少设置以下人工审计节点：

1. 调研归一化完成后
2. 系统范围定义后
3. 系统架构与基础规范完成后
4. 功能树拆解完成后
5. 页面级详细设计完成后
6. 数据字典/权限矩阵/状态机完成后
7. Prompt 包生成后
8. 编码前最终冻结

## 9.2 审计方式

每次审计至少输出：
- 审计时间
- 审计人
- 审计范围
- 发现问题
- 必改项
- 建议项
- 结论（通过 / 驳回 / 有条件通过）

---

# 10. 文档模板要求

## 10.1 竞品文档模板
每个竞品文档必须包含：
- 产品名称
- 定位
- 客户群
- 一级菜单
- 二级菜单
- 核心功能
- 角色
- 页面模式
- 优点
- 缺点
- 可借鉴点
- 不建议采用点

## 10.2 页面规格模板
必须使用本规范第 8.8 节的页面模板。

## 10.3 测试规格模板
每个测试规格至少包含：
- 页面名称
- 测试范围
- 前置条件
- 视觉检查点
- 轻交互检查点
- 通过标准
- 截图要求

## 10.4 Prompt 任务包模板
必须包含：
- 任务目标
- 依赖文档
- 实现范围
- 具体约束
- 禁止事项
- 输出要求
- 验收要求

---

# 11. 命名规范

## 11.1 Job 命名
统一格式：
`job_序号_语义名称`

例如：
- `job_01_research_collect`
- `job_08_page_spec_generation`

## 11.2 文档命名
统一使用 kebab-case：
- `menu-tree.md`
- `permission-matrix.md`
- `patient-list-page-spec.md`

## 11.3 模块目录命名
统一使用：
- `module-workbench`
- `module-appointments`
- `module-patients`

---

# 12. 变更控制

## 12.1 原则
需求冻结前允许变更，但必须记录。  
需求冻结后，任何变更都必须通过变更单进入下一轮流程。

## 12.2 变更单至少包含
- 变更标题
- 变更原因
- 影响范围
- 影响模块
- 影响页面
- 影响字段
- 影响测试
- 风险说明
- 审批结论

---

# 13. Workflow 设计要求

## 13.1 执行方式
GitHub Actions Workflow 采用串行执行模式，核心阶段间必须使用 `needs` 连接。

## 13.2 必须具备的能力
1. 顺序执行
2. 输出 artifacts
3. 将结果回写仓库或 PR
4. 支持人工审计中断
5. 支持失败后从指定阶段重跑
6. 支持不同模块分批执行
7. 支持编码前���停止

## 13.3 禁止事项
1. 禁止自动跳过人工审计
2. 禁止自动进入编码阶段
3. 禁止在未冻结情况下生成正式实现任务
4. 禁止覆盖人工修订内容而不保留审计轨迹

---

# 14. 编码前停止规则

本规范要求 workflow 在需求工程阶段完成后必须停止。  
停止点定义如下：

- 页面规格已完成
- 数据字典已完成
- 权限矩阵已完成
- 状态机已完成
- 测试规格已完成
- Prompt 任务包已完成
- 人工审计已完成
- 冻结记录已生成

满足以上条件后：
- workflow 只能输出“可进入编码准备态”
- workflow 不得继续执行代码生成
- workflow 不得创建实现类 PR
- workflow 不得修改应用源码目录

---

# 15. 完成定义（Definition of Done）

当满足以下条件时，视为需求工程阶段完成：

1. 竞品与资料已归档。
2. 产品范围和系统边界已明确。
3. 系统蓝图和非功能要求已形成文档。
4. 菜单树、模块图、功能树已完成。
5. 所有核心页面已完成页面级详细设计。
6. 数据字典、权限矩阵、状态机已完成。
7. 视觉验收和轻交互验收文档已完成。
8. AI 编码任务包已完成。
9. 人工审计记录已完成。
10. 冻结记录已生成。
11. Workflow 已在编码前停止。

---

# 16. 建议的下一步实施方式

建议后续将本规范拆成以下 GitHub Actions 实施对象：

1. 一个主 workflow：
   - `requirements-pipeline.yml`

2. 若干可复用子流程：
   - `research.yml`
   - `scope-definition.yml`
   - `architecture-definition.yml`
   - `page-spec-generation.yml`
   - `domain-modeling.yml`
   - `test-spec-generation.yml`
   - `prompt-packaging.yml`
   - `precode-audit-gate.yml`

3. 一个人工审核触发机制：
   - 通过 `workflow_dispatch`
   - 或通过 issue / PR comment / environment protection 审核机制
   - 或通过 required reviewers 控制“���结前通过”

---

# 17. 附录：推荐的一级菜单（初版）

以下为生产级口腔 SaaS 建议的一期主菜单参考：

1. 工作台
2. 预约中心
3. 患者中心
4. 接诊与病历
5. 治疗计划
6. 收费与账单
7. 保险与理赔
8. 库存与采购
9. 患者运营 / CRM
10. 报表分析
11. 审批与任务
12. 系统管理
13. 集团 / 多门店管理

> 说明：最终以范围冻结文档为准，本列表仅作为需求工程初始参考。

---

# 18. 附录：推荐执行策略

建议实际执行时采用以下策略：

1. 先按模块分批，不要一次性全量生成所有文档。
2. 优先完成 MVP 模块：
   - 工作台
   - 预约中心
   - 患者中心
   - 接诊与病历
   - 治疗计划
   - 收费与账单
   - 系统管理
3. 每完成一个阶段就进行人工校验。
4. 在“页面规格 + 数据字典 + 权限矩阵 + 状态机”未齐全前，不进入 Prompt 打包。
5. 在 Prompt 包未审计通过前，不得进入编码。

---

# 19. 结语

本规范��目标不是让 AI 更快地产生代码，而是让 AI 在后续编码阶段：

- 理解范围准确
- 理解边界清晰
- 输出结构一致
- 避免自由发挥
- 避免遗漏细节
- 降低返工成本
- 保持生产级系统的可控性与可审计性

在本规范下，GitHub Actions 的职责是：
- 推进需求工程流程
- 固化产物
- 强化���序
- 触发审计
- 在编码前停止

而不是替代人工做最终业务判断。
