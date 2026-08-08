# 🦞 小龙虾 — AI 知识收集工作流

不要收藏链接，要消化信息。
每天自动跑一套流程，让 AI 帮你建一个活的私人知识库。

---

每天刷 AI 消息的都知道：
搜出来的全是广告，点进去一半是重复的旧闻，好不容易攒点东西，散落在收藏夹、截图、备忘录里，根本形不成沉淀。更别说每次喂给 AI 还要浪费大把 Token 去处理这些垃圾信息。

后来我干脆自己搭了一套 **小龙虾 + AnySearch** 自动化收集工作流，现在每天醒来，素材已经躺在本地库里了。

## 🦞 核心链路（照着抄就行）

```
输入主题 → 拆解检索词 → AnySearch 检索 → 信息提纯去重 → 生成结构化文档 → 本地知识库归档
```

这套流程之所以丝滑，是因为 AnySearch 解决了几个致命痛点：

**✅ 纯净输出**
直接过滤广告和同源重复内容，吐出来的就是干净的 Markdown，拿来就能用。

**✅ 垂直精准**
支持通用、学术、代码、金融等多领域检索，不是泛泛的爬虫。

**✅ 接入自由**
不管你是用 Skill、MCP 还是直接调 API，都能无缝嵌进你的 Agent 里。

**✅ 免费额度足**
学生和开发者认证后，每天有 2000 次免费调用，日常搜集完全够造。

## 🆚 实测对比

以前用普通搜索：搜 10 个词，5 个是广告，3 个重复，剩下 2 个还得手动洗稿。

现在用小龙虾 + AnySearch：AI 自己跑检索、自己去重、自己归档，产出的素材直接就是一篇笔记的初稿。

## 🛠️ 3 步上手搭建

**第 1 步：部署小龙虾**
```bash
git clone https://github.com/wp931120/agent-intel
cd agent-intel
```

**第 2 步：接入 AnySearch**
在配置里选 Skill 或 MCP 模式，填入检索技能。
```bash
export ANYSEARCH_API_KEY="as_sk_xxxxxx"
```

**第 3 步：领 Key 跑起来**
去 [anysearch.com](https://www.anysearch.com) 注册账号，领 API Key，配置好你关心的知识收集规则，启动。

```bash
bash scripts/agent-search.sh "RAG 知识库构建 2026" 10 zh-CN
```

现在你的知识库不再是"垃圾堆"，而是每天自动更新的"弹药库"。

## 📂 目录结构

```
agent-intel/
├── SKILL.md                    # OpenClaw Skill 主文件
├── scripts/
│   └── agent-search.sh         # AnySearch 搜索封装脚本
├── references/
│   ├── tags.md                 # AnySearch Tags 参考
│   └── analysis-card-template.html  # 3:4 信息卡片模板
├── examples/                   # 每日简报存档
│   └── ai-daily-brief-2026-08-08.html
├── knowledge-base/             # 本地知识库（自动归档）
│   ├── topics/
│   │   ├── rag/
│   │   ├── multi-agent/
│   │   └── llm-ops/
│   ├── papers/
│   ├── tools/
│   └── daily/
└── README.md
```

## 实战：每日 Agent 简报

每天用这个 skill 跑三个方向：

| 方向 | 标签 | 产出 |
|------|------|------|
| 🔵 模型更新 | ⭐ 必出 | 深度分析卡片 |
| 🟢 开源项目 | ⭐ 必出 | 技术亮点卡片 |
| 🟣 论文突破 | ⭐ 必出 | 可用性判断卡片 |

每张卡片格式固定：

```
📰 信息 — 发生了什么，数字是多少
🔍 洞察 — 话里有话，对 Agent 开发者意味着什么
⚖️ 利益 — 哪些框架/工具/模式变了
💡 启示 — 这周做什么、关注什么信号
```

卡片自动归档到 `knowledge-base/` 目录，日积月累。

## 参数说明

```bash
bash scripts/agent-search.sh "<query>" [max_results] [language] [tag] [mode]
```

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `query`（必填） | 搜索查询 | — |
| `max_results` | 1-20 条 | 10 |
| `language` | `en` / `zh-CN` | `en` |
| `tag` | 能力标签 | `general.general` |
| `mode` | `normal` / `json` | `normal` |

### Tags 选择

| Tag | 适合场景 |
|-----|---------|
| `general.general` | 通用资讯 |
| `code.doc` | 技术文档、API 参考 |
| `academic.search` | 学术论文 |
| `code.snippet` | 开源代码 |
| `finance.news` | 公司动态、融资 |
| `social_media.social_media` | 社区讨论 |

完整 tags：[references/tags.md](references/tags.md)

## 依赖

- `curl` — HTTP 请求
- `python3` — JSON 解析
- `jq`（可选）— JSON 构建

## 许可证

MIT

📁 [github.com/wp931120/agent-intel](https://github.com/wp931120/agent-intel)
🔑 [anysearch.com](https://www.anysearch.com)
