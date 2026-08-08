---
name: agent-intel
description: 每日 AI 简报生成器。使用 AnySearch API 检索 AI 领域最新动态，通过四维分析（信息·洞察·利益·启示）输出 3:4 竖版 HTML 信息卡片。支持单事件/多源融合分析，主次布局设计。适合每日早报、行业快讯、投研分析等场景。支持 Skill/MCP/API 三种接入方式。
---

# 🦞 每日 AI 简报生成器

基于 [AnySearch API](https://www.anysearch.com) 的每日 AI 动态采集与深度分析工具。搜到信息后按四维拆解，输出可传播的 HTML 卡片。

## 工作流

```
选题 → 拆检索词 → AnySearch 检索 → 四维分析 → 生成 HTML 卡片
```

---

## Step 1 — 选题

每日自动扫描 AI 领域热点，或由用户指定。典型方向：

- **模型发布/更新**（GPT、Claude、Llama、Gemini 等）
- **融资与公司动态**
- **论文突破**
- **政策与监管变动**
- **安全与治理事件**
- **行业应用落地**

**选题优先级排序：**
1. ⭐ 模型/产品重大发布 → 头条级，必出卡
2. ⭐ 融资/并购达到 1 亿美元以上 → 行业信号，出卡
3. 安全事件/监管变化 → 出卡
4. 论文突破 → 判断实际影响力，选择性出卡
5. 普通产品更新/公司日常 → 合并到"本周速览"

**重要原则：** 同一主题的多条新闻（如发布会多家报道、融资+竞品对比）必须**融合分析到一张卡**，不分散出卡。一条消息单独也能出卡时，评估它是否真的"一条撑得起一张卡"——否则合并或舍弃。

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

**四维分析深度要求：**
- 每条信息必须有具体数字/事实支撑，不写空话
- 洞察要揭示"没明说但重要"的意图或趋势
- 利益要区分显性和隐性玩家
- 启示必须落到具体行动信号，不止是喊口号

## Step 5 — 生成 HTML 卡片

参考模板：[analysis-card-template.html](references/analysis-card-template.html)

### 卡片结构（固定画布 1500×2000px）

```
┌─────────────────────────────┐  1500px
│  ✦ AI·DAILY      2025.08.08 │  顶部栏
├─────────────────────────────┤
│                             │
│  安全危机  · 融合分析4sources│
│  AI Agent 失控              │  标题区
│  安全测试全线失守            │  ~500px
│  一句话摘要                  │
│                             │
├──────────┬──────────────────┤
│ 📰 信息   │ 🔍 洞察          │
│ (全宽条纹) │ (半宽)           │  ~1100px
│          │                  │
│ ⚖️ 利益   │                  │  主体 Grid
│ (半宽)    │                  │  2列混排
│          │                  │
│ 💡 启示   │                  │
│ (全宽)    │                  │
├──────────┴──────────────────┤
│  01            🦞 简报      │  底部栏
└─────────────────────────────┘  2000px
```

### 主题色系统

| 类型 | 色值 | 标签 |
|------|------|------|
| 模型发布 | `#5b9aff` 蓝 | model |
| 政策监管 | `#ff6b6b` 红 | policy |
| 融资动态 | `#ffb347` 橙 | funding |
| 论文突破 | `#c084fc` 紫 | research |
| 行业整合 | `#4dd0e1` 青 | merger |

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
