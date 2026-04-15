# 需求工程流水线 — 使用说明

## 概述

本流水线用于在正式编码前，通过 13 个串行执行的 GitHub Actions Job 逐步生成口腔 SaaS 系统的需求工程文档。

## 快速开始

### 1. 配置 Environment Gate

在仓库 **Settings → Environments** 中创建名为 `requirements-review` 的 environment：

1. 打开仓库的 Settings 页面
2. 左侧菜单点击 **Environments**
3. 点击 **New environment**
4. 输入名称: `requirements-review`
5. 勾选 **Required reviewers**
6. 添加至少一个审批人
7. 保存

### 2. 运行流水线

1. 进入仓库的 **Actions** 页面
2. 左侧选择 **需求工程流水线**
3. 点击 **Run workflow**
4. 设置参数:
   - `target_scope`: 执行范围（默认 `mvp`）
   - `stop_before_coding`: 是否编码前停止（建议始终为 `true`）
5. 点击 **Run workflow** 启动

### 3. 审批

当流水线执行到 Job 12（人工审计）时会暂停等待审批：

1. 在 Actions 页面看到等待审批的提示
2. 点击 **Review deployments**
3. 选择 `requirements-review` 环境
4. 点击 **Approve and deploy**

审批通过后会继续执行冻结记录写入和编码前停止，但 **不会** 进入编码阶段。

## 流水线阶段

| # | Job ID | 描述 | 输出目录 |
|---|--------|------|----------|
| 01 | job_01_research_collect | 收集资料与竞品信息 | docs/specs/01-research/ |
| 02 | job_02_research_normalize | 规范化调研结果 | docs/specs/01-research/ |
| 03 | job_03_product_scope | 定义产品范围 | docs/specs/02-architecture/ |
| 04 | job_04_system_blueprint | 定义系统蓝图 | docs/specs/02-architecture/ |
| 05 | job_05_base_standards | 定义基础规范 | docs/specs/05-design-system/ |
| 06 | job_06_menu_structure | 建立菜单结构 | docs/specs/03-information-architecture/ |
| 07 | job_07_feature_tree | 扩展功能树 | docs/specs/03-information-architecture/ |
| 08 | job_08_page_design | 生成页面详细设计 | docs/specs/06-pages/ |
| 09 | job_09_domain_model | 生成底层模型 | docs/specs/04-domain-model/ |
| 10 | job_10_test_specs | 生成验收测试文档 | docs/specs/07-test-specs/ |
| 11 | job_11_ai_task_packs | 生成 AI 编码任务包 | docs/specs/08-ai-task-packs/ |
| 12 | job_12_review_gate | 编码前人工审计 | docs/specs/09-review/ |
| 13 | job_13_pre_coding_stop | 编码前停止 | docs/specs/09-review/ |

## 断点续跑

流水线支持重复执行和断点续跑：

- 每个阶段完成后会写入状态文件到 `.github/requirements-status/`
- 再次运行时，已完成的阶段会自动跳过
- 跳过判断基于状态文件中的 `status` 字段和 `target_scope` 匹配
- 不是仅凭文档文件存在来判断

### 状态文件格式

```json
{
  "job_id": "job_01_research_collect",
  "status": "completed",
  "target_scope": "mvp",
  "timestamp": "2024-01-01T00:00:00Z",
  "description": "Stage completed successfully",
  "runner": "GitHub Actions",
  "run_id": "12345",
  "run_number": "1"
}
```

### 重新执行某个阶段

如果需要重新执行某个已完成的阶段，删除对应的状态文件即可：

```bash
# 例如重新执行阶段 03
rm .github/requirements-status/job_03_product_scope.json
git add -A && git commit -m "reset: job_03 状态重置" && git push
```

## 目录结构

```
.github/
├── requirements-status/          # 阶段状态文件
│   ├── job_01_research_collect.json
│   ├── job_02_research_normalize.json
│   └── ...
└── workflows/
    └── requirements-pipeline.yml  # 流水线定义

scripts/requirements/
├── common.sh                     # 通用工具函数
├── run-stage.sh                  # 阶段执行器
└── stages/
    ├── job_01_research_collect.sh
    ├── job_02_research_normalize.sh
    └── ...

docs/specs/                       # 生成的需求文档
├── 01-research/
├── 02-architecture/
├── 03-information-architecture/
├── 04-domain-model/
├── 05-design-system/
├── 06-pages/
├── 07-test-specs/
├── 08-ai-task-packs/
└── 09-review/

artifacts/requirements/latest/    # 构建产物摘要
```

## Git 提交策略

- 每个阶段完成后立即提交并推送
- Commit message 格式: `req-pipeline: <job_id> 完成 (scope=<scope>)`
- 推送前会尝试 fetch + rebase 同步远端
- 推送失败时最多重试 3 次（每次间隔 5 秒）
- 如果 rebase 冲突，会中止 rebase 并重试

## 设计原则

1. **脚本化**: 逻辑在 shell 脚本中，YAML 只负责编排
2. **幂等性**: 重复执行不会重复生成已完成的内容
3. **可追踪**: 每个阶段有独立状态文件，可审计
4. **安全停止**: 流水线在编码前主动停止
5. **人工审批**: 使用 GitHub Environment Gate 保障审批
6. **UTF-8**: 所有文件使用 UTF-8 编码
7. **英文标识符**: 所有程序标识符使用英文
