# PokeNavis — Project Status

**Last reviewed:** 2026-11-04  
**Phase:** 1 — Offline vertical slice (NPC dialogue merged; battle contract next)
**Overall state:** **PN-001, PN-002 and PN-003 are Done.** [PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) merged 2026-11-04 after Codex's 33 NPC dialogue and 32 movement regression checks and owner-reported manual acceptance. **PN-004 battle schema is Backlog** until scope is approved. No battle or multiplayer engine exists yet.

> This page is the fastest way for any contributor, reviewer or Codex session to understand current work. Update the date and content when the overall state changes, not merely for formatting edits.

## At a glance

| Area | Status | Evidence / notes |
| --- | --- | --- |
| Name and repository | **Complete** | `MrLluminati/PokeNavis` |
| Game design foundation | **Drafted** | [GDD](GDD.md) and [decisions](DECISIONS.md); some important mechanics open |
| Architecture and phased plan | **Drafted** | [Architecture](ARCHITECTURE.md), [Roadmap](ROADMAP.md) |
| Contributor / Codex workflow | **Established** | [AGENTS.md](../AGENTS.md), [CONTRIBUTING.md](../CONTRIBUTING.md), [Task board](TASKS.md) |
| Godot client | **PN-003 merged** | [PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) merged; original placeholder NPC dialogue is available alongside movement and map transitions |
| Turn-based battle engine | **Not started** | Only a placeholder directory exists |
| Multiplayer server | **Not started** | Only a placeholder directory exists |
| Automated build/CI | **Not started** | Manual smoke commands passed; no automated CI yet |
| First playable demo | **Not started** | Gate A pending |

## Current milestone

**Phase 1 objective:** build an original, offline 2D vertical slice beginning with a walkable test world, then NPC interaction, encounters, deterministic battles and local save.

**Immediate next action:** Review [PN-004 proposed battle contract](PN-004-SPEC-DRAFT.md) and [design Issue #8](https://github.com/MrLluminati/PokeNavis/issues/8). Approve a minimal action/state/event scope before moving PN-004 from Backlog to Ready. The [REF-001 report](research/pokemmo-feature-analysis.md) is merged research context, not firsthand gameplay verification.

## Parallel reference research

- [REF-001: PokeMMO feature-analysis research](https://github.com/MrLluminati/PokeNavis/issues/6) is **Done**. [PR #7](https://github.com/MrLluminati/PokeNavis/pull/7) merged on 2026-11-04; the [report](research/pokemmo-feature-analysis.md) separates local metadata and published support evidence from engineering proposals.
- No direct manual PokeMMO gameplay was analyzed. Follow the [Reference Research Protocol](REFERENCE-RESEARCH.md) for any later observations. The research does not authorize PN-004 implementation.

## What is currently in progress?

- No coding task is presently In progress.
- PN-004's [draft contract](PN-004-SPEC-DRAFT.md) and [design review Issue #8](https://github.com/MrLluminati/PokeNavis/issues/8) are available for approval. Implementation is not yet authorized.

## Blockers / open decisions

- Godot 4.7.2 stable and GDScript are pinned (D-016); no PN-003 runtime blocker was found in the verified checks.
- Minimal first battle rules/species placeholders need an approved scope.
- Paid protections and official leaderboard eligibility unresolved (not a Phase 1 blocker).
- Public release of Pokémon-specific content would require appropriate rights clearance (not needed for original placeholder prototype).

## Latest verified milestone

- PN-003 branch passed headless import/startup, 33 NPC dialogue checks, all 32 PN-002 regression checks, editor F5 launch and inspected prompt/dialogue frames on Windows with Godot 4.7.2 stable. A separate continuous keyboard conversation was not recorded by Codex; the project owner subsequently reported the manual NPC interaction test **passed** on 2026-11-04. [PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) has since merged.
- PN-002 merged via [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) on 2026-11-04. Codex recorded passing headless startup/import, 32 automated checks, F5 launch and graphical captures. A separate continuous manual keyboard traversal was not documented.
- PN-001 merged via [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) on 2026-11-04.
- GitHub links and task details are in [TASKS.md](TASKS.md).

## What is next?

1. Review [PN-004 draft](PN-004-SPEC-DRAFT.md) and [Issue #8](https://github.com/MrLluminati/PokeNavis/issues/8) for a minimal battle state/action/event contract.
2. Decide only the battle-mode/action-set/schema questions needed for PN-004; defer detailed formulas and other mechanics to later work.
3. Record owner-approved decisions before Codex implements PN-004. PN-005 and later remain Backlog.

## For someone joining today

Read [README](../README.md) → [this status](STATUS.md) → [Tasks](TASKS.md) → [Decisions](DECISIONS.md). You do **not** need this project's ChatGPT conversation history.
