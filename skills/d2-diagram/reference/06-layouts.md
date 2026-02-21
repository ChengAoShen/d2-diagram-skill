# Layouts

## Engines

- `dagre` (default): fast, layered, good default.
- `elk`: strong for dense graphs.
- `tala`: D2-specific engine.

## Choosing a Layout

- Start with `dagre`.
- Move to `elk` if edge routing gets messy.
- Use `tala` when you need TALA-specific behavior.

## Commands

```sh
d2 layout
d2 layout dagre
d2 --layout elk in.d2 out.svg
```
