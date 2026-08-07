---
name: agent-intel
description: AI Agent 情报收集专家。使用 AnySearch API 自动化收集和分析 AI Agent 领域的情报信息，包括：(1) 行业动态与新闻跟踪；(2) 技术框架与工具更新；(3) 学术论文与研究进展；(4) 开源项目与代码实践；(5) 公司动态与融资信息；(6) 社交媒体与社区讨论热度。适用关键词：AI Agent、LLM、大模型、Agentic AI、MCP、Function Calling、Tool Use、多智能体系统等。
---

# Agent Intel — AI Agent 情报收集器

使用 AnySearch API 系统化收集 AI Agent 领域的情报。支持多维度搜索、定向采集、结果整理与报告生成。

## 快速开始

```bash
# 设置 API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 一键搜索 AI Agent 最新动态
bash scripts/agent-search.sh "AI Agent 2025 latest news"

# 定向搜索技术文档
bash scripts/agent-search.sh "LangGraph multi-agent" 10 en code.doc
```

## 搜索维度

Agent Intel 覆盖 6 大情报维度：

| 维度 | 推荐 Tag | 用途 |
|------|---------|------|
| 📰 动态资讯 | `general.general` | 行业新闻、产品发布、趋势分析 |
| 📚 技术文档 | `code.doc` | 框架文档、API 参考、最佳实践 |
| 🎓 学术研究 | `academic.search` | 论文、预印本、学术报告 |
| 💻 开源代码 | `code.snippet` | GitHub 代码实现、架构模式 |
| 💰 市场动态 | `finance.news` | 公司动态、融资、财报 |
| 💬 社区讨论 | `social_media.social_media` | 社区热度、趋势讨论 |

## 搜索参数

```json
{
  "query": "搜索关键词",
  "tag": "general.general",
  "max_results": 10,
  "language": "zh-CN",
  "zone": "intl",
  "format": "json",
  "params": {}
}
```

参数说明参见 [API 文档](https://www.anysearch.com/docs)。

## 情报采集工作流

### 1. 快速情报扫描

适合每日例行情报收集：

```bash
# 中英文同时搜索
bash scripts/agent-search.sh "AI Agent 智能体 最新进展" 8 zh-CN
bash scripts/agent-search.sh "AI agent framework update" 8 en

# 跟踪特定框架
bash scripts/agent-search.sh "LangChain LangGraph update" 5 en code.doc
bash scripts/agent-search.sh "CrewAI new features" 5 en code.doc
```

### 2. 定向深度采集

聚焦特定主题进行深度搜索：

```bash
# MCP 协议专题
bash scripts/agent-search.sh "MCP Model Context Protocol agent" 15 en

# AI 编程 agent
bash scripts/agent-search.sh "AI coding agent autonomous" 15 en

# 多智能体系统
bash scripts/agent-search.sh "multi-agent system orchestration" 15 en

# Agent 评估基准
bash scripts/agent-search.sh "AI agent benchmark evaluation" 15 en
```

### 3. 论文跟踪

```bash
# 直接使用 academic tag
curl -X POST https://api.anysearch.com/v1/search \
  -H "Authorization: Bearer $ANYSEARCH_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "large language model agent tool use planning",
    "tag": "academic.search",
    "max_results": 20,
    "language": "en"
  }'
```

### 4. 公司/产品定向

```bash
# 公司动态
bash scripts/agent-search.sh "Anthropic Claude agent API" 10 en
bash scripts/agent-search.sh "OpenAI Agents SDK" 10 en
bash scripts/agent-search.sh "Microsoft Copilot AI agent" 10 en

# 融资新闻
bash scripts/agent-search.sh "AI agent startup funding" 10 en finance.news
```

## 情报整理格式

搜索结果建议以下列格式呈现：

```
📰 [标题](链接)
├ 摘要：内容摘要
├ 来源：来源网站
└ 标签：所属类别
```

## API 响应结构

```json
{
  "code": 0,
  "message": "success",
  "data": {
    "results": [
      {
        "title": "标题",
        "url": "https://...",
        "snippet": "摘要短语",
        "content": "完整正文"
      }
    ],
    "metadata": {
      "total_results": 10,
      "search_time_ms": 946
    }
  }
}
```

## 脚本

### scripts/agent-search.sh

AnySearch 搜索封装脚本：

```bash
bash scripts/agent-search.sh "<query>" [max_results] [language] [tag]
```

参数：
- `query` (必填): 搜索查询
- `max_results` (可选, 默认 10): 返回结果数 (1-20)
- `language` (可选, 默认 en): 语言 (`en` / `zh-CN`)
- `tag` (可选, 默认 `general.general`): 能力标签

### 环境要求

- `curl` - HTTP 请求
- `python3` - JSON 解析和格式化
- `jq` (可选) - 更好的 JSON 构建

## 参考文献

[tags.md](references/tags.md) — AnySearch 完整 Tags 参考，包含所有域和子域的详细说明及参数列表。
