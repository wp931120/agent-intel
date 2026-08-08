---
name: agent-intel
description: AI 知识收集与情报分析专家。使用 AnySearch API 自动化完成信息检索、去重提纯、结构化整理到本地知识库归档的完整工作流。支持 Skill/MCP/API 三种接入方式，自动过滤重复内容，直出纯净 Markdown。适用于：行业动态跟踪、技术文档采集、学术论文检索、知识库构建等场景。适用关键词：知识收集、信息检索、情报分析、自动化工作流、AnySearch、知识库、内容去重、信息提纯等。
---

# Agent Intel — AI 知识收集工作流

> 🦞 **小龙虾 AI 知识收集工作流** — 输入主题 → 拆解检索词 → AnySearch 检索 → 信息提纯去重 → 生成结构化文档 → 本地知识库归档

使用 AnySearch API 构建端到端的知识收集管线。支持多维度搜索、自动过滤同源重复、纯净 Markdown 输出，让你告别信息杂乱和 Token 浪费。

## 快速开始

```bash
# 设置 API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 搜索并生成知识文档
bash scripts/agent-search.sh "RAG 知识库构建最佳实践" 10 zh-CN

# 多维度搜索（搭配信息提纯脚本）
bash scripts/agent-search.sh "multi-agent system" 15 en general.general > raw.json
bash scripts/purify.sh raw.json purified.md
```

## 🔗 三种接入方式

| 方式 | 集成路径 | 适用场景 |
|------|---------|---------|
| 🛠 Skill | OpenClaw 对话触发 | 日常随口检索 |
| 🔌 MCP | 标准 MCP 协议接入 | 开发者深度集成 |
| 🌐 API | REST API 调用 | 自定义工作流 |

## 📦 搜索维度

覆盖 6 大情报维度，按需选择 Tag 精准定位：

| 维度 | 推荐 Tag | 用途 |
|------|---------|------|
| 📰 动态资讯 | `general.general` | 行业新闻、产品发布、趋势分析 |
| 📚 技术文档 | `code.doc` | 框架文档、API 参考、最佳实践 |
| 🎓 学术研究 | `academic.search` | 论文、预印本、学术报告 |
| 💻 开源代码 | `code.snippet` | GitHub 代码实现、架构模式 |
| 💰 市场动态 | `finance.news` | 公司动态、融资、财报 |
| 💬 社区讨论 | `social_media.social_media` | 社区热度、趋势讨论 |

## 🔧 知识收集工作流

### 🎯 痛点 — 信息时代的三大困境

| 痛点 | 表现 | 后果 |
|------|------|------|
| 🧩 信息杂乱 | 搜索结果广告多、无关内容穿插 | 筛选耗时长，有效信息占比低 |
| 🔁 内容重复 | 同一事件被多家媒体搬运改写 | 重复阅读浪费 Token 和注意力 |
| 💾 沉淀困难 | 看完即忘，没有体系化归档 | 知识零散不成系统，难以复用 |

### ✅ 小龙虾工作流 — 五步搞定

```
输入主题 → 拆解检索词 → AnySearch 检索 → 信息提纯去重 → 生成结构化文档 → 归档到本地知识库
```

### 🦞 组合优势

- **多渠道接入**：Skill / MCP / API 三种方式灵活切换
- **纯净输出**：直出 Markdown，无广告无干扰，内容即用
- **自动去重**：智能过滤同源和重复信息，节约 Token
- **精准检索**：垂直领域 Tags 确保结果高相关
- **免费额度**：认证学生/开发者每日 2000 次免费调用

### 实战场景

#### 1️⃣ 行业知识采集

```bash
# 中文技术专题
bash scripts/agent-search.sh "大模型应用落地企业实践 2025" 15 zh-CN

# 英文前沿跟踪
bash scripts/agent-search.sh "autonomous agent production deployment" 15 en

# 定向跨域搜索
bash scripts/agent-search.sh "Agentic RAG pipeline" 10 en code.doc
```

#### 2️⃣ 论文与学术追踪

```bash
bash scripts/agent-search.sh "tool learning LLM planning" 20 en academic.search
```

#### 3️⃣ 竞品与市场动态

```bash
bash scripts/agent-search.sh "Notion AI knowledge base competitor" 10 en
bash scripts/agent-search.sh "个人知识管理工具 对比评测" 10 zh-CN finance.news
```

#### 4️⃣ 开源项目速览

```bash
bash scripts/agent-search.sh "knowledge retrieval tool framework" 10 en code.snippet
```

### 信息提纯（purify 脚本）

搜索结果先过 purify 脚本：

```bash
# raw.json 是搜索输出的 JSON 文件
# purified.md 是去重整理后的纯净 Markdown

bash scripts/purify.sh raw.json purified.md
```

效果对比：

| 处理阶段 | 输出 | Token 占用 |
|---------|------|-----------|
| 搜索结果 | 原始 JSON，含元数据和冗余字段 | ❌ 大 |
| 提纯去重后 | 纯净 Markdown，去重内容归并 | ✅ 小 |
| 结构化归档 | 前后文连贯的知识文档 | ✅ 最小 |

### 知识归档

提纯后的 Markdown 文档按以下结构归档到本地知识库：

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

## 📊 实测对比：普通搜索 vs 小龙虾工作流

| 维度 | 普通上网搜索 | 小龙虾 + AnySearch |
|------|------------|-------------------|
| 筛选方式 | 人工逐个翻页 | AI 自主检索筛选 |
| 内容质量 | 广告/SEO 掺杂 | 纯净 Markdown 输出 |
| 重复控制 | 肉眼去重 | 自动过滤同源重复 |
| 产出格式 | 散落在浏览器 tab | 结构化知识文档 |
| 归档 | 无 | 直接归入本地知识库 |
| 学习成本 | 上网即可 | 1 分钟部署 |

## ⚡ 上手步骤

```bash
# 第 1 步：部署小龙虾
git clone https://github.com/wp931120/agent-intel.git
cd agent-intel

# 第 2 步：安装依赖
# 确保有 curl 和 python3

# 第 3 步：接入 AnySearch 检索技能
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 第 4 步：配置知识收集规则
# 编辑 scripts/collect-rules.sh 或直接修改环境变量

# 第 5 步：开始收集
bash scripts/agent-search.sh "你的研究主题" 10 zh-CN

# 💡 免费注册获取 API Key：https://www.anysearch.com
```

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
