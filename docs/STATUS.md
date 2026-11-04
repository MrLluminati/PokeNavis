# PokeNavis — Project Status

**Last reviewed:** 2026-11-04  
**Phase:** 1 — Offline vertical slice (first test world merged; NPC interaction next)
**Overall state:** **PN-001 and PN-002 are Done**. [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) merged 2026-11-04. Two original test zones, movement, collision, bounded camera and transitions are now in main. **PN-003 is Ready** ([specification](PN-003-SPEC.md), [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4)); no dialogue, battles or multiplayer implemented yet.

> This page is the fastest way for any contributor, reviewer or Codex session to understand current work. Update the date and content when the overall state changes, not merely for formatting edits.

## At a glance

| Area | Status | Evidence / notes |
| --- | --- | --- |
| Name and repository | **Complete** | `MrLluminati/PokeNavis` |
| Game design foundation | **Drafted** | [GDD](GDD.md) and [decisions](DECISIONS.md); some important mechanics open |
| Architecture and phased plan | **Drafted** | [Architecture](ARCHITECTURE.md), [Roadmap](ROADMAP.md) |
| Contributor / Codex workflow | **Established** | [AGENTS.md](../AGENTS.md), [CONTRIBUTING.md](../CONTRIBUTING.md), [Task board](TASKS.md) |
| Godot client | **PN-002 merged; PN-003 Ready** | [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) merged; [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4) covers NPC dialogue |
| Turn-based battle engine | **Not started** | Only a placeholder directory exists |
| Multiplayer server | **Not started** | Only a placeholder directory exists |
| Automated build/CI | **Not started** | Manual smoke commands passed; no automated CI yet |
| First playable demo | **Not started** | Gate A pending |

## Current milestone

**Phase 1 objective:** build an original, offline 2D vertical slice beginning with a walkable test world, then NPC interaction, encounters, deterministic battles and local save.

**Immediate next action:** Codex implements [PN-003](PN-003-SPEC.md) from [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4) on new branch `feature/PN-003-npc-dialogue` from latest `main`. Open a PR with real test evidence; owner reviews before merge.

## What is currently in progress?

- No new implementation task is underway in main.
- PN-003 is Ready for Codex; its implementation has not begun.

## Blockers / open decisions

- Godot 4.7.2 stable and GDScript are pinned (D-016); no PN-002 runtime blocker was found in the verified checks.
- Minimal first battle rules/species placeholders need an approved scope.
- Paid protections and official leaderboard eligibility unresolved (not a Phase 1 blocker).
- Public release of Pokémon-specific content would require appropriate rights clearance (not needed for original placeholder prototype).

## Latest verified milestone

- PN-002 merged via [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) on 2026-11-04. Codex recorded passing headless startup/import, 32 automated checks, F5 launch and graphical captures. A separate continuous manual keyboard traversal was not documented.
- PN-001 merged via [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) on 2026-11-04.
- GitHub links and task details are in [TASKS.md](TASKS.md).

## What is next?

1. Codex reads [PN-003 spec](PN-003-SPEC.md) and [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4) and starts `feature/PN-003-npc-dialogue` from main.
2. Implement a reusable NPC, interaction prompt and dialogue panel without regressing PN-002.
3. Run existing movement tests plus new NPC tests, document results and open a PR.
4. Owner reviews and merges; PN-004 remains Backlog.

## For someone joining today

Read [README](../README.md) → [this status](STATUS.md) → [Tasks](TASKS.md) → [Decisions](DECISIONS.md). You do **not** need this project's ChatGPT conversation history.
