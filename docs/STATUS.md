# PokeNavis — Project Status

**Last reviewed:** 2026-11-04  
**Phase:** 1 — Offline vertical slice (first test world in review)
**Overall state:** **PN-001 is Done**. **PN-002 is In review**: two original walkable test zones, movement, collisions, camera and safe transitions are implemented on `feature/PN-002-world-movement`, with Godot 4.7.2 verification recorded in [client README](../client/README.md). No battle, NPC or multiplayer mechanics exist yet.

> This page is the fastest way for any contributor, reviewer or Codex session to understand current work. Update the date and content when the overall state changes, not merely for formatting edits.

## At a glance

| Area | Status | Evidence / notes |
| --- | --- | --- |
| Name and repository | **Complete** | `MrLluminati/PokeNavis` |
| Game design foundation | **Drafted** | [GDD](GDD.md) and [decisions](DECISIONS.md); some important mechanics open |
| Architecture and phased plan | **Drafted** | [Architecture](ARCHITECTURE.md), [Roadmap](ROADMAP.md) |
| Contributor / Codex workflow | **Established** | [AGENTS.md](../AGENTS.md), [CONTRIBUTING.md](../CONTRIBUTING.md), [Task board](TASKS.md) |
| Godot client | **PN-002 in review** | [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2); two walkable zones pass Godot 4.7.2 import, focused movement/transition checks and graphical launch |
| Turn-based battle engine | **Not started** | Only a placeholder directory exists |
| Multiplayer server | **Not started** | Only a placeholder directory exists |
| Automated build/CI | **Not started** | Manual smoke commands passed; no automated CI yet |
| First playable demo | **Not started** | Gate A pending |

## Current milestone

**Phase 1 objective:** build an original, offline 2D vertical slice beginning with a walkable test world, then NPC interaction, encounters, deterministic battles and local save.

**Immediate next action:** Project owner reviews the PN-002 pull request and [verification evidence](../client/README.md). Merge after approval. PN-003 remains Backlog.

## What is currently in progress?

- PN-002 is implemented on `feature/PN-002-world-movement` and awaiting owner review. It is not merged into `main`.

## Blockers / open decisions

- Godot 4.7.2 stable and GDScript are pinned (D-016); no PN-002 runtime blocker was found in the verified checks.
- Minimal first battle rules/species placeholders need an approved scope.
- Paid protections and official leaderboard eligibility unresolved (not a Phase 1 blocker).
- Public release of Pokémon-specific content would require appropriate rights clearance (not needed for original placeholder prototype).

## Latest verified milestone

- PN-002 branch passed headless import/startup, 32 focused physics/input/transition checks, editor F5 launch and inspected graphical frames of both maps on Windows with Godot 4.7.2 stable.
- PN-001 merged via [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) on 2026-11-04.
- GitHub links and task details are in [TASKS.md](TASKS.md).

## What is next?

1. **Owner reviews PN-002** and the recorded Godot 4.7.2 test results.
2. Merge only after approval; leave PN-002 In review until then.
3. PN-003 (NPC interaction) remains Backlog and starts only under a separate task.

## For someone joining today

Read [README](../README.md) → [this status](STATUS.md) → [Tasks](TASKS.md) → [Decisions](DECISIONS.md). You do **not** need this project's ChatGPT conversation history.
