# LabVIEW MCP — community ZCode marketplace (unofficial)

Installs the **official** [Zuehlke/labview-mcp](https://github.com/Zuehlke/labview-mcp) release
into ZCode.

**Why this repo exists.** ZCode cannot read the official marketplace's `archive` source type,
its zip installer refuses any single entry above **50 MB** (the exe alone is ~85 MB), and its
CLI silently no-ops remote marketplace fetches. The one channel ZCode instals reliably from
is a git-materialized marketplace with a relative (`"./"`) plugin source — so the default
branch of this repository **is** the official release tree:

- every file under the branch root (except the handful listed below) is **byte-identical to
  the official `labview-mcp.zip` release asset**, fetched and **sha256-verified** against the
  release's published `labview-mcp.sha256` by the sync workflow;
- added by this repo: `marketplace.json`, `.claude-plugin/marketplace.json` (the listing),
  `.zcode-plugin/plugin.json` (the ZCode manifest, `mcpServers` inlined from the release's
  own `.mcp.json`), an empty `.gitignore`, and `built-dist` provenance in the commit message;
- the branch is **generated** — one commit per upstream release; its history is not
  meaningful and history is force-replaced on each sync.

> **Unofficial.** Not affiliated with or endorsed by Zühlke Engineering AG. labview-mcp is
> © Zühlke Engineering AG, MIT licensed. Upstream ships for Claude Code; this listing exists
> because of the ZCode limitations above (see
> [the upstream discussion](https://github.com/Zuehlke/labview-mcp/issues/156)).
> Claude users should install from the official marketplace instead.

## Install (ZCode desktop app)

1. Open **Plugin Marketplace → Add → Add Plugin Marketplace**.
2. Enter `SeveNOlogy7/labview-mcp-zcode` as the marketplace source.
3. Install **labview-mcp** from the **zuehlke-labview-zcode** marketplace.

Requirements: Windows x64 and LabVIEW 2026 (same as upstream).

## Updates

`.github/workflows/sync-release.yml` runs daily: it fetches the latest upstream release,
verifies its checksum, and rebuilds the branch when the release changed. To pick an update
up in ZCode: update the marketplace, then update the plugin. To force a sync now: **Actions →
sync-release → Run workflow**.

## Verify what you got

The installed plugin carries `VERSION.txt` from the official release — check the `tag:` line.
The sync commit message records the upstream tag it was built from.

## Limits inherited from ZCode (not this repo)

- The desktop app is the working route for add/install/update; the CLI (0.18.0) silently
  no-ops remote marketplace operations.
- A git-materialized marketplace fetch is the size of the release (~65 MB compressed).
