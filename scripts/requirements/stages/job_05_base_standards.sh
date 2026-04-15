#!/usr/bin/env bash
# job_05_base_standards.sh — 定义基础规范
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/common.sh"
SCOPE="${1:?scope required}"

DOC_DIR="${DOCS_DIR}/05-design-system"
ensure_dir "$DOC_DIR"

write_doc "$DOC_DIR/base-standards.md" "# 基础规范

> 生成时间: $(now_ts)
> 执行范围: ${SCOPE}

## 编码规范

### 通用规则
- 语言: TypeScript (strict mode)
- 缩进: 2 spaces
- 行宽: 100 字符
- 命名: camelCase (变量/函数), PascalCase (类/组件), UPPER_SNAKE_CASE (常量)
- 文件命名: kebab-case

### 前端规范
- 框架: React 18+ / Next.js 14+
- 状态管理: Zustand
- 样式: Tailwind CSS
- 组件库: shadcn/ui
- 表单: React Hook Form + Zod
- 测试: Vitest + Testing Library

### 后端规范
- 框架: NestJS
- ORM: TypeORM
- 验证: class-validator
- 文档: Swagger/OpenAPI
- 测试: Jest + Supertest

## API 规范

### RESTful 设计
- 版本: \`/api/v1/...\`
- 命名: 复数名词 (\`/patients\`, \`/appointments\`)
- 分页: \`?page=1&limit=20\`
- 排序: \`?sort=created_at&order=desc\`
- 筛选: \`?status=active&type=checkup\`

### 响应格式
\`\`\`json
{
  \"success\": true,
  \"data\": {},
  \"message\": \"ok\",
  \"pagination\": {
    \"page\": 1,
    \"limit\": 20,
    \"total\": 100
  }
}
\`\`\`

### 错误格式
\`\`\`json
{
  \"success\": false,
  \"error\": {
    \"code\": \"PATIENT_NOT_FOUND\",
    \"message\": \"患者不存在\"
  }
}
\`\`\`

## Git 规范

### 分支策略
- main: 生产分支
- develop: 开发分支
- feature/*: 功能分支
- fix/*: 修复分支
- release/*: 发布分支

### Commit 格式
\`\`\`
<type>(<scope>): <description>

feat(appointment): add calendar view
fix(billing): correct tax calculation
docs(readme): update setup instructions
\`\`\`

## 安全规范

- 密码: bcrypt 加密
- Token: JWT (access 15min + refresh 7d)
- 传输: HTTPS only
- 注入: 参数化查询
- XSS: 输出转义
- CORS: 白名单配置
- 日志: 脱敏处理
"

echo "$DOC_DIR/base-standards.md"
