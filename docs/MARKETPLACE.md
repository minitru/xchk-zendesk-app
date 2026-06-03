# Marketplace submission notes

Use this repo as the **public source link** when submitting **XCHK Verification** to the Zendesk Marketplace.

## Source link for reviewers

```
https://github.com/minitru/xchk-zendesk-app
```

Version in submission should match `manifest.json` → `version` (currently **1.0.12**).

## Package to upload

Build locally:

```bash
./scripts/package.sh
```

Upload the generated zip in the Marketplace portal or for private testing in Zendesk Admin.

## What reviewers should know

1. **Public app** — `private: false` in manifest.
2. **Secure parameter only** — `xchk_integrator_token` (no hardcoded credentials).
3. **Screenshots** — three PNGs in `assets/` at 1024×768.
4. **Translations** — `translations/en.json` includes `app.parameters` for all manifest parameters.
5. **Server integration** — OAuth and ticket sync run on XCHK servers; not included in this repo by design.

## Change history

See [CHANGELOG.md](../CHANGELOG.md).

## Support contact

- support@xchk.io
- https://in.xchk.io

## Validation

If using ZCLI:

```bash
zcli apps:validate .
zcli apps:package .
```

Expected: no errors; no false-positive secret warnings after `xchk_integrator_token` rename.
