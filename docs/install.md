# Installation Guide

## Default Recommendation

- Use **remote install**.
- Use **project scope** unless you explicitly want global reuse.
- No local clone is required for users.

## Install Commands

### macOS / Linux

- Project scope

```sh
curl -fsSL https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.sh | bash -s -- --scope project --source remote --repo ChengAoShen/d2-diagram-skill --ref main
```

- Global scope

```sh
curl -fsSL https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.sh | bash -s -- --scope global --source remote --repo ChengAoShen/d2-diagram-skill --ref main
```

### Windows (PowerShell)

- Project scope

```powershell
iwr https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.ps1 -UseBasicParsing | iex
Install-D2Skill -Scope Project -Source Remote -Repo ChengAoShen/d2-diagram-skill -Ref main
```

- Global scope

```powershell
iwr https://raw.githubusercontent.com/ChengAoShen/d2-diagram-skill/main/scripts/install.ps1 -UseBasicParsing | iex
Install-D2Skill -Scope Global -Source Remote -Repo ChengAoShen/d2-diagram-skill -Ref main
```

## Uninstall

### macOS / Linux

If you installed via remote command and do not have this repository locally, remove the installed folder directly:

- Project scope: remove `./.claude/skills/d2-diagram`
- Global scope: remove `~/.claude/skills/d2-diagram`

If you have this repository locally, you can also run:

```sh
./scripts/uninstall.sh --scope project
./scripts/uninstall.sh --scope global
```

### Windows (PowerShell)

If you installed via remote command and do not have this repository locally, remove the installed folder directly:

- Project scope: remove `.\.claude\skills\d2-diagram`
- Global scope: remove `$HOME\.claude\skills\d2-diagram`

If you have this repository locally, you can also run:

```powershell
. .\scripts\uninstall.ps1
Uninstall-D2Skill -Scope Project
Uninstall-D2Skill -Scope Global
```

## Scope Paths

- Project: `./.claude/skills/d2-diagram`
- Global: `~/.claude/skills/d2-diagram`

## Maintainers

- Source of truth: `skills/d2-diagram`
- Runtime mirror (generated): `.claude/skills/d2-diagram`
- Sync command: `./scripts/sync-runtime.sh`
