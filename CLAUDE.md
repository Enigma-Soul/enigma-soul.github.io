# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

中文 OI（信息学奥赛）个人博客，基于 Hugo + Hextra 主题，部署在 GitHub Pages (`enigma-soul.github.io`)。内容语言为简体中文 (zh-cn)。

## 常用命令

```bash
./hugo.exe server -D          # 本地开发服务器（含草稿）
./hugo.exe --minify           # 生产构建
```

推送 `main` 分支会自动触发 GitHub Actions 部署到 `gh-pages` 分支。

## 架构要点

- **配置**: 单一 `hugo.yaml`，无多环境配置
- **主题**: Hextra（git 子模块 `themes/hextra/`），项目根目录 `layouts/` 为空，所有模板来自主题
- **内容组织**: 全部在 `content/` 下，主要分区：
  - `oi-blog/` — OI 博客（STL、算法笔记）
  - `books/` — 读书笔记（如《算法图解》）
  - `sundry/` — 杂项
  - `categories/OI/` — OI 分类页
- **内容类型**: 所有页面 front matter 使用 `type: docs`，对应 Hextra docs 布局
- **评论**: Giscus（基于 GitHub Discussions），页面通过 `comments: true` 启用
- **数学公式**: LaTeX 通过 Goldmark passthrough 扩展支持，使用 `$...$` / `$$...$$` 语法
- **搜索**: FlexSearch，索引全文内容
- **国际化**: 自定义中文字符串在 `i18n/zh-cn.yaml`
- **短代码**: 使用 Hextra 提供的 `tabs`、`tab`、`details`、`card` 等

## 新建内容

使用 archetype 模板：`./hugo.exe new content oi-blog/新文件.md`

生成的 front matter 包含 `type: docs`、`comments: true`、`categories`、`tags`、`description` 等字段。

## 注意事项

- `hugo.exe` 是本地 Windows 用的 Hugo 二进制文件（已在 `.gitignore` 中）
- `.cph-ng/` 目录是 VS Code Competitive Programming Helper 扩展的数据，非项目内容
- 主题最低 Hugo 版本要求：0.146.0
- CI 使用 `hugo-version: latest`（extended 版本）
