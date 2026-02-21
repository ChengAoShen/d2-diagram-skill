# D2 Diagram Skill Library

[![CI](https://img.shields.io/badge/CI-validate-green)](#maintainers)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[中文文档](README.zh-CN.md)

Production-ready `d2-diagram` skill for Claude-style agents.

## What is D2?

D2 is a declarative diagram scripting language that turns text into diagrams.

- Built in Go, fast for CLI and watch-mode iteration.
- Official compiler/CLI improves rendering consistency across environments.
- Native support for multilingual text, code blocks, LaTeX, Markdown, SQL/class-like objects, icons/images, themes, and sketch mode.
- Exports to SVG/PNG/PDF/PPTX/GIF/ASCII (including PPTX for downstream polishing).
- Text-first syntax is LLM-friendly and works well with skill-guided generation.

References: https://d2lang.com, https://github.com/terrastruct/d2

## Quick Start

Install (no clone required):

- macOS/Linux, project scope

```sh
curl -fsSL https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.sh | bash -s -- --scope project --source remote --repo ChengAoShen/d2-diagram-skill --ref main
```

- Windows PowerShell, project scope

```powershell
iwr https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.ps1 -UseBasicParsing | iex
Install-D2Skill -Scope Project -Source Remote -Repo ChengAoShen/d2-diagram-skill -Ref main
```

Use it:

```text
/d2-diagram Design a service architecture with API gateway, auth service, billing, and Postgres. Export svg and png.
```

Need global install, uninstall, or full matrix? See `docs/install.md`.

## Skill Summary

`d2-diagram` runs a strict loop:

1. Parse requirements
2. Generate minimal valid `.d2`
3. Run `d2 validate`
4. Run `d2 fmt`
5. Render requested formats
6. Return artifact paths and diagnostics

Coverage includes common architecture flows, sequence diagrams, SQL ERD, and core export paths.

## Repository Layout

```text
.
├─ skills/d2-diagram/             # source of truth
├─ scripts/                       # install/uninstall/validate helpers
├─ docs/                          # install docs
└─ .github/workflows/ci.yml
```

Runtime install target is generated at `.claude/skills/d2-diagram`.

## Maintainers

- Edit `skills/d2-diagram/` first.
- Sync runtime mirror: `./scripts/sync-runtime.sh`
- Run checks:

```sh
./scripts/selftest.sh
./scripts/validate.sh
```

See also: `CONTRIBUTING.md`.

## Disclaimer

This repository is for practical reuse and demonstration. Behavior can vary by Claude runtime/tool availability. Validate in your own environment before critical use.

## License

MIT, see `LICENSE`.
