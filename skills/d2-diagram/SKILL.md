---
name: d2-diagram
description: Generate, validate, format, and render D2 diagrams from requirements, including themes, styles, classes, composition, imports, icons, and exports.
license: MIT
argument-hint: [requirement text, file path, or refactor goal]
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(d2 *), Bash(ls *), Bash(pwd *)
---

# D2 Diagram Skill

Use this skill whenever the user asks to create, edit, review, or export D2 diagrams.

You are not just explaining D2. You are teaching-by-doing: produce runnable `.d2`, execute the correct CLI flow, and return reproducible outputs.

## Inputs

- Natural-language diagram requirements.
- Existing `.d2` file path.
- Export targets: `svg`, `png`, `pdf`, `pptx`, `gif`, `txt`.
- Optional constraints: layout engine, theme IDs, dark theme, style rules.

## Mandatory Execution Flow

1. Clarify intent from `$ARGUMENTS` and identify output targets.
2. Choose workflow:
   - new diagram -> `workflows/from-requirements.md`
   - edit existing -> `workflows/edit-existing.md`
   - refactor large -> `workflows/refactor-large.md`
   - export/publish -> `workflows/export-publish.md`
   - live iteration -> `workflows/watch-mode-loop.md`
   - repeated errors -> `workflows/diagnose-and-recover.md`
3. Generate a minimal valid `.d2` first, then enrich incrementally.
4. Validate:
   - `d2 validate <input.d2>`
5. Format:
   - `d2 fmt <input.d2>`
6. Render using requested format(s):
   - `d2 <input.d2> <output.svg>`
   - `d2 <input.d2> <output.png>`
   - `d2 <input.d2> <output.pdf>`
   - `d2 <input.d2> <output.pptx>`
   - `d2 <input.d2> <output.gif>`
   - `d2 --ascii-mode standard <input.d2> <output.txt>`
7. If watch mode is requested:
   - `d2 -w <input.d2> <output.svg>`
8. Return results using `output-contract.md`.

## Decision Rules

- Layout:
  - start with `dagre`
  - switch to `elk` for dense graphs or crossing-heavy edges
  - use `tala` only when TALA-specific behavior is required
- Composition:
  - use `layers` for isolated alternatives
  - use `scenarios` for variants from common base
  - use `steps` for progressive narratives/animations
- Export:
  - docs/web -> SVG
  - slides -> PPTX or GIF
  - static docs -> PNG/PDF
  - terminal-first -> ASCII

## Hard Rules

- Prefer correctness over visual complexity on first pass.
- Keep syntax characters ASCII (`:`, `;`, `.`, `{`, `}`) to avoid Unicode lookalikes.
- Quote labels/keys if reserved symbols conflict with parser.
- Use keys for references, not labels.
- For imports, prefer `@file` style without `.d2` suffix.
- Use `d2 validate` and `d2 fmt` before final render.
- Never claim render success without command confirmation.
- Do not skip failure recovery; use `workflows/diagnose-and-recover.md` when commands fail.
- Do not output only theory when the request is execution-oriented.

## Failure Recovery Protocol

1. `d2 validate` failed:
   - quote suspicious labels/keys
   - replace Unicode lookalike punctuation with ASCII
   - isolate to minimal failing block and re-run validate
2. `d2 fmt` failed:
   - fix structural syntax first (maps, blocks, strings)
   - re-run validate then fmt
3. render failed:
   - confirm input exists and validate passes
   - retry with svg first, then target format
   - for png/pdf issues, check browser/runtime dependency assumptions

## Deliverables

- Generated/updated `.d2` file path.
- Executed commands.
- Output artifact paths.
- Validation/formatting status.
- If failed: root cause + next fix steps.
