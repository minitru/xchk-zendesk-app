# Installation

Install **XCHK Verification** on each Zendesk Support account that will use live verify.

## 1. Get an XCHK integrator token

1. Log in to [XCHK helpdesk](https://in.xchk.io/helpdesk.html).
2. Open **API & Webhooks → Integrations**.
3. Click **Generate key** and copy the API key once.

This key is stored in Zendesk as the secure **XCHK integrator token** — it is not embedded in the app source.

## 2. Install the app

### Marketplace (when listed)

Install from the Zendesk Marketplace listing for **XCHK Verification**.

### Private upload (testing)

```bash
git clone https://github.com/minitru/xchk-zendesk-app.git
cd xchk-zendesk-app
./scripts/package.sh
```

Upload `xchk-zendesk-app.zip` in **Zendesk Admin → Apps and integrations → Zendesk Support apps → Upload private app**.

## 3. Configure app settings

| Setting | Value |
|---------|--------|
| **XCHK base URL** | `https://in.xchk.io` (or your XCHK host) |
| **XCHK integrator token** | API key from step 1 (secure field) |
| **Zendesk subdomain override** | Leave blank — auto-detected. Set only if detection fails. |

Pin the app to the **ticket sidebar**.

## 4. Connect OAuth for PASS/FAIL sync (XCHK side)

Ticket comments and tags after PASS/FAIL are written by the **XCHK server** using OAuth, not by this sidebar app.

1. In XCHK helpdesk → **API & Webhooks → Zendesk**.
2. Enter this account’s subdomain (e.g. `acme` for `acme.zendesk.com`).
3. Click **Connect with Zendesk** and approve.

Repeat for each Zendesk subdomain. See [OAUTH.md](OAUTH.md).

## 5. Use the sidebar

1. Open a ticket with a requester email on the customer profile.
2. In the sidebar, click **Open Verification Session**.
3. Complete verification in the XCHK helpdesk window (mobile check-in, live session).
4. Click **PASS** or **FAIL** in XCHK; a private comment and tags are added to the Zendesk ticket when OAuth is connected.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Popout blocked | Allow popups for `*.zendesk.com` |
| Integrator token / 401 | Regenerate API key in XCHK; update secure setting in Zendesk app config |
| No requester email | Add email to the Zendesk user profile |
| PASS/FAIL but no ticket update | Connect OAuth for this subdomain in XCHK → API & Webhooks → Zendesk |
| Wrong subdomain | Set **Zendesk subdomain override** or reinstall on the correct account |

## Multi-account deployments

| Step | Per Zendesk account? |
|------|----------------------|
| Install app | Yes |
| Set integrator token | Yes (can use same XCHK API key) |
| XCHK OAuth connect | Yes (one row per subdomain) |
| XCHK operator login | No (one team, many Zendesk connections) |
