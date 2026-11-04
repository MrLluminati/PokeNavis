# PokeNavis — Project Status

**Last reviewed:** 2026-11-04  
**Phase:** 0 — Pre-production / repository foundation  
**Overall state:** Documentation and collaboration workflow being established; **no runnable game code yet**.

> This page is the fastest way for any contributor, reviewer or Codex session to understand current work. Update the date and content when the overall state changes, not merely for formatting edits.

## At a glance

| Area | Status | Evidence / notes |
| --- | --- | --- |
| Name and repository | **Complete** | `MrLluminati/PokeNavis` |
| Game design foundation | **Drafted** | [GDD](GDD.md) and [decisions](DECISIONS.md); some important mechanics open |
| Architecture and phased plan | **Drafted** | [Architecture](ARCHITECTURE.md), [Roadmap](ROADMAP.md) |
| Contributor / Codex workflow | **Established** | [AGENTS.md](../AGENTS.md), [CONTRIBUTING.md](../CONTRIBUTING.md), [Task board](TASKS.md) |
| Godot client | **Not started** | Only a placeholder directory exists |
| Turn-based battle engine | **Not started** | Only a placeholder directory exists |
| Multiplayer server | **Not started** | Only a placeholder directory exists |
| Automated build/CI | **Not started** | No runnable project or tests yet |
| First playable demo | **Not started** | Gate A pending |

## Current milestone

**Phase 0 exit gate:** approve first prototype scope and technology, establish a reproducible local setup, then start a small 2D vertical slice.

**Immediate next action:** project owner reviews proposed scope and chooses client scripting approach/Godot version. After approval, move **PN-001** to `Ready` and delegate implementation to Codex.

## What is currently in progress?

- Repository governance and transparent handoff documentation.
- No code implementation tasks have been started.

## Blockers / open decisions

- Godot version and GDScript vs C# not locked.
- Minimal first battle rules/species placeholders need an approved scope.
- Paid protections and official leaderboard eligibility unresolved (not a Phase 1 blocker).
- Public release of Pokémon-specific content would require appropriate rights clearance (not needed for original placeholder prototype).

## Latest verified milestone

- Initial documentation committed to `main`; collaboration documentation follows.
- GitHub links and task details are in [TASKS.md](TASKS.md).

## What is next?

1. **Approve PN-001 scope:** engine setup and runnable blank Godot project with local instructions.
2. Codex implements PN-001 on a feature branch and opens a PR documenting tests.
3. Owner reviews; merge only when acceptance criteria are met.
4. Advance to PN-002: a compact tile-based test map, movement and collision.

## For someone joining today

Read [README](../README.md) → [this status](STATUS.md) → [Tasks](TASKS.md) → [Decisions](DECISIONS.md). You do **not** need this project's ChatGPT conversation history.
