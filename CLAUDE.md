# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

中文 OI（信息学奥赛）个人博客，基于 Hugo + Hextra 主题，部署在 GitHub Pages (`enigma-soul.github.io`)。主语言为简体中文 (zh-cn)，并提供英文 (en-us) 翻译版本.

## 常用命令

```bash
hugo.exe server -D          # 本地开发服务器（含草稿）
hugo.exe server -D --bind 0.0.0.0   # 同上，允许局域网访问
hugo.exe --minify           # 生产构建
hugo.exe --renderToMemory   # 仅校验构建（不写出 public/，用于快速验证配置）
hugo.exe new content oi-blog/新文件/_index.md                       # 默认 archetype
hugo.exe new content oi-blog/新算法/_index.md --kind algorithm      # 算法笔记模板
hugo.exe new content oi-blog/新STL/_index.md --kind stl             # STL 笔记模板
```

推送 `main` 分支会自动触发 GitHub Actions 部署到 `gh-pages` 分支。**默认推送到 `develop` 分支，不要直接推 `main`。**

## 架构要点

- **配置**: 单一 `hugo.yaml`，无多环境配置
- **主题**: Hextra（git 子模块 `themes/hextra/`），项目根目录 `layouts/` 为空，所有模板来自主题
- **内容组织**: 全部在 `content/` 下，主要分区：
  - `oi-blog/` — OI 博客（`STL/`、`algorithm/`、`math/`）
  - `books/` — 读书笔记（如《算法图解》）
  - `production_code/` — 非 OI 工程笔记（`ai/`、`virtual/`）
  - `categories/` — 分类聚合页（Hugo 自动生成，`categories/OI/_index.md` 等可自定义）
- **内容类型**: 所有页面 front matter 使用 `type: docs`，对应 Hextra docs 布局
- **评论**: Giscus（基于 GitHub Discussions），页面通过 `comments: true` 启用
- **数学公式**: LaTeX 通过 Goldmark passthrough 扩展支持，行内 `\(...\)` 或 `$...$`，行间 `$$...$$`
- **搜索**: FlexSearch，索引全文内容
- **国际化**: `i18n/zh-cn.yaml` 与 `i18n/en-us.yaml` 为项目自定义字符串（下划线风格 key，如 `search_placeholder`），覆盖主题同名文件；主题驼峰风格 key（如 `searchPlaceholder`）由 `themes/hextra/i18n/` 兜底
- **静态资源**: `static/` 下存放 favicon 系列文件（`favicon.ico`、`favicon.svg`、`apple-touch-icon.png` 等），覆盖主题默认 Hextra logo
- **短代码**: 使用 Hextra 提供的 `tabs`、`tab`、`details`、`card` 等
- **CI**: `.github/workflows/deploy.yml`，Hugo latest extended，推 main 自动部署到 `gh-pages`

## Front Matter 规范

Archetype 文件在 `archetypes/` 下：

- `default.md` — 通用页面，`date` 由 Hugo 自动生成
- `algorithm.md` — 算法笔记（`--kind algorithm`）
- `stl.md` — STL 笔记（`--kind stl`）

标准 front matter 字段：

```yaml
---
title: "页面标题"
comments: true          # 内容页 true，_index.md 和首页 false
date: '{{ .Date }}'     # Hugo 自动填入当前时间
draft: false
categories: [OI]        # OI 相关内容填 [OI]，其余填 []
tags: []                # 如 [STL]、[hash]、[prefix,difference]
description: "一句话描述"
type: docs
---
```

## 写作规范

**必须遵循** `write-style.md` 中的规范，核心要点：

- **标题层级**: 从 `##` 开始（一级标题由 Hugo 自动生成），依次 `##` → `###` → `####`
- **中英文间距**: 中文与英文之间必须有一个半角空格；中文与数字之间风格统一即可
- **句末标点**: 作为说明文，句尾用 `.` 不用 `。`；短行内（<50 字）可省略句点
- **括号**: 中文用全角 `（）`，英文用半角 `()`，括号前后不加空格
- **引号**: 简体中文使用直角引号 `「」`，嵌套用 `『』`
- **段落**: 段间一个空行，段首不缩进，段落控制在五行以内
- **说明过程**: 杜绝「防自学」机制，同一标题内的过程分为大过程（`*` 无序列表）与小过程（`1.`、`2.` 有序列表）；可选项用一对 `*`（斜体）写在小过程内；过程末尾不得追加「注：」注解，所有补充说明须写进对应小过程
- **文件名**: 不得含空格，多词用 `-` 连接
- **行内代码**: 用单反引号 `` `code` `` 包裹，不用三反引号 `` ```code``` ``；行内代码与中文之间加空格
- **算法专有短语**: 任何算法/数据结构中的专有名词、术语、关键短语必须用反引号包裹。**中文专有术语不加空格**直接嵌入中文中（如「`负载因子`过大会导致`哈希冲突`」），**英文专有术语与中文之间加空格**（如「使用`红黑树`实现的 `map` 容器」），典型术语如 `前缀和`、`差分`、`容斥原理`、`红黑树`、`哈希冲突`、`负载因子`、`双射` 等
- **禁止 archetype 提示残留**: `content/` 下的正式内容不得出现 archetype 模板中的括号提示（如 `（提示内容）`、`（按需）`、`（按需保留）`）和 `> 💡` / `> 用法模板` 等 blockquote 提示。这些仅存在于 `archetypes/` 模板中，正式笔记中应替换为实际内容

## 内容模板

`archetypes/` 下有两个笔记结构模板：

- **`algorithm_template.md`** → `archetypes/algorithm.md` — 算法笔记：前置知识 → 基本概念 → 原理推导 → 复杂度分析 → 适用场景 → 代码模板 → 关键点 → 例题 → 扩展
- **`stl_template.md`** → `archetypes/stl.md` — STL 笔记：定位 → 定义与声明 → 复杂度 → 常用接口 → 代码片段 → 注意事项 → 同类对比 → 例题 → 扩展

两者均含 💡 标记的思考点，是笔记重点应填写的部分。

## 多语言与翻译

站点为双语：`zh-cn`（默认，根路径 `/`）与 `en-us`（子路径 `/en-us/`），配置在 `hugo.yaml` 的 `languages` 块，`defaultContentLanguageInSubdir: false` 使中文留在根路径.

**翻译规则（重要）**：

- Claude 协助将中文内容翻译为英文（`zh-cn` -> `en-us`），**严禁修改原始 `zh-cn` 内容**--原文是唯一事实来源
- 英文译文须在页面顶部标注翻译来源，使用 blockquote 写明「本文由 LLM 翻译」**不得标注具体模型名称/版本**
- 译文遵循英文排版规范：中英文间距规则不适用，句末用 `.`，半角括号 `()`，引号用 `" "`（英文不用直角引号）

**创建英文版页面**的两种方式（任选其一）：

1. **同名后缀**（推荐，与中文原文件同目录）：`content/oi-blog/STL/_index.md` 对应 `content/oi-blog/STL/_index.en-us.md`
2. **独立目录**：`content.en-us/` 镜像 `content/` 结构

front matter 的 `title`、`description` 等字段须一并翻译；`date`、`draft`、`categories`、`tags`、`type` 保持与原文一致.

## 注意事项

- `.cph-ng/` 目录是 VS Code Competitive Programming Helper 扩展的数据，非项目内容
- 主题最低 Hugo 版本要求：0.146.0
- 代码块语言标记用 `cpp`（不用 `c++`），纯文本用 `text`
- 编辑或创建内容后，用 `hugo.exe server -D` 预览确认渲染正常
