# XCHK Verification — Zendesk sidebar app

Public source for the **XCHK Verification** Zendesk Support app (ZAF v2). Agents open a live identity verification session from the ticket sidebar; results can sync back to the ticket via XCHK server-side OAuth.

| | |
|--|--|
| **Marketplace name** | XCHK Verification |
| **Version** | 1.0.12 |
| **Location** | Ticket sidebar |
| **Production host** | [in.xchk.io](https://in.xchk.io) |

## Quick start

1. Build the install package:

   ```bash
   ./scripts/package.sh
   ```

   Produces `xchk-zendesk-app.zip` at the repo root.

2. In **Zendesk Admin → Apps and integrations → Zendesk Support apps**, upload the zip (private test) or install from Marketplace when listed.

3. Configure app settings (see [docs/INSTALL.md](docs/INSTALL.md)).

4. In XCHK helpdesk → **API & Webhooks → Zendesk**, connect OAuth for PASS/FAIL ticket sync.

## App settings

| Parameter | Description |
|-----------|-------------|
| `xchk_base_url` | XCHK API host (default `https://in.xchk.io`) |
| `xchk_integrator_token` | Secure: API key from XCHK → API & Webhooks → Integrations |
| `zendesk_subdomain` | Optional override; auto-detected from the Zendesk account |

## Documentation

- [Installation](docs/INSTALL.md) — per-account setup, settings, verification
- [Architecture](docs/ARCHITECTURE.md) — data flow, security, API calls (for reviewers)
- [Marketplace submission](docs/MARKETPLACE.md) — listing notes and change history pointer
- [OAuth (server-side)](docs/OAUTH.md) — global OAuth for PASS/FAIL sync (not in this repo)

## Repository layout

```
manifest.json          App config (ZAF)
assets/iframe.html     Sidebar UI
assets/logo*.png       Marketplace / admin icons
assets/screenshot-*.png Marketplace listing (1024×768)
translations/en.json   Marketplace copy + parameter labels
scripts/package.sh     Build upload zip
docs/                  Setup and architecture
```

## Build requirements

- `zip` (macOS/Linux)
- Optional: [ZCLI](https://developer.zendesk.com/documentation/apps/app-developer-guide/zcli/) for local validation (`zcli apps:validate .`)

## Security

- No API keys or OAuth secrets in source code.
- The integrator token is a **secure** manifest parameter; Zendesk injects it only on `client.request(..., { secure: true })`.
- Outbound requests are limited to `domainWhitelist`: `in.xchk.io`, `xchk.io`.

## Related (private)

The XCHK helpdesk web app and API server are not in this repository. This repo contains **only** the Zendesk App Framework sidebar client submitted to the Marketplace.

## Support

- Email: support@xchk.io
- Product: https://in.xchk.io

## Changelog

See [CHANGELOG.md](CHANGELOG.md).
