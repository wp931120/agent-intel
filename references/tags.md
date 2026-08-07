# Agent Intel — AnySearch Tags 参考

Tags 将搜索按领域分类。选择正确的 tag 可以获得更精准的结果。

## 1. academic — 学术研究

| Tag | 说明 | 参数 |
|-----|------|------|
| `academic.biomedical` | 生物医学文献（MEDLINE/MeSH/PMC） | 8 params |
| `academic.citation` | 引用关系、引用次数、参考文献 | 13 params |
| `academic.dataset` | 数据集、开源科学软件 | 4 params |
| `academic.preprint` | 预印本（CS/物理/数学/生物/经济） | 9 params |
| `academic.search` | 跨学科论文搜索（关键词/标题/作者/机构） | 9 params |

## 2. business — 商业/企业

| Tag | 说明 | 参数 |
|-----|------|------|
| `business.company` | 公司注册、股东结构、高管 | 2 params |
| `business.jobs` | 全球招聘（职位/技能/地点/薪资） | 4 params |
| `business.people` | 商业联系人搜索 | 5 params |
| `business.trade` | 国际贸易统计 | 5 params |

## 3. code — 代码/技术

| Tag | 说明 | 参数 |
|-----|------|------|
| `code.doc` | 开发者文档和代码示例（npm/PyPI/Cargo） | 1 param: `library` |
| `code.snippet` | GitHub 代码搜索（100万+仓库） | 3 params |

**AI Agent 用途**：搜索框架文档、API 用法、代码最佳实践。

## 4. finance — 金融/市场

| Tag | 说明 | 参数 |
|-----|------|------|
| `finance.calendar` | 财报日期、经济数据发布、IPO | 3 params |
| `finance.fundamental` | 财务报表、估值、分析师评级 | 4 params |
| `finance.macro` | 宏观经济指标 | 2 params |
| `finance.news` | 金融新闻、公司公告、研报 | 5 params |
| `finance.quote` | 实时和历史行情 | 4 params |
| `finance.screen` | 股票筛选 | 3 params |

## 5. general — 通用搜索

| Tag | 说明 |
|-----|------|
| `general.general` | 通用搜索（覆盖面最广） |

## 6. social_media — 社交媒体

| Tag | 说明 | 参数 |
|-----|------|------|
| `social_media.social_media` | 社交媒体信息搜索 | 3 params |

## 7. 其他领域

| 领域 | Tags | 说明 |
|------|------|------|
| agriculture | `agriculture.fao` | FAO 农业统计 |
| energy | `energy.electricity`, `energy.production` | 电力/能源数据 |
| environment | `environment.aqi` | 空气质量 |
| film | `film.torrent` | BT 种子资源 |
| gaming | `gaming.esports`, `gaming.store` | 电竞/Steam 数据 |
| health | `health.drug`, `health.stats`, `health.trial` | 药品/卫生/临床试验 |
| ip | `ip.global` | 全球专利检索 |
| legal | `legal.case`, `legal.legislation`, `legal.statute` | 判例/立法/法规 |
| resource | `resource.image` | 图片/插画搜索 |
| security | `security.intel`, `security.vuln` 等 | 安全情报 |
| travel | `travel.flight`, `travel.flight_status` | 机票/航班状态 |
