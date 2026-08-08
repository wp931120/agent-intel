---
name: agent-intel
description: AI 知识收集与情报分析专家。使用 AnySearch API 自动化完成信息检索、提炼去重到生成结构化文档的完整工作流。支持 Skill/MCP/API 三种接入方式，自动过滤重复内容，直出纯净 Markdown。适用于行业动态跟踪、技术文档采集、学术论文检索、本地知识库构建等场景。
---

# 🦞 Agent Intel — AI 知识收集工作流

基于 [AnySearch API](https://www.anysearch.com) 的知识收集技能。五步走完从主题到归档的完整管线。

## 工作流

```
输入主题 → 拆解检索词 → AnySearch 检索 → 去重提纯 → 输出结构化文档
```

### Step 1 — 拆解检索词

收到用户主题后，拆成若干精准检索词。例如用户说"搜一下最近 RAG 的进展"：

```
RAG 知识库构建 2025 最佳实践
RAG 检索增强生成 最新论文 2025
RAG 企业落地案例
```

### Step 2 — 调用脚本检索

```
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag]
```

脚本会调用 AnySearch API 并返回格式化结果 + 原始 JSON。

### Step 3 — 去重提纯

收到 JSON 结果后，Agent 自行完成：

1. **去重** — 识别并剔除同源/同事件的不同报道，只保留信息增量最大的那条
2. **提纯** — 去掉广告、SEO 灌水、无关元数据，提取核心信息
3. **结构化** — 按统一格式整理

### Step 4 — 输出给用户

输出的 Markdown 文档格式：

```markdown
## 📂 主题：{主题名称}

### 📰 {来源1标题}
- **链接**：[{URL}]({URL})
- **摘要**：{核心内容摘要}
- **来源**：{来源网站}

### 📰 {来源2标题}
...
```

结果同时归档到本地知识库（建议目录结构）：

```
knowledge-base/
└── topics/
    ├── rag/
    ├── multi-agent/
    └── llm-ops/
```

## 脚本

### scripts/agent-search.sh

```
bash scripts/agent-search.sh "<query>" [max_results] [language] [tag]
```

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `query` (必填) | 搜索查询 | — |
| `max_results` | 返回结果数 (1-20) | 10 |
| `language` | 语言 `en` / `zh-CN` | `en` |
| `tag` | 能力标签 | `general.general` |

### Tag 选择指南

| Tag | 适合场景 |
|-----|---------|
| `general.general` | 通用新闻资讯 |
| `code.doc` | 技术文档、API 参考 |
| `academic.search` | 学术论文检索 |
| `code.snippet` | 开源代码搜索 |
| `finance.news` | 公司动态、融资 |
| `social_media.social_media` | 社区讨论热度 |

完整 tags 参考：[tags.md](references/tags.md)

## API 参考

参数详情和响应结构见 [AnySearch 官方文档](https://www.anysearch.com/docs)。

### 请求参数

```json
{
  "query": "搜索关键词",
  "tag": "general.general",
  "max_results": 10,
  "language": "zh-CN"
}
```

### 响应结构

```json
{
  "code": 0,
  "message": "success",
  "data": {
    "results": [
      { "title": "标题", "url": "https://...", "snippet": "摘要", "content": "正文" }
    ],
    "metadata": { "total_results": 10, "search_time_ms": 946 }
  }
}
```

## 环境要求

- `curl` — HTTP 请求
- `python3` — JSON 解析
- `jq` (可选) — JSON 构建

## 使用方法

```bash
# 1. 设置 API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 2. 搜索
bash scripts/agent-search.sh "RAG 知识库构建 2025" 10 zh-CN

# 3. 免费注册获取 API Key：https://www.anysearch.com
```
