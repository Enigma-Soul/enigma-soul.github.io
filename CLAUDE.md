# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

中文 OI（信息学奥赛）个人博客，基于 Hugo + Hextra 主题，部署在 GitHub Pages (`enigma-soul.github.io`)。内容语言为简体中文 (zh-cn)。

## 常用命令

```bash
./hugo.exe server -D          # 本地开发服务器（含草稿）
./hugo.exe --minify           # 生产构建
./hugo.exe new content oi-blog/新文件.md   # 从 archetype 创建新页面
```

推送 `main` 分支会自动触发 GitHub Actions 部署到 `gh-pages` 分支。**默认推送到 `develop` 分支，不要直接推 `main`。**

## 架构要点

- **配置**: 单一 `hugo.yaml`，无多环境配置
- **主题**: Hextra（git 子模块 `themes/hextra/`），项目根目录 `layouts/` 为空，所有模板来自主题
- **内容组织**: 全部在 `content/` 下，主要分区：
  - `oi-blog/` — OI 博客（STL、算法、数学笔记）
  - `books/` — 读书笔记（如《算法图解》）
  - `ai/` — AI 工具配置指南
  - `sundry/` — 杂项
- **内容类型**: 所有页面 front matter 使用 `type: docs`，对应 Hextra docs 布局
- **评论**: Giscus（基于 GitHub Discussions），页面通过 `comments: true` 启用
- **数学公式**: LaTeX 通过 Goldmark passthrough 扩展支持，行内 `\(...\)` 或 `$...$`，行间 `$$...$$`
- **搜索**: FlexSearch，索引全文内容
- **国际化**: 自定义中文字符串在 `i18n/zh-cn.yaml`
- **短代码**: 使用 Hextra 提供的 `tabs`、`tab`、`details`、`card` 等
- **CI**: `.github/workflows/deploy.yml`，Hugo latest extended，推 main 自动部署

## Front Matter 规范

所有页面从 `archetypes/default.md` 生成，标准字段：

```yaml
---
title: "页面标题"
comments: true          # 内容页 true，_index.md 和首页 false
date: '2026-01-01T00:00:00+08:00'
draft: false
categories: [OI]        # OI 相关内容填 [OI]，其余填 []
tags: []                # 如 [STL]、[hash]、[prefix,difference]
description: "一句话描述"
type: docs
---
```

## 写作规范

**必须遵循** `content/oi-blog/template/write-style.md` 中的规范，核心要点：

- **标题层级**: 从 `##` 开始（一级标题由 Hugo 自动生成），依次 `##` → `###` → `####`
- **中英文间距**: 中文与英文之间必须有一个半角空格；中文与数字之间风格统一即可
- **句末标点**: 作为说明文，句尾用 `.` 不用 `。`；短行内（<50 字）可省略句点
- **括号**: 中文用全角 `（）`，英文用半角 `()`，括号前后不加空格
- **引号**: 简体中文使用直角引号 `「」`，嵌套用 `『』`
- **段落**: 段间一个空行，段首不缩进，段落控制在五行以内
- **文件名**: 不得含空格，多词用 `-` 连接
- **行内代码**: 用单反引号 `` `code` `` 包裹，不用三反引号 `` ```code``` ``；行内代码与中文之间加空格

## 内容模板

`content/oi-blog/template/` 下有两个笔记结构模板，新建 OI 笔记时参照对应模板：

- **`algorithm_template.md`** — 算法笔记：前置知识 → 基本概念 → 原理推导 → 复杂度分析 → 适用场景 → 代码模板 → 关键点 → 例题 → 扩展
- **`stl_template.md`** — STL 笔记：定位 → 定义与声明 → 复杂度 → 常用接口 → 代码片段 → 注意事项 → 同类对比 → 例题 → 扩展

两者均含 💡 标记的思考点，是笔记重点应填写的部分。

## 注意事项

- `hugo.exe` 是本地 Windows 用的 Hugo 二进制文件（已在 `.gitignore` 中）
- `.cph-ng/` 目录是 VS Code Competitive Programming Helper 扩展的数据，非项目内容
- 主题最低 Hugo 版本要求：0.146.0
- 代码块语言标记用 `cpp`（不用 `c++`），纯文本用 `text`
- 编辑或创建内容后，用 `./hugo.exe server -D` 预览确认渲染正常
