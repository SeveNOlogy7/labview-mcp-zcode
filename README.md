# LabVIEW MCP — community ZCode marketplace (unofficial)

Installs the **official** [Zuehlke/labview-mcp](https://github.com/Zuehlke/labview-mcp) release
into ZCode.

**Why this repo exists.** ZCode cannot read the official marketplace's `archive` source type,
its archive extractor refuses any single entry above **50 MB** (the exe alone is ~85 MB — this
applies to plugin zips *and* to the zipball it uses to materialize a GitHub marketplace), and
its CLI silently no-ops remote marketplace fetches. The one channel ZCode installs reliably
from is a git-materialized marketplace with a relative (`"./"`) plugin source — so the default
branch of this repository **is** the official release tree, adapted to those limits:

- every file under the branch root comes from the official `labview-mcp.zip` release asset,
  fetched and **sha256-verified** against the release's published `labview-mcp.sha256` by the
  sync workflow;
- **one adaptation**: `bin/LabVIEWMCP.exe` (~85 MB) is shipped as two parts
  (`bin/LabVIEWMCP.exe.part00` + `.part01`, each < 50 MB) plus `bin/launch.cmd`, which
  reassembles the exe on first run (`copy /b` — byte-identical, verified in CI by size and
  locally by `cmp` against the official binary);
- added by this repo: `marketplace.json`, `.claude-plugin/marketplace.json` (the listing),
  `.zcode-plugin/plugin.json` (ZCode manifest), `bin/launch.cmd`, an empty `.gitignore`;
- the branch is **generated** — one commit per upstream release; history is force-replaced on
  each sync and is not meaningful.

> **Unofficial.** Not affiliated with or endorsed by Zühlke Engineering AG. labview-mcp is
> © Zühlke Engineering AG, MIT licensed. Upstream ships for Claude Code; this listing exists
> because of the ZCode limitations above (see
> [the upstream discussion](https://github.com/Zuehlke/labview-mcp/issues/156)).
> Claude users should install from the official marketplace instead.

## Install (ZCode desktop app)

1. Open **Plugin Marketplace → Add → Add Plugin Marketplace**.
2. Enter `SeveNOlogy7/labview-mcp-zcode` as the marketplace source.
3. Install **labview-mcp** from the **zuehlke-labview-zcode** marketplace.

Requirements: Windows x64 and LabVIEW 2026 (same as upstream). The first MCP launch takes a
moment longer: `bin/launch.cmd` assembles `LabVIEWMCP.exe` from its parts once.

## Verify what you got

- The installed plugin carries `VERSION.txt` from the official release — check the `tag:` line.
- The reassembled exe is byte-identical to the official binary; you can `cmp` it against the
  extraction of the official `labview-mcp.zip` for the same tag.

## Updates

`.github/workflows/sync-release.yml` runs daily: fetch the latest upstream release, verify its
checksum, rebuild the branch when the release changed. To pick an update up in ZCode: update
the marketplace, then update the plugin. Force a sync now: **Actions → sync-release → Run
workflow**.

## Limits inherited from ZCode (not this repo)

- The desktop app is the working route for add/install/update; the CLI (0.18.0) silently
  no-ops remote marketplace operations.
- A marketplace materialization fetch is the size of the release (~65 MB compressed).
