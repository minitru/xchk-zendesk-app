# XCHK Zendesk sidebar app

Source for this app is published at **[github.com/minitru/xchk-zendesk-app](https://github.com/minitru/xchk-zendesk-app)** (public).

## Build zip for upload

```bash
cd zendesk-app   # in xchk-app monorepo — or clone xchk-zendesk-app repo
zip -r ../zendesk-xchk-app.zip manifest.json assets translations
```

Or from the public repo: `./scripts/package.sh`

Upload **`zendesk-xchk-app.zip`** in Zendesk Admin → Apps or submit via [Marketplace portal](https://apps.zendesk.com).

Secure setting **`xchk_integrator_token`**: API key from XCHK → API & Webhooks → Integrations.

See the public repo for full install, architecture, and Marketplace docs.
