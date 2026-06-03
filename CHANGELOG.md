# Changelog

## 1.0.12

- Fix parameter translations: nest `parameters` under `app` in `translations/en.json` (ZAT requirement).
- Public Marketplace listing: `private: false`.

## 1.0.11

- Add Marketplace screenshots (`assets/screenshot-0.png` … `screenshot-2.png`, 1024×768).
- Rename secure setting `xchk_api_key` → `xchk_integrator_token` (avoids false secret detection in ZAT).
- Complete parameter labels and help text in `en.json`.
- Update installation instructions for public app install.

## 1.0.10

- Mint launch: sidebar calls `POST /api/integrator/zendesk/mint-launch` with secure integrator token.
- Signed helpdesk URL (`?launch=…`) with 15-minute TTL; email/mobile prefilled from ticket context.
- Fix secure header injection: `{{setting.xchk_integrator_token}}` in `client.request` (secure settings not readable from JS).

## 1.0.8 and earlier

- Initial private sidebar: open helpdesk with ticket requester email.
- Domain whitelist for XCHK API host.
