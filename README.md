# 🦞 Agent Intel — AI 知识收集工作流

<p align="center">
  <img src="assets/logo.svg" width="600" height="225" alt="Agent Intel Logo">
</p>

<p align="center">
  <b>小龙虾 AI 知识收集工作流</b><br>
  输入主题 → 拆解检索词 → AnySearch 检索 → 信息提纯去重 → 生成结构化文档 → 本地知识库归档
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License MIT">
  <img src="https://img.shields.io/badge/AnySearch-API-00d4ff" alt="AnySearch API">
  <img src="https://img.shields.io/badge/OpenClaw-Skill-7c3aed" alt="OpenClaw Skill">
</p>

---

告别信息杂乱、重复浪费、归档难的三大痛点。通过自建自动化知识库，让你的 AI 知识素材即搜即用，不再零散。

## 痛点 — 搞 AI 素材的人都懂

| 痛点 | 表现 | 后果 |
|------|------|------|
| 🧩 **信息杂乱带广告** | 搜个课题，结果页广告、低质 SEO 文参半 | 筛选就耗掉一半时间 |
| 🔁 **重复内容浪费 Token** | 同一事件被 N 家搬运改写 | 反复阅读浪费注意力 + API 调用 |
| 💾 **资料零散难沉淀归档** | 看完就忘，没有体系化 | 下次还得从头搜 |

## 🦞 小龙虾工作流 — 五步搞定

```
输入主题 → 拆解检索词 → AnySearch 检索 → 信息提纯去重 → 生成结构化文档 → 本地知识库归档
```

## ✨ 核心特性

- 🛠 **三种接入**：Skill / MCP / API 灵活切换
- 📄 **纯净 Markdown**：无广告无干扰，内容即查即用
- 🔄 **自动去重**：智能过滤同源重复，节约 Token
- 🎯 **垂直领域精准**：6 大 Tags 维度定向检索
- 🆓 **免费额度**：认证学生/开发者每日 2000 次

## 实测对比

| 维度 | 普通上网搜索 | 小龙虾 + AnySearch |
|------|------------|-------------------|
| 筛选方式 | 人工逐个翻页 | AI 自主检索筛选 |
| 内容质量 | 广告/SEO 掺杂 | 纯净 Markdown |
| 重复控制 | 肉眼去重 | 自动过滤 |
| 产出格式 | 浏览器 tab 散落 | 结构化知识文档 |
| 归档 | 无 | 直入本地知识库 |

## 快速开始

```bash
# 1. 部署小龙虾
git clone https://github.com/wp931120/agent-intel.git
cd agent-intel

# 2. 设置 AnySearch API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 3. 开始知识收集
bash scripts/agent-search.sh "RAG 知识库构建最佳实践" 10 zh-CN

# 4. 信息提纯去重
bash scripts/purify.sh raw.json purified.md
```

> 免费注册获取 API Key：[AnySearch Console](https://www.anysearch.com)

## 脚本参数

```
bash scripts/agent-search.sh "<query>" [max_results] [language] [tag]
```

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `query` | 搜索查询（必填） | — |
| `max_results` | 返回结果数 (1-20) | 10 |
| `language` | 语言 (`en` / `zh-CN`) | `en` |
| `tag` | 能力标签 | `general.general` |

### Tags 选择指南

| Tag | 适合场景 |
|-----|---------|
| `general.general` | 通用新闻和资讯搜索 |
| `code.doc` | 框架文档、API 参考、最佳实践 |
| `academic.search` | 学术论文和研究工作 |
| `code.snippet` | GitHub 开源代码搜索 |
| `finance.news` | 公司动态和融资新闻 |
| `social_media.social_media` | 社区讨论热度追踪 |

完整 tags 见 [tags.md](references/tags.md)。

## 实战场景

### 行业知识采集

```bash
bash scripts/agent-search.sh "大模型应用落地企业实践 2025" 15 zh-CN
bash scripts/agent-search.sh "autonomous agent production" 15 en
bash scripts/agent-search.sh "Agentic RAG pipeline" 10 en code.doc
```

### 论文追踪

```bash
bash scripts/agent-search.sh "tool learning LLM planning" 20 en academic.search
```

### 竞品与市场

```bash
bash scripts/agent-search.sh "Notion AI knowledge base competitor" 10 en
bash scripts/agent-search.sh "个人知识管理工具 对比评测" 10 zh-CN finance.news
```

### 开源项目速览

```bash
bash scripts/agent-search.sh "knowledge retrieval tool framework" 10 en code.snippet
```

## 知识归档结构

```
knowledge-base/
├── topics/          # 按主题分类
│   ├── rag/
│   ├── multi-agent/
│   └── llm-ops/
├── papers/          # 论文笔记
├── tools/           # 工具评估
└── daily/           # 日报汇总
```

## OpenClaw Skill

作为 [OpenClaw](https://docs.openclaw.ai) Skill 安装后，对话中直接触发检索：

```bash
openclaw skills install agent-intel --file agent-intel.skill
```

## 目录结构

```
agent-intel/
├── SKILL.md                    # OpenClaw Skill 主文件
├── scripts/
│   ├── agent-search.sh         # AnySearch 搜索封装
│   └── purify.sh               # 信息提纯去重
├── references/
│   └── tags.md                 # AnySearch Tags 参考
├── assets/
│   └── logo.svg                # Logo
├── CHANGELOG.md
├── README.md
└── .gitignore
```

## 依赖

- `curl` — HTTP 请求
- `python3` — JSON 解析和格式化
- `jq` (可选) — 更好的 JSON 构建

## 许可证

MIT
