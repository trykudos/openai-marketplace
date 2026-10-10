# Kudos plugin marketplace for ChatGPT / Codex

One plugin, `kudos`: the Kudos MCP server (wallet, card recommendations, transactions, benefits,
card-linked offers, bill negotiation), served by the api repo's `mcp-gpt-connector`.

| Branch | Environment | MCP server |
|---|---|---|
| `main` | dev | `https://mcp-gpt.dev.joinkudos.com/mcp` |
| `prod` | prod | `https://mcp-gpt.prod.joinkudos.com/mcp` |

This branch: **dev** (`https://mcp-gpt.dev.joinkudos.com/mcp`).

## Install

In the ChatGPT desktop app: Settings → Plugins → Add → Add plugin marketplace.

- Source: `trykudos/openai-marketplace`
- Git ref: `main` (dev) or `prod`
- Sparse paths: leave empty

Then install **kudos** from the marketplace and ask a Kudos question; the first call opens the Kudos
sign-in (OAuth with dynamic client registration against `oauth.{env}.joinkudos.com`).

## Layout

```
.agents/plugins/marketplace.json   marketplace "kudos" -> ./plugins/kudos
plugins/kudos/plugin.json          plugin manifest
plugins/kudos/mcp.json             MCP server URL (the only file that differs between branches)
```

Change the plugin on `main`, then merge `main` into `prod` keeping prod's `mcp.json` URL
(and marketplace display name).
