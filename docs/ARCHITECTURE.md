# Architecture

Overview for Marketplace reviewers and integrators. This document describes the **Zendesk sidebar app only** and its relationship to the XCHK API.

## Components

```
┌─────────────────────┐     secure client.request      ┌──────────────────────┐
│  Zendesk ticket     │  POST /api/integrator/zendesk/ │  XCHK API            │
│  sidebar (ZAF)      │ ──────────────────────────────►│  (in.xchk.io)        │
│  assets/iframe.html │  X-API-Key: integrator token   │                      │
└─────────────────────┘                                └──────────┬───────────┘
         │                                                        │
         │ window.open(launchUrl)                                 │ OAuth Bearer
         ▼                                                        ▼
┌─────────────────────┐                                ┌──────────────────────┐
│  XCHK helpdesk      │  PASS/FAIL                     │  Zendesk REST API    │
│  helpdesk.html      │ ──────────────────────────────►│  (ticket comments)   │
└─────────────────────┘  (server-side, not ZAF)       └──────────────────────┘
```

## Sidebar app responsibilities

1. Read ticket id and requester email/phone via **ZAF SDK** (`client.get`).
2. Detect Zendesk subdomain from app context (or `zendesk_subdomain` setting).
3. Call XCHK **mint-launch** with the secure integrator token.
4. Open the returned signed URL in a new browser window.

The sidebar does **not**:

- Store or read the integrator token in JavaScript (secure setting).
- Call the Zendesk REST API directly for PASS/FAIL.
- Hold OAuth refresh tokens (those live on the XCHK server per connected subdomain).

## API: mint launch

**Request** (from sidebar via ZAF proxy):

```
POST https://in.xchk.io/api/integrator/zendesk/mint-launch
X-API-Key: <integrator token from secure setting>
Content-Type: application/json

{
  "email": "requester@example.com",
  "mobile": "+15551234567",
  "ticketId": "12345",
  "subdomain": "acme"
}
```

**Response:**

```json
{
  "launchUrl": "https://in.xchk.io/helpdesk.html?launch=<signed-jwt>",
  "expiresIn": 900
}
```

The launch token is verified server-side before helpdesk loads ticket context. Query parameters alone are not trusted for email or ticket id.

## PASS/FAIL → Zendesk ticket

When an agent completes verification in XCHK helpdesk, the **XCHK server** updates the ticket using **global OAuth** (`zdg-xchk-live`) or legacy API token credentials stored in the XCHK operator’s integrator settings — configured in XCHK UI, not in this ZAF app.

## Security model

| Asset | Where stored |
|-------|----------------|
| Integrator API key | Zendesk secure app parameter `xchk_integrator_token` |
| OAuth refresh tokens | XCHK server database (per subdomain) |
| Launch JWT signing | XCHK server (`ZENDESK_LAUNCH_SECRET` / session secret) |

**domainWhitelist** in `manifest.json`: `in.xchk.io`, `xchk.io`.

**No secrets in git:** this repository contains placeholders only (`{{setting.xchk_integrator_token}}`).

## Files

| File | Role |
|------|------|
| `manifest.json` | App metadata, parameters, whitelist |
| `assets/iframe.html` | Sidebar UI and ZAF logic |
| `translations/en.json` | Marketplace listing copy and parameter labels |
| `assets/screenshot-*.png` | Marketplace listing images (1024×768) |

## Framework

- Zendesk Apps Framework **2.0**
- ZAF SDK 2.0 (CDN)
- Location: `support.ticket_sidebar`
