# Changelog

This is a readable record of meaningful changes to PokeNavis. Dates use UTC and entries should link to merged PRs or commits when available. This is **not** a substitute for the current-state page at [docs/STATUS.md](docs/STATUS.md).

## Unreleased

### PN-003 — Ready for development (not implemented)
- [Specification](docs/PN-003-SPEC.md) and [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4) prepared for NPC interaction and dialogue; no NPC gameplay code has been committed.


### PN-002 — Merged 2026-11-04 ([PR #3](https://github.com/MrLluminati/PokeNavis/pull/3))
- Added two original connected test maps, a reusable player scene, cardinal WASD/arrow movement, solid blockers, bounded camera and safe two-way exits under [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2).
- Codex documented passing Godot 4.7.2 import/startup, 32 automated checks, editor F5 and graphical captures; see [client verification](client/README.md). Merged into main. A separate continuous keyboard traversal was not recorded.


### PN-001 — Godot client bootstrap ([PR #1](https://github.com/MrLluminati/PokeNavis/pull/1), merged 2026-11-04)
- Added a minimal Godot 4.7.2/GDScript 2D startup scene and documented client setup.
- Codex verified successful import, headless startup, graphical rendering at 960×540 and editor F5 launch on Windows; results recorded in `client/README.md`.
- Godot bootstrap approved and merged; no gameplay features are implemented.


### Project foundation — 2026-11-04
- Created the PokeNavis repository and foundational README.
- Added draft game design, architecture, roadmap and confirmed/open decisions.
- Added a contributor/Codex workflow, project status dashboard and task queue.
- Prepared initial offline prototype task backlog.

**Current release status:** A walkable offline test world is merged; no complete playable RPG or public release exists yet.
