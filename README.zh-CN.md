# D2 Diagram Skill 开源库 ✨

[English README](README.md)

这是一个面向 Claude/Agent 工作流的 `d2-diagram` 技能库。

⚡ CLI 迭代快 · 🧠 对大模型友好 · 🖼️ 多格式导出

## 🎯 D2 是什么？

D2 是一种 declarative 图脚本语言，可以把文本直接转成图（Text -> Diagram）。

- Go 实现，CLI/watch 迭代快。
- 官方编译器/CLI，跨环境渲染更一致。
- 原生支持多语言文本、代码块、LaTeX、Markdown、SQL/Class 类对象、Icon/Image、主题与手绘风格。
- 支持导出 SVG/PNG/PDF/PPTX/GIF/ASCII，PPTX 便于后续精调。
- 文本优先语法对大模型友好，适合 skill 驱动生成。

参考：https://d2lang.com, https://github.com/terrastruct/d2

## 🚀 快速开始

安装（无需先 clone）：

- macOS/Linux（项目级）

```sh
curl -fsSL https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.sh | bash -s -- --scope project --source remote --repo ChengAoShen/d2-diagram-skill --ref main
```

- Windows PowerShell（项目级）

```powershell
iwr https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.ps1 -UseBasicParsing | iex
Install-D2Skill -Scope Project -Source Remote -Repo ChengAoShen/d2-diagram-skill -Ref main
```

💡 在 Claude 中使用：

```text
/d2-diagram Design a service architecture with API gateway, auth service, billing, and Postgres. Export svg and png.
```

全局安装、卸载、完整命令矩阵见 `docs/install.md`。

## 🔁 Skill 执行摘要

`d2-diagram` 固定执行链路：

1. 解析需求
2. 生成最小可运行 `.d2`
3. `d2 validate`
4. `d2 fmt`
5. 按需渲染
6. 返回产物路径与诊断信息

覆盖常见架构图、时序图、SQL ERD 以及核心导出流程。

## 📦 仓库结构

```text
.
├─ skills/d2-diagram/             # 唯一真源
├─ scripts/                       # 安装/卸载/校验脚本
├─ docs/                          # 安装说明
└─ .github/workflows/ci.yml
```

运行时安装目录为 `.claude/skills/d2-diagram`（安装后生成）。

## 🧰 维护者说明

- 先改 `skills/d2-diagram/`
- 同步 runtime：`./scripts/sync-runtime.sh`
- 本地检查：

```sh
./scripts/selftest.sh
./scripts/validate.sh
```

更多见：`CONTRIBUTING.md`。

## ⚠️ 免责声明

本仓库用于工程复用与示例。实际行为会受 Claude 运行环境与工具可用性影响，关键场景请先在你的环境验证。

## 📄 License

MIT（见 `LICENSE`）。
