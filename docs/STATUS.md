# PokeNavis — Project Status

**Last reviewed:** 2026-11-04  
**Phase:** 1 — Offline vertical slice (NPC interaction in review)
**Overall state:** **PN-001 and PN-002 are Done**. [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) merged 2026-11-04. **PN-003 is In review** on `feature/PN-003-npc-dialogue`: a reusable Village NPC, interaction prompt and three-line dialogue are implemented and tested with Godot 4.7.2. No battles or multiplayer are implemented.

> This page is the fastest way for any contributor, reviewer or Codex session to understand current work. Update the date and content when the overall state changes, not merely for formatting edits.

## At a glance

| Area | Status | Evidence / notes |
| --- | --- | --- |
| Name and repository | **Complete** | `MrLluminati/PokeNavis` |
| Game design foundation | **Drafted** | [GDD](GDD.md) and [decisions](DECISIONS.md); some important mechanics open |
| Architecture and phased plan | **Drafted** | [Architecture](ARCHITECTURE.md), [Roadmap](ROADMAP.md) |
| Contributor / Codex workflow | **Established** | [AGENTS.md](../AGENTS.md), [CONTRIBUTING.md](../CONTRIBUTING.md), [Task board](TASKS.md) |
| Godot client | **PN-003 in review** | [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4); NPC dialogue and PN-002 regression suites pass on Godot 4.7.2 |
| Turn-based battle engine | **Not started** | Only a placeholder directory exists |
| Multiplayer server | **Not started** | Only a placeholder directory exists |
| Automated build/CI | **Not started** | Manual smoke commands passed; no automated CI yet |
| First playable demo | **Not started** | Gate A pending |

## Current milestone

**Phase 1 objective:** build an original, offline 2D vertical slice beginning with a walkable test world, then NPC interaction, encounters, deterministic battles and local save.

**Immediate next action:** Project owner reviews [PN-003 PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) and [verification evidence](../client/README.md), then merges if accepted. PN-004 remains Backlog.

## What is currently in progress?

- PN-003 is implemented on `feature/PN-003-npc-dialogue` and awaiting owner review. It is not merged into `main`.

## Blockers / open decisions

- Godot 4.7.2 stable and GDScript are pinned (D-016); no PN-003 runtime blocker was found in the verified checks.
- Minimal first battle rules/species placeholders need an approved scope.
- Paid protections and official leaderboard eligibility unresolved (not a Phase 1 blocker).
- Public release of Pokémon-specific content would require appropriate rights clearance (not needed for original placeholder prototype).

## Latest verified milestone

- PN-003 branch passed headless import/startup, 33 NPC dialogue checks, all 32 PN-002 regression checks, editor F5 launch and inspected prompt/dialogue frames on Windows with Godot 4.7.2 stable. A separate continuous keyboard conversation was not recorded by Codex; the project owner subsequently reported the manual NPC interaction test **passed** on 2026-11-04. PR #5 remains unmerged pending owner merge.
- PN-002 merged via [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) on 2026-11-04. Codex recorded passing headless startup/import, 32 automated checks, F5 launch and graphical captures. A separate continuous manual keyboard traversal was not documented.
- PN-001 merged via [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) on 2026-11-04.
- GitHub links and task details are in [TASKS.md](TASKS.md).

## What is next?

1. Project owner reviews the PN-003 pull request and recorded Godot 4.7.2 results.
2. Merge only after approval; leave PN-003 In review until then.
3. PN-004 remains Backlog and starts only under a separate task.

## For someone joining today

Read [README](../README.md) → [this status](STATUS.md) → [Tasks](TASKS.md) → [Decisions](DECISIONS.md). You do **not** need this project's ChatGPT conversation history.
