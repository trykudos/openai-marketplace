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
.agents/plugins/marketplace.json   marketplace "kudos" -> ./plugins/kudos
plugins/kudos/plugin.json          plugin manifest
plugins/kudos/mcp.json             MCP server URL (the only file that differs between branches)
```

Change the plugin on `dev`, then merge `dev` into `main` keeping main's `mcp.json` URL
(and marketplace display name).
