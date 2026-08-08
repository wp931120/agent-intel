---
name: agent-intel
description: 每日 AI 简报生成器。使用 AnySearch API 检索 AI 领域最新动态，通过四维分析（信息·洞察·利益·启示）输出 3:4 竖版 HTML 信息卡片。适合每日早报、行业快讯、投研分析等场景。支持 Skill/MCP/API 三种接入方式。
---

# 🦞 每日 AI 简报生成器

基于 [AnySearch API](https://www.anysearch.com) 的每日 AI 动态采集与分析工具。每天早上跑一轮，产出可传播的 HTML 信息卡片。

## 工作流

```
选题 → 拆检索词 → AnySearch 检索 → 四维分析 → 生成 HTML 卡片
```

---

## Step 1 — 选题

每日自动扫描 AI 领域热点，或由用户指定主题。典型选题方向：

- 大模型发布/更新（GPT、Claude、Llama、Gemini 等）
- AI 框架/工具新版本（LangChain、CrewAI、AutoGPT 等）
- 融资与公司动态
- 论文突破
- 政策与监管变动

## Step 2 — 拆解检索词

每个选题拆成 2-3 个精准检索词。例如"Claude 新功能"：

- `Claude Anthropic new features 2025`
- `Claude API update latest`
- `Claude vs GPT benchmark 2025`

## Step 3 — 检索

```bash
# JSON 模式 — 输出原始 JSON 供分析
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag] json

# 普通模式 — 直接看结果
bash scripts/agent-search.sh "<检索词>" <条数> <语言> [tag]
```

## Step 4 — 四维分析

对每条信息按四个维度拆解：

### 📰 信息
**事实层面：谁、什么、何时、何地、多少**
- 发生了什么？信源是谁？
- 关键数据/数字是什么？
- 替代了之前的什么认知？

### 🔍 洞察
**信号层面：话里有话、趋势判断**
- 措辞背后是什么意图？
- 这反映了什么趋势？
- 跟近期其他事件有什么关系？

### ⚖️ 利益
**格局层面：谁受益、谁承压**
- 直接受益方/受损方是谁？
- 产业链上下游谁被波及？
- 谁在沉默、谁在观望？

### 💡 启示
**行动层面：然后呢、对我意味着什么**
- 接下来会发生什么？
- 短期（1-3月）/中期（半年-1年）影响
- 我需要关注什么信号？

## Step 5 — 生成 HTML 卡片

每条分析输出一张 3:4 竖版 HTML 卡片（参考 `references/analysis-card-template.html`）。

### 卡片模板

```html
<!-- 每张卡片尺寸：3:4 比例，1080×1440px -->
<div class="card">
  <div class="card-header">
    <span class="card-tag">简报类型</span>
  </div>
  <div class="card-section">
    <h3>📰 信息</h3>
    <p>事实层内容...</p>
  </div>
  <div class="card-section">
    <h3>🔍 洞察</h3>
    <p>信号层分析...</p>
  </div>
  <div class="card-section">
    <h3>⚖️ 利益</h3>
    <p>格局层判断...</p>
  </div>
  <div class="card-section">
    <h3>💡 启示</h3>
    <p>行动层建议...</p>
  </div>
  <div class="card-footer">
    <span>🦞 每日 AI 简报 · YYYY-MM-DD</span>
    <span class="card-source">来源</span>
  </div>
</div>
```

### 多卡片简报

一个选题可能生成多张卡片：

- **主卡**：该选题的核心事件
- **副卡**：相关延展（如技术细节、竞品反应、历史对比）

最终生成一份完整的 HTML 简报页面，包含所有卡片。

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

# 2. 检索
bash scripts/agent-search.sh "Claude Sonnet 4 features" 10 en general.general json

# 3. 免费注册获取 API Key：https://www.anysearch.com
```
