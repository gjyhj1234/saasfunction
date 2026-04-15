# 基础规范

> 生成时间: 2026-04-15T09:27:56Z
> 执行范围: mvp
> 目标市场: 东南亚 (Southeast Asia)

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
- 国际化: i18next + react-i18next
- 测试: Vitest + Testing Library

### 后端规范
- 框架: NestJS
- ORM: TypeORM
- 验证: class-validator
- 文档: Swagger/OpenAPI
- 国际化: nestjs-i18n
- 测试: Jest + Supertest

## 国际化 (i18n) 规范

### 多语言支持
- 默认语言: English (en)
- 目标语言: 泰语(th)、越南语(vi)、印尼语(id)、马来语(ms)、菲律宾语(fil)
- 翻译文件格式: JSON namespace
- 路径: `locales/{lang}/{namespace}.json`
- 所有用户可见文本必须通过 i18n key 引用，禁止硬编码

### 多币种支持
- 货币代码遵循 ISO 4217
- 支持币种: THB, VND, IDR, MYR, SGD, PHP, USD
- 金额存储: 使用最小货币单位 (cents/satang等) 的整数存储
- 显示格式: 使用 Intl.NumberFormat 按 locale 格式化
- 汇率: 通过外部服务获取实时汇率（预留接口）

### 时区支持
- 存储: 所有时间以 UTC 存储
- 显示: 根据租户配置的时区转换显示
- 东南亚时区: UTC+7 (泰/越/印尼西部), UTC+8 (马/新/菲/印尼中部)

## API 规范

### RESTful 设计
- 版本: `/api/v1/...`
- 命名: 复数名词 (`/patients`, `/appointments`)
- 分页: `?page=1&limit=20`
- 排序: `?sort=created_at&order=desc`
- 筛选: `?status=active&type=checkup`
- 语言: `Accept-Language` header

### 响应格式
```json
{
  "success": true,
  "data": {},
  "message": "ok",
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100
  }
}
```

### 错误格式
```json
{
  "success": false,
  "error": {
    "code": "PATIENT_NOT_FOUND",
    "message": "Patient not found"
  }
}
```

## Git 规范

### 分支策略
- main: 生产分支
- develop: 开发分支
- feature/*: 功能分支
- fix/*: 修复分支
- release/*: 发布分支

### Commit 格式
```
<type>(<scope>): <description>

feat(appointment): add calendar view
fix(billing): correct tax calculation
feat(warehouse): add stock-in workflow
feat(mall): add product listing page
docs(readme): update setup instructions
```

## 安全规范

- 密码: bcrypt 加密
- Token: JWT (access 15min + refresh 7d)
- 传输: HTTPS only
- 注入: 参数化查询
- XSS: 输出转义
- CORS: 白名单配置
- 日志: 脱敏处理
- 数据合规: 遵循目标国 PDPA/PDP 等数据保护法规

