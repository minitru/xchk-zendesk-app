# OAuth (server-side)

PASS/FAIL ticket updates use the **XCHK API server**, not this sidebar app. Agents configure OAuth once per Zendesk subdomain in XCHK helpdesk.

## Why OAuth is separate from the ZAF app

- The sidebar only needs an **integrator API key** to mint signed helpdesk launch URLs.
- Writing ticket comments requires Zendesk API access with refresh tokens — stored and refreshed on the XCHK server per subdomain.
- Marketplace public apps must use **global OAuth** (`zdg-…` client id) for multi-customer deployments.

## Operator setup (summary)

1. XCHK server env (hosted at in.xchk.io):

   ```bash
   ZENDESK_OAUTH_CLIENT_ID=zdg-xchk-live
   ZENDESK_OAUTH_CLIENT_SECRET=<from Zendesk global OAuth client>
   ZENDESK_OAUTH_REDIRECT_URI=https://in.xchk.io/auth/zendesk/callback
   ```

2. In XCHK helpdesk → **API & Webhooks → Zendesk** → enter subdomain → **Connect with Zendesk**.

3. Agents install this sidebar app and set **XCHK integrator token** (API key from Integrations tab).

## Global OAuth client

Create a local OAuth client on a sponsored `d3v-…` Zendesk account with identifier **`zdg-xchk-live`**, then request global conversion via the [Marketplace portal](https://apps.zendesk.com) → **Global OAuth**.

Official guide: [Set up a global OAuth client](https://developer.zendesk.com/documentation/marketplace/building-a-marketplace-app/set-up-a-global-oauth-client/)

## Authorization flow (per customer subdomain)

Same as standard Zendesk OAuth authorization code flow:

- Authorize: `https://{subdomain}.zendesk.com/oauth/authorizations/new`
- Token: `https://{subdomain}.zendesk.com/oauth/tokens`
- Client id: global `zdg-xchk-live` (shared across customers)

Tokens are stored in XCHK under the operator’s account, keyed by subdomain.

## This repository

OAuth implementation is **not** in this repo. This document is for integrators and Marketplace reviewers understanding the full product architecture.
