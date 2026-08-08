# 🦞 Agent Intel — AI 知识收集工作流

<p align="center">
  <img src="assets/logo.svg" width="600" height="225" alt="Agent Intel Logo">
</p>

<p align="center">
  <b>基于 AnySearch API 的 AI 知识收集自动化管线</b><br>
  输入主题 → 拆解检索词 → AnySearch 检索 → 去重提纯 → 输出结构化文档
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License MIT">
  <img src="https://img.shields.io/badge/AnySearch-API-00d4ff" alt="AnySearch API">
  <img src="https://img.shields.io/badge/OpenClaw-Skill-7c3aed" alt="OpenClaw Skill">
</p>

---

一个 shell 脚本 + 一个 Skill 描述，搭出完整的 AI 知识收集管线。适合：行业跟踪、论文检索、技术调研、本地知识库建设。

## 工作流

```
输入主题 → 拆解检索词 → AnySearch 检索 → 去重提纯 → 输出结构化文档
```

### Step 1 — 拆解检索词

收到一个主题后，拆成多个精准检索词。例如"RAG 最新进展"可拆为：

- `RAG 知识库构建 2025 最佳实践`
- `RAG 检索增强生成 最新论文 2025`
- `RAG 企业落地案例`

### Step 2 — 调用脚本检索

```bash
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag]
```

脚本调用 AnySearch API，返回格式化结果 + 原始 JSON。

### Step 3 — 去重提纯

Agent 对 JSON 结果做三道工序：

1. **去重** — 识别同源/同事件报道，保留信息增量最大的
2. **提纯** — 去掉广告、SEO 灌水、无关元数据
3. **结构化** — 按统一格式整理

### Step 4 — 输出文档

纯净 Markdown 输出，可直接归档到本地知识库：

```
knowledge-base/
└── topics/
    ├── rag/
    ├── multi-agent/
    └── llm-ops/
```

## 快速开始

```bash
# 1. 克隆
git clone https://github.com/wp931120/agent-intel.git
cd agent-intel

# 2. 设置 API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 3. 搜索
bash scripts/agent-search.sh "RAG 知识库构建" 10 zh-CN
```

> 💡 免费注册获取 API Key：[AnySearch Console](https://www.anysearch.com)

## 脚本参数

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

完整 tags：[tags.md](references/tags.md)

## 实战场景

### 行业知识采集

```bash
bash scripts/agent-search.sh "大模型应用落地 2025" 15 zh-CN
bash scripts/agent-search.sh "autonomous agent production deployment" 15 en
bash scripts/agent-search.sh "Agentic RAG pipeline" 10 en code.doc
```

### 论文追踪

```bash
bash scripts/agent-search.sh "tool learning LLM planning" 20 en academic.search
```

### 竞品动态

```bash
bash scripts/agent-search.sh "Notion AI knowledge base competitor" 10 en
bash scripts/agent-search.sh "个人知识管理工具 对比" 10 zh-CN finance.news
```

## OpenClaw Skill

安装后对话中直接触发：

```bash
openclaw skills install agent-intel --file agent-intel.skill
```

## 目录结构

```
agent-intel/
├── SKILL.md                    # OpenClaw Skill 主文件
├── scripts/
│   └── agent-search.sh         # AnySearch 搜索封装
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
- `python3` — JSON 解析
- `jq` (可选) — JSON 构建

## 许可证

MIT
