# Release Process

1. Update `VERSION`.
   - During active development, use `-dev` suffix (example: `0.1.0-dev`).
   - Before release, switch to stable version (example: `0.1.0`).
2. Add a new section to `CHANGELOG.md`.
3. Run local checks:

```sh
./scripts/selftest.sh
./scripts/validate.sh
```

4. Ensure `README.md` reflects behavior changes.
5. Create tag `vX.Y.Z`.
