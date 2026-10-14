# Kudos plugin marketplace for ChatGPT / Codex

One plugin, `kudos`: the Kudos MCP server (wallet, card recommendations, transactions, benefits,
card-linked offers, bill negotiation), served by the api repo's `mcp-connector` (the one Kudos MCP server for external agents; Meta Muse uses
the same URL).

| Branch | Environment | MCP server |
|---|---|---|
| `main` | prod | `https://mcp.prod.joinkudos.com/mcp` |
| `dev` | dev | `https://mcp.dev.joinkudos.com/mcp` |

This branch: **prod** (`https://mcp.prod.joinkudos.com/mcp`).

## Install

In the ChatGPT desktop app: Settings → Plugins → Add → Add plugin marketplace.

- Source: `trykudos/openai-marketplace`
- Git ref: `main` (prod) or `dev`
- Sparse paths: leave empty

Then install **kudos** from the marketplace and ask a Kudos question; the first call opens the Kudos
sign-in (OAuth with dynamic client registration against `oauth.{env}.joinkudos.com`).

## Layout

```
.agents/plugins/marketplace.json   marketplace "kudos" -> ./plugins/kudos (desktop-app installs only; not uploaded)
plugins/kudos/plugin.json          plugin manifest + OpenAI listing, review and publication fields
plugins/kudos/mcp.json             MCP server URL + OAuth (dynamic client registration)
plugins/kudos/skills/kudos/        skill telling ChatGPT when and how to use the Kudos tools
plugins/kudos/assets/logo.png      logo and composer icon (square, 149x149)
package.sh                         builds dist/kudos-plugin-<version>.zip for the OpenAI submission
```

`main` and `dev` are maintained separately (never merged): make a change on each branch that needs it.

## Submit to the OpenAI plugin directory (prod, this branch)

1. Fill in the `TODO` values in `plugins/kudos/plugin.json` and bump `version` for every new upload.
2. `./package.sh` (refuses while a TODO is left) -> `dist/kudos-plugin-<version>.zip`, with the
   plugin files at the ZIP root.
3. platform.openai.com -> Plugins -> Create -> **With MCP** (org owner, or a member with Apps
   Management Write; the org needs business verification to publish as Kudos). Upload the ZIP.
4. MCPs -> Connect: check the URL `https://mcp.prod.joinkudos.com/mcp` and OAuth (DCR; discovery at
   `oauth.prod.joinkudos.com` advertises `registration_endpoint`).
5. Domain verification: serve the token the portal gives as plain text at
   `https://mcp.prod.joinkudos.com/.well-known/openai-apps-challenge` (or on a parent domain
   origin). The api repo's mcp-connector serves it from env `OPENAI_APPS_CHALLENGE_TOKEN`
   (`deployment/api-apps/values-prod.yaml`, mcp-connector app): set it to the token, deploy prod,
   check with `curl`, then verify in the portal. Leave it set afterwards.
6. Wait for the tool scan. Tool annotations (`readOnlyHint`, `destructiveHint`, `openWorldHint`)
   come from the server (`lambdas/utils/agents/mcp/kudos/tools/specs.ts` in the api repo); add the
   justifications in the portal.
7. Review details (in the portal, never in the ZIP): TODO a prod demo account with sample cards,
   transactions, benefits and offers that signs in without MFA, email/SMS codes or magic links.
   Run the 5 positive test cases in `plugin.json` with it before submitting.
8. Submit for review and accept the policy attestations.

Docs: [package](https://developers.openai.com/plugins/build/plugins),
[submit](https://developers.openai.com/plugins/deploy/submission),
[errors](https://developers.openai.com/plugins/deploy/submission-errors),
[MCP review](https://developers.openai.com/plugins/deploy/app-review).
