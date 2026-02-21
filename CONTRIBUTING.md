# Contributing

Thanks for your interest in improving this skill library.

## Development setup

1. Install D2 and verify:

```sh
d2 version
```

2. Run local checks:

```sh
./scripts/selftest.sh
./scripts/sync-runtime.sh
./scripts/validate.sh
```

## Repository maintenance rule

- `skills/d2-diagram/` is the source of truth.
- `.claude/skills/d2-diagram/` is the runtime mirror.
- Always run `./scripts/sync-runtime.sh` after source edits.

## Contribution guidelines

- Keep `SKILL.md` concise; move long detail into `reference/*`.
- Every new `.d2` example must pass `d2 validate`.
- Keep examples runnable and focused.
- If changing behavior, update relevant docs.

## Pull request checklist

- [ ] `./scripts/validate.sh` passes
- [ ] docs updated for behavior changes
- [ ] docs updated (if user-visible)
