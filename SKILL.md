---
name: agent-intel
description: 每日 Agent 简报生成器。面向 AI Agent 从业者和学习者，使用 AnySearch API 检索 AI 领域最新动态，通过四维分析（信息·洞察·利益·启示）输出 3:4 竖版 HTML 信息卡片。关注模型更新、Agent 框架变化、工具生态、最佳实践等对 Agent 开发者有实际影响的话题。支持单事件/多源融合分析，内置 SVG 图形增强卡片视觉层次。
---

# 🦞 每日 Agent 简报

> **面向 AI Agent 从业者和学习者。** 不追泛泛的行业新闻，只关注对 Agent 开发、选型、部署有实际影响的变化。

基于 [AnySearch API](https://www.anysearch.com) 的每日 AI Agent 动态采集与深度分析工具。搜到信息后按四维拆解，输出带有 SVG 图形的 3:4 HTML 卡片。

## 工作流

```
选题 → 拆检索词 → AnySearch 检索 → 四维分析 → 生成 HTML 卡片（含 SVG 图形）
```

---

## Step 1 — 选题

从 **Agent 开发者视角** 筛选今日值得关注的信息。优先级排序：

| 级别 | 话题类型 | 出卡规则 |
|------|---------|---------|
| ⭐ 必出 | 模型重大更新（GPT-5/Claude Opus 4.1 等） | 单卡深度分析 |
| ⭐ 必出 | Agent 框架/工具发布（LangChain/CrewAI/AutoGPT 等） | 单卡 |
| ⭐ 必出 | API 定价/成本结构变化 | 融合到相关卡 |
| 🔵 推荐 | 安全事件（agent 失控/越狱/数据泄露） | 单卡 |
| 🔵 推荐 | 版权/合规判例（训练数据/Agent 责任） | 单卡 |
| 🔵 推荐 | 开源项目里程碑 | 可融合 |
| ⚪ 可选 | 融资、宏观政策 | 仅当影响 Agent 生态时出卡 |
| ⚪ 可选 | 论文突破 | 仅当工具可用时出卡 |

**原则：** 每一张卡都要回答"这对 Agent 开发者意味着什么？"这个问题。

## Step 2 — 拆解检索词

每个选题拆成 2-3 个精准检索词。例如"Claude 新功能"：

- `Claude Anthropic new features 2025`
- `Claude API update latest`
- `Claude vs GPT benchmark 2025`

## Step 3 — 检索

```bash
# JSON 模式（供分析，推荐）
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag] json

# 可读模式
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag]
```

**检索策略：**
1. 先搜中文 + 英文各一轮，覆盖信息面
2. 每条结果至少看 content 全文（不仅有 snippet），提取关键数字、信源、直接引用
3. 如有偏 finance 的选题（融资/财报/并购），额外用 `finance.news` tag + 设 `params.type=market` 搜索
4. 同主题多条结果时，交叉验证事实一致性，标注冲突点

## Step 4 — 四维分析

对每条信息按四个维度拆解：

| 维度 | 问什么 |
|------|--------|
| 📰 **信息** | 发生了什么？谁说的？关键数字？ |
| 🔍 **洞察** | 话里有话？反映什么趋势？ |
| ⚖️ **利益** | 谁受益？谁承压？谁观望？ |
| 💡 **启示** | 然后呢？对我意味着什么？ |

### 两种分析模式

**单事件模式** — 一条消息独立出卡。来源单一，事实清晰。判断标准：这条消息是否足够重要/有趣到独立成卡？如果答案是"还行但不够"，合并到融合卡。

**融合分析模式** — 同一主题的多个消息合并到一张卡。来源在每项底部标注，适用于：
- 一个事件被多家报道（如 GPT-5 发布会 × TechCrunch + The Verge + Bloomberg）
- 多个事件指向同一趋势（如 Cursor 融资 + Devin 融资 = AI 编程赛道升温）
- 正反观点需交叉对比（如 GPT-5 好评 + 翻车并置）

**每日简报产卡标准：**
- 重大事件日（如今天 GPT-5 发布）：3 张卡，各有侧重
- 普通日：1-2 张融合卡 + 1 条"本周速览"文字摘要
- 周末/假日：不出卡，只更新"本周回顾"文字版

**四维分析深度要求（Agent 开发者视角）：**
- 每条信息必须从"对 agent 开发/选型/部署的实际影响"角度切入
- 洞察要回答"这个变化意味着 agent 架构要改吗？技术栈要换吗？
- 利益要分析"哪些 agent 框架/工具/模式受益或受损"
- 启示必须落到具体行动：这周做什么、这个月做什么、关注什么信号
- 避免宏观判断（"利好行业"），写好具体判断（"LangChain 的用户可以重构 model router 层了"）

## Step 5 — 生成 HTML 卡片

参考模板：[analysis-card-template.html](references/analysis-card-template.html)

### 卡片结构（固定画布 1500×2000px）

每张卡片包含以下视觉层次：

**1. 装饰元素（SVG）**
- 左上角色标 + 底部水印 SVG 图形（圆环/箭头/代码块风格，与主题呼应）
- 顶部渐变强调条（4px，匹配主题色）
- 品牌水印位于右下角，透明度 2.5%，不干扰内容

**2. 内容布局**

```
┌─────────────────────────────┐ 1500px
│ ■■■■■（顶部渐变色条）         │
│ AGENT·DAILY      2025.08.08 │ 顶部栏
├─────────────────────────────┤
│ 🧩 Agent 生态  融合 · 8sources│
│ 标题（58px 大宋体）           │ 标题区
│ 一句话摘要                   │ 含右侧 SVG 图标
├──────────┬──────────────────┤
│ 📰 关键事实│ 🔍 影响分析      │
│           │                 │ 主体 Grid
│   全宽登场 │  左 1.25 右 0.75│
│           │                 │
│ 💡 行动建议 │                 │
│   全宽底部  │                 │
├──────────┴──────────────────┤
│ 01            🦞 简报       │ 底部栏
└─────────────────────────────┘ 2000px
```

**3. 主题色系统**

| 标签 | 色值 | 适用话题 |
|------|------|---------|
| 模型更新 | `#58a6ff` 蓝 | GPT/Claude/Llama 发布 |
| Agent 生态 | `#3fb950` 绿 | 框架/工具/开源 |
| 工具链 | `#d29922` 金 | API/SDK/平台更新 |
| 研究突破 | `#bc8cff` 紫 | 论文/算法进展 |
| 安全合规 | `#f85149` 红 | agent 事故/监管/版权 |

**4. 品牌标识**
- 头部品牌名改为 `AGENT·DAILY`，强调面向 Agent 从业者
- 底部 tagline 改为"面向 AI Agent 从业者"

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

## 参考模板

卡片 HTML 结构参考：[analysis-card-template.html](references/analysis-card-template.html)

模板包含 4 张示例卡片：2 张融合分析 + 2 张单事件。

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

# 2. 检索（JSON 模式）
bash scripts/agent-search.sh "Claude Sonnet 4 features" 10 en general.general json

# 3. 查看卡片模板
open references/analysis-card-template.html

# 4. 免费注册获取 API Key：https://www.anysearch.com
```
