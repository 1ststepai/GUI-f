# LeanCTX Wiring

This repo is wired for LeanCTX-aware coding sessions.

When LeanCTX tools are available, agents should use:

- `ctx_search` for discovery
- `ctx_tree` for repository maps
- `ctx_read` before full file reads
- `ctx_shell` for verbose command output

Use normal edit/write tools for actual file changes.

Before non-trivial work, read:

- `CLAUDE.md`
- `docs/AI_MEMORY.md`
- `docs/LEAN_CTX.md`

Do not scan the whole repo. Find the smallest relevant files first.

LeanCTX must also be installed and configured on the local machine or VPS where the coding agent runs.
