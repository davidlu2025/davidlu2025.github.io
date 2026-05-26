# David Lu's Blog

> 个人技术博客 + 项目展示网站  
> **线上地址**: https://davidlu2025.github.io

基于 [Hugo](https://gohugo.io/) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod) 主题构建，部署在 GitHub Pages，通过 GitHub Actions 自动发布。

---

## 🚀 本地运行

### 1. 安装 Hugo Extended

```powershell
# Windows (推荐 winget)
winget install Hugo.Hugo.Extended

# 或者用 Scoop
scoop install hugo-extended

# 验证
hugo version
```

### 2. 克隆仓库并初始化主题

```bash
git clone https://github.com/davidlu2025/davidlu2025.github.io
cd davidlu2025.github.io

# 拉取主题子模块
git submodule update --init --recursive
```

### 3. 本地预览

```bash
hugo server -D
# 访问 http://localhost:1313
```

---

## ✍️ 写新文章

```bash
# 新建博客文章
hugo new posts/my-new-post.md

# 新建项目介绍
hugo new projects/my-project.md
```

写完后把 `draft: true` 改为 `draft: false`，推送到 GitHub 即可自动发布。

---

## 📁 目录结构

```
├── .github/workflows/deploy.yml  # 自动部署
├── assets/css/extended/          # 自定义样式
├── content/
│   ├── about.md                  # 关于我
│   ├── search.md                 # 搜索页
│   ├── posts/                    # 博客文章
│   └── projects/                 # 项目展示
├── static/                       # 静态资源（图片、favicon等）
├── themes/PaperMod/              # 主题（submodule）
└── hugo.toml                     # 站点配置
```

---

## 🌐 部署到 GitHub Pages

### 首次设置（只需一次）

1. 在 GitHub 创建仓库 `davidlu2025.github.io`
2. 进入仓库 **Settings → Pages** → Source 选 **GitHub Actions**
3. 推送代码，Actions 会自动构建并发布

```bash
git init
git remote add origin https://github.com/davidlu2025/davidlu2025.github.io.git
git add .
git commit -m "🚀 初始化博客"
git push -u origin main
```

---

## 📝 Frontmatter 说明

### 博客文章

```yaml
---
title: "文章标题"
date: 2026-05-25
draft: false          # true=草稿不发布，false=正式发布
tags: ["Go", "教程"]
categories: ["技术"]
description: "文章摘要，显示在列表页"
showToc: true         # 是否显示目录
cover:
  image: "/images/cover.jpg"   # 封面图（可选）
---
```

### 项目介绍

```yaml
---
title: "项目名称"
date: 2026-05-25
draft: false
tags: ["Python", "开源"]
description: "一句话描述"
weight: 1             # 数字越小越靠前
---
```

---

## 📄 License

MIT
