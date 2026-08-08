# 🦞 Agent Intel — 知识收集 + 深度分析

<p align="center">
  <img src="assets/logo.svg" width="600" height="225" alt="Agent Intel Logo">
</p>

<p align="center">
  <b>基于 AnySearch API 的 AI 知识收集与深度分析工具</b><br>
  检索 → 四步分析 → 3:4 信息卡片
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License MIT">
  <img src="https://img.shields.io/badge/AnySearch-API-00d4ff" alt="AnySearch API">
  <img src="https://img.shields.io/badge/OpenClaw-Skill-7c3aed" alt="OpenClaw Skill">
</p>

---

不只要"搜到"，更要"读懂"。用五步工作流把碎片信息变成可用的深度洞察。

## 工作流

```
用户主题 → 拆解检索词 → AnySearch 检索 → 四步分析 → 输出信息卡片
```

### Step 1 — 拆解检索词

收到一个主题后，拆成多个精准检索词。例如"RAG 最新进展"：

- `RAG 检索增强生成 2025 最新进展`
- `RAG knowledge base production 2025`
- `RAG evaluation benchmark 2025`

### Step 2 — 检索

```bash
# 可读输出
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag]

# JSON 输出（供程序化分析）
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag] json
```

### Step 3 — 四步分析

对检索结果逐条分析，合并交叉验证：

**① 定位背景** — 判断新闻类型（宏观/行业/突发/舆论），问"替代了什么状态"

**② 拆文本信号** — 谁说的、对谁说、用了什么词、没说什么

**③ 利益相关方映射** — 谁受益、谁承压、谁沉默

**④ 提启示** — 二阶思维：A→反应→再下一步→对我意味着什么

### Step 4 — 输出信息卡片

3:4 竖版卡片，聚焦一个子话题，包含：关键洞察、定位、文本信号、利益相关方、启示、来源。

多个方向的信息分别出卡。

## 快速开始

```bash
# 1. 克隆
git clone https://github.com/wp931120/agent-intel.git
cd agent-intel

# 2. 设置 API Key
export ANYSEARCH_API_KEY="as_sk_xxxxxx"

# 3. 搜索
bash scripts/agent-search.sh "RAG 知识库构建" 10 zh-CN

# 4. JSON 模式（供分析）
bash scripts/agent-search.sh "RAG 知识库构建" 10 zh-CN general.general json
```

> 💡 免费注册获取 API Key：[AnySearch Console](https://www.anysearch.com)

## 脚本参数

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
├── SKILL.md                    # OpenClaw Skill 主文件（含完整工作流与方法论）
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
