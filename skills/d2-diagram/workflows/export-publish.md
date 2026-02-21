# Workflow: Export and Publish

## Input

- source `.d2`
- destination medium (web, docs, slides, terminal)

## Actions

1. Select format per destination:
   - docs/web: SVG
   - slides: PPTX/GIF
   - static docs: PNG/PDF
   - terminal docs: ASCII
2. Run validate/fmt before export.
3. Render requested outputs.
4. Confirm artifact paths and file existence.
5. Note interactivity caveats for embedding.

## Validation

- all requested formats are produced
- no unsupported-format claim without fallback suggestion

## Output

- follow `output-contract.md`
