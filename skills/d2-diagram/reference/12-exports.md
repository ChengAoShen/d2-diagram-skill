# Exports

Supported formats:

- SVG
- PNG
- PDF
- PPTX
- GIF
- ASCII (`.txt`)

## Commands

```sh
d2 in.d2 out.svg
d2 in.d2 out.png
d2 in.d2 out.pdf
d2 in.d2 out.pptx
d2 in.d2 out.gif
d2 --ascii-mode standard in.d2 out.txt
```

## Notes

- PNG/PDF may rely on Playwright/Chromium availability.
- SVG interactivity depends on embedding method.
- ASCII is best for simple box/arrow diagrams.
