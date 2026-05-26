---
title: "用 GitHub Actions 自动部署 Hugo 博客到 GitHub Pages"
date: 2026-05-25
draft: false
tags: ["Hugo", "GitHub Actions", "CI/CD", "GitHub Pages"]
categories: ["教程"]
description: "零成本把 Hugo 博客部署到 GitHub Pages，提交代码自动触发构建和发布。"
cover:
  image: ""
  alt: "GitHub Actions + Hugo"
showToc: true
---

## 前言

Hugo 是目前最快的静态网站生成器之一，配合 GitHub Pages 可以实现完全免费的博客托管。  
本文介绍如何配置 GitHub Actions，实现「推送代码 → 自动构建 → 自动发布」的全自动流程。

---

## 准备工作

1. 一个 GitHub 账号
2. 仓库名设为 `<你的用户名>.github.io`（例如 `davidlu2025.github.io`）
3. 本地安装 Hugo Extended 版本

验证安装：

```bash
hugo version
# hugo v0.147.0+extended ...
```

---

## 仓库结构

```
your-blog/
├── .github/
│   └── workflows/
│       └── deploy.yml   ← 自动部署工作流
├── content/
│   └── posts/
├── themes/
│   └── PaperMod/        ← 主题（git submodule）
└── hugo.toml
```

---

## GitHub Actions 配置

在 `.github/workflows/deploy.yml` 中写入：

```yaml
name: Deploy Hugo Site

on:
  push:
    branches: ["main"]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.147.0
    steps:
      - name: Install Hugo
        run: |
          wget -O ${{ runner.temp }}/hugo.deb \
            https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb
          sudo dpkg -i ${{ runner.temp }}/hugo.deb

      - uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Build
        run: hugo --gc --minify

      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/deploy-pages@v4
        id: deployment
```

---

## 关键步骤

### 1. 启用 GitHub Pages

进入仓库 **Settings → Pages**，将 Source 设置为 **GitHub Actions**。

### 2. 添加主题子模块

```bash
git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod
```

### 3. 推送代码

```bash
git add .
git commit -m "初始化博客"
git push origin main
```

推送后，GitHub Actions 会自动运行，约 1-2 分钟后网站就上线了。  
访问 `https://<你的用户名>.github.io` 即可看到效果。

---

## 本地预览

```bash
hugo server -D
# 浏览器访问 http://localhost:1313
```

---

## 小结

整个流程的核心是：
- **Hugo** 负责把 Markdown 内容转换为静态 HTML
- **GitHub Actions** 负责在每次 push 时自动执行构建
- **GitHub Pages** 负责托管生成的静态文件

一次配置，终身受益。祝博客越写越好 ✍️
