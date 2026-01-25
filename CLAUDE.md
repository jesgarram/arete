# Arete Plugin Development Guide

## Release Process

Releases are automated via GitHub Actions. When you merge to `main` with a new version, a release is created automatically.

### To create a new release:

1. **Update version numbers** in your PR (both files must match):
   - `.claude-plugin/plugin.json` - update `"version"` field
   - `.claude-plugin/marketplace.json` - update `"version"` field

2. **Merge your PR to main**

3. **Done!** The GitHub Action will automatically:
   - Detect the version change
   - Create a git tag (`vX.Y.Z`)
   - Create a GitHub Release with auto-generated release notes

### Version Files

The version must be kept in sync across:
- `.claude-plugin/plugin.json` - main plugin metadata
- `.claude-plugin/marketplace.json` - marketplace registration

### Manual Release (if needed)

If automation fails, you can manually create a release:
```bash
git tag -a vX.Y.Z -m "Release vX.Y.Z"
git push origin vX.Y.Z
```
Then create the release at https://github.com/jesgarram/arete/releases/new
