# PokeNavis — Project Status

**Last reviewed:** 2026-11-04  
**Phase:** 1 — Offline vertical slice (first test world next)  
**Overall state:** **PN-001 is Done**: [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) merged on 2026-11-04 after headless, graphical and editor F5 verification. **PN-002 is Ready**, with [implementation specification](PN-002-SPEC.md) and [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2). No playable RPG mechanics exist yet.

> This page is the fastest way for any contributor, reviewer or Codex session to understand current work. Update the date and content when the overall state changes, not merely for formatting edits.

## At a glance

| Area | Status | Evidence / notes |
| --- | --- | --- |
| Name and repository | **Complete** | `MrLluminati/PokeNavis` |
| Game design foundation | **Drafted** | [GDD](GDD.md) and [decisions](DECISIONS.md); some important mechanics open |
| Architecture and phased plan | **Drafted** | [Architecture](ARCHITECTURE.md), [Roadmap](ROADMAP.md) |
| Contributor / Codex workflow | **Established** | [AGENTS.md](../AGENTS.md), [CONTRIBUTING.md](../CONTRIBUTING.md), [Task board](TASKS.md) |
| Godot client | **Bootstrap merged; PN-002 Ready** | [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) merged; [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2) prepares first controllable map |
| Turn-based battle engine | **Not started** | Only a placeholder directory exists |
| Multiplayer server | **Not started** | Only a placeholder directory exists |
| Automated build/CI | **Not started** | Manual smoke commands passed; no automated CI yet |
| First playable demo | **Not started** | Gate A pending |

## Current milestone

**Phase 1 objective:** build an original, offline 2D vertical slice beginning with a walkable test world, then NPC interaction, encounters, deterministic battles and local save.

**Immediate next action:** Codex implements [PN-002](PN-002-SPEC.md) from [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2), on a new `feature/PN-002-world-movement` branch created from the current `main`. Code remains subject to smoke testing, PR review and owner merge.

## What is currently in progress?

- No implementation task is currently in progress on `main`.
- PN-002 has complete acceptance criteria and is **Ready** for Codex; the first movement/map implementation has not been started.

## Blockers / open decisions

- Godot 4.7.2 stable and GDScript are pinned (D-016); no environment blocker is currently known for PN-002.
- Minimal first battle rules/species placeholders need an approved scope.
- Paid protections and official leaderboard eligibility unresolved (not a Phase 1 blocker).
- Public release of Pokémon-specific content would require appropriate rights clearance (not needed for original placeholder prototype).

## Latest verified milestone

- PN-001 merged via [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) on 2026-11-04; import, startup, graphical rendering and editor F5 passed on Windows with Godot 4.7.2 stable.
- GitHub links and task details are in [TASKS.md](TASKS.md).

## What is next?

1. **Codex starts PN-002** from [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2) and [specification](PN-002-SPEC.md), creating `feature/PN-002-world-movement` from `main`.
2. Implement and test two original 2D zones, four-direction movement, collisions, camera follow and safe map transitions.
3. Codex pushes a PR with actual command-line and editor test evidence; owner reviews and merges.
4. PN-003 (NPC interaction) follows only after PN-002 is accepted.

## For someone joining today

Read [README](../README.md) → [this status](STATUS.md) → [Tasks](TASKS.md) → [Decisions](DECISIONS.md). You do **not** need this project's ChatGPT conversation history.
