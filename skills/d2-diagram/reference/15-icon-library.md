# Icon Library and Images

Primary icon catalog:

- `https://icons.terrastruct.com`

## Usage

```d2
aws: {
  icon: https://icons.terrastruct.com/aws%2Fcompute%2Fec2
}

logo: {
  shape: image
  icon: ./assets/logo.png
}
```

## Rules and Tips

- Any URL can be used as `icon`.
- Local files are supported with CLI renders.
- Container icons are usually top-left; regular nodes often center.
- Use `shape: image` for standalone image nodes.
