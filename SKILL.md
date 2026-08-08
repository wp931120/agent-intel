---
name: agent-intel
description: AI 知识收集与深度分析专家。使用 AnySearch API 检索信息，再通过四步分析方法论洞察信息，最终输出 3:4 竖版信息卡片。支持 Skill/MCP/API 三种接入方式。适用于行业洞察、新闻分析、技术调研、竞品研究等场景。
---

# 🦞 Agent Intel — 知识收集 + 深度分析

基于 [AnySearch API](https://www.anysearch.com) 的知识收集与洞察技能。不只要"搜到"，更要"读懂"。

## 完整工作流

```
用户主题 → 拆解检索词 → AnySearch 检索 → 四步分析 → 输出信息卡片
```

---

## Step 1 — 拆解检索词

收到用户主题后，拆成 2-3 个精准检索词。例如"最近 RAG 有什么新动态"：

- `RAG 检索增强生成 2025 最新进展`
- `RAG knowledge base production 2025`
- `RAG evaluation benchmark 2025`

## Step 2 — 检索

```bash
# 普通模式 — 打印可读结果
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag]

# JSON 模式 — 输出原始 JSON（供 Agent 程序化处理）
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag] json
```

返回的 JSON 中每条结果包含：`title`, `url`, `snippet`, `content`。

## Step 3 — 四步分析

对检索到的信息，按以下方法论逐条分析，合并交叉验证。

### ① 定位背景

先判断新闻类型，再问两个问题：

**类型判断：**
- 宏观类：政策发布、经济数据、监管变动
- 行业类：财报、并购、产品发布、融资
- 突发类：宕机、泄露、事故、冲突
- 舆论类：热搜、官方通报、媒体评论

**两个问题：**
- 这条信息替代了之前的什么状态？
- 如果没有它，现在会是什么走向？

### ② 拆文本信号

**谁说的？对谁说的？**
- 信源可信度：官方 vs 媒体 vs 匿名爆料
- 受众范围：面向大众 vs 面向专业人士 vs 行业内部

**措辞分析：**
- 用词力度：`"适时"` vs `"坚决"`，`"阶段性"` vs `"常态化"`
- 范围词：`"部分"` vs `"全面"`，`"积极探索"` vs `"正式启动"`
- 通稿重点看"没写什么"——回避的点往往是关键

### ③ 利益相关方映射

**权力/利益矩阵：**

| | 受益 | 承压 | 沉默 |
|--|------|------|------|
| 显性 | 点名表扬方 | 点名批评方 | 未被提及的直接竞品 |
| 隐性 | 产业链上下游 | 替代方案持有者 | 等待观望者 |

**注意：** 官方口径 ≠ 真实意图。看"被点名方"的后续动作来判断真正影响力。

### ④ 提启示（二阶思维）

```
A 发生了 → 监管/市场/受众会怎么反应 → 再下一步会怎样
```

**落点：** 对我（投资/工作/判断）意味着什么？

- 短期影响（1-3 个月）
- 中期趋势（半年到一年）
- 需要关注的关键信号

---

## Step 4 — 输出信息卡片

结果以 3:4 竖版信息卡片呈现，格式如下：

```
┌──────────────┐
│  🦞 小龙虾分析  │
│  📅 2025-XX-XX  │
├──────────────┤
│              │
│  📌 关键洞察    │
│  （一句话定论）  │
│              │
│  🔍 定位        │
│  [类型 + 替代了什么] │
│              │
│  💬 文本信号     │
│  · 谁说的 / 对谁说 │
│  · 关键用词      │
│              │
│  🏢 利益相关方    │
│  受益：...      │
│  承压：...      │
│              │
│  💡 启示        │
│  二阶：...      │
│  对我：...      │
│              │
│  📎 来源：[链接]  │
└──────────────┘
```

### 多卡片的处理

如果同一个主题搜到多个方向的信息（如技术进展 + 公司动态 + 论文），分别出卡，每个卡片聚焦一个子话题。

---

## 脚本

### scripts/agent-search.sh

```bash
bash scripts/agent-search.sh "<query>" [max_results] [language] [tag] [mode]
```

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `query` (必填) | 搜索查询 | — |
| `max_results` | 返回结果数 (1-20) | 10 |
| `language` | `en` / `zh-CN` | `en` |
| `tag` | 能力标签 | `general.general` |
| `mode` | 输出模式：`normal` / `json` | `normal` |

### Tag 选择指南

| Tag | 适合场景 |
|-----|---------|
| `general.general` | 通用新闻资讯 |
| `code.doc` | 技术文档、API 参考 |
| `academic.search` | 学术论文检索 |
| `code.snippet` | 开源代码搜索 |
| `finance.news` | 公司动态、融资 |
| `social_media.social_media` | 社区讨论热度 |

完整 tags：[tags.md](references/tags.md)

## API 参考

参数详情和响应结构见 [AnySearch 官方文档](https://www.anysearch.com/docs)。

## 环境要求

- `curl` — HTTP 请求
- `python3` — JSON 解析
- `jq` (可选) — JSON 构建

## 使用方法

```bash
# 1. 设置 API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 2. 搜索（可读模式）
bash scripts/agent-search.sh "RAG 知识库构建 2025" 10 zh-CN

# 3. 搜索（JSON 模式，供 Agent 后续分析）
bash scripts/agent-search.sh "LangChain vs LangGraph" 15 en code.doc json

# 4. 免费注册获取 API Key：https://www.anysearch.com
```
