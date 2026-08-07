# Agent Intel 🤖

**AI Agent 情报收集器** — 基于 AnySearch API 的 AI Agent 领域情报自动化采集工具。

通过一个 shell 脚本 + 一个 SKILL.md，系统化收集 AI Agent 领域的最新动态、技术文档、学术论文、开源代码和市场信息。

## 功能特性

- 📰 **6 大情报维度** — 新闻资讯、技术文档、学术论文、开源代码、市场动态、社区讨论
- 🔍 **定向搜索** — 通过 AnySearch Tags 精准定位到指定领域
- 🎯 **AI Agent 专属** — 内置 AI Agent 专题关键词和搜索策略
- 📦 **即用即走** — 一个 shell 脚本搞定，无需额外依赖

## 快速开始

```bash
# 1. 克隆仓库
git clone https://github.com/wp931120/agent-intel.git
cd agent-intel

# 2. 设置 AnySearch API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 3. 开始搜索
bash scripts/agent-search.sh "AI Agent latest news"
```

> 免费注册获取 API Key：[AnySearch Console](https://www.anysearch.com)

## 使用方法

### 基础搜索

```bash
# 通用搜索
bash scripts/agent-search.sh "AI Agent framework comparison 2025"

# 指定返回数量
bash scripts/agent-search.sh "LangChain agent" 15

# 中文内容搜索
bash scripts/agent-search.sh "AI Agent 智能体 最新进展" 10 zh-CN

# 定向搜索技术文档 (tag = code.doc)
bash scripts/agent-search.sh "MCP protocol" 10 en code.doc
```

### 脚本参数

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

选择合适的 tag 可以显著提升搜索结果质量：

| Tag | 适合场景 |
|-----|---------|
| `general.general` | 通用新闻和资讯搜索 |
| `code.doc` | 框架文档、API 参考、最佳实践 |
| `academic.search` | 学术论文和研究工作 |
| `code.snippet` | GitHub 开源代码搜索 |
| `finance.news` | 公司动态和融资新闻 |
| `social_media.social_media` | 社区讨论热度追踪 |

完整 tags 列表见 [tags.md](references/tags.md)。

## 情报采集场景

### 每日情报扫描

```bash
# 双语同时搜索
bash scripts/agent-search.sh "AI Agent 智能体 最新进展" 8 zh-CN
bash scripts/agent-search.sh "AI agent framework update" 8 en
```

### 论文跟踪

```bash
bash scripts/agent-search.sh "large language model agent tool use" 15 en academic.search
```

### 公司动态

```bash
bash scripts/agent-search.sh "Anthropic Claude agent" 10 en
bash scripts/agent-search.sh "OpenAI agent API" 10 en
bash scripts/agent-search.sh "AI startup funding" 10 en finance.news
```

## OpenClaw Skill

Agent Intel 也可作为 [OpenClaw](https://docs.openclaw.ai) Skill 使用。

```bash
openclaw skills install agent-intel --file agent-intel.skill
```

安装后在对话中直接说出需求（如"搜一下 AI Agent 最新消息"），Skill 会自动触发搜索。

## 目录结构

```
agent-intel/
├── SKILL.md                    # OpenClaw Skill 主文件
├── scripts/
│   └── agent-search.sh         # AnySearch 搜索封装脚本
├── references/
│   └── tags.md                 # AnySearch Tags 完整参考
├── README.md
└── .gitignore
```

## 依赖

- `curl` — HTTP 请求
- `python3` — JSON 解析和格式化
- `jq` (可选) — 更好的 JSON 构建

## 许可证

MIT
