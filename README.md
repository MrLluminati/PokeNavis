# PokeNavis

**One World. Every Region. Endless Adventures.**

PokeNavis is an early-stage, 2D, pixel-art, multiplayer monster-battling RPG project. Its design target is a classic Pokémon-region adventure adapted to a persistent MMO: choose a starting region, complete its story, unlock travel to another region, and pursue competitive PvP and optional PvE world-record challenges.

> **Status:** Pre-production / design and prototype planning. No playable release yet.
>
> **IP note:** The planned Pokémon-specific content is a design reference and is **not licensed or cleared for distribution**. The first prototype uses original or placeholder art, names, maps, audio and data. This repository does not contain Pokémon ROMs, proprietary game assets, or third-party game code.

## Vision

- A cohesive Generation 5-inspired **2D/2.5D pixel-art** experience.
- Nine-region **design target** (Kanto through Paldea), developed incrementally.
- Players may **start in any available region** and unlock travel to another new region only after finishing the current region's main progression and its League or equivalent.
- Traditional regional storylines plus optional side quests, hidden quests, weekly quests and postgame activities.
- Broad move availability for PvE, with **separate rulesets for ranked PvP**.
- Optional **Regional Legends Challenge** bosses unlocked by defined 100% regional completion.
- Persistent daily boss win streaks, seasonal rankings and historic verified world records.
- Account-wide **Streak Protection**, with monthly grants, accumulation and optional in-game purchases; non-tradable initially.

## First playable milestone

A small original placeholder zone containing:
1. 2D character movement, map collisions and transitions.
2. NPC interaction and a short quest.
3. Wild encounters and a deterministic turn-based battle loop.
4. Capture, party management and save/load.
5. Automated tests for battle outcomes and saved progression.

**We are not attempting nine regions, a live MMO, or the entire creature catalog in the first milestone.**

## Planned architecture

| Area | Starting choice |
| --- | --- |
| Client | Godot 4.x, 2D |
| Backend | Node.js + TypeScript modular server |
| Battle engine | TypeScript; study compatible open-source engines before adopting |
| Primary database | PostgreSQL |
| Cache / queues | Redis only when needed |
| Platform sequence | Windows prototype first; Android later |
| Code hosting | GitHub |

All competitive progression, trades, inventory consumption, rewards and records will ultimately be validated server-side.

## Repository structure

```text
client/                Godot client (future)
server/                Multiplayer and persistent gameplay services (future)
battle-engine/         Turn-based rules and simulation (future)
database/              Migrations and schemas (future)
assets/                Original placeholder art, music and UI assets (future)
docs/
  GDD.md               Master game design specification
  ARCHITECTURE.md      Technical architecture and data boundaries
  ROADMAP.md           Milestones and acceptance criteria
  DECISIONS.md         Confirmed decisions and issues still open
README.md
.gitignore
```

## Project status and collaboration

**Current state:** Godot 4.7.2 bootstrap ([PR #1](https://github.com/MrLluminati/PokeNavis/pull/1)) and walkable Test Village/Test Route ([PR #3](https://github.com/MrLluminati/PokeNavis/pull/3)) are merged. [PN-003 PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) adds NPC interaction and dialogue and awaits review. This remains an offline prototype, not a finished RPG.

**Start here if you're new:** [Current Status](docs/STATUS.md) · [Task Queue](docs/TASKS.md) · [Design Decisions](docs/DECISIONS.md) · [Contributing Guide](CONTRIBUTING.md) · [Codex Instructions](AGENTS.md) · [Changelog](CHANGELOG.md).

**How we work:** The project owner approves decisions; ChatGPT helps prepare specifications and handoffs; Codex and contributors implement reviewed tasks. Every implementation task needs an ID, scope, owner, acceptance criteria, test evidence, current status and PR link. Keep repo documents current so a new collaborator does **not** need to read any chat history.

The current engineering task is **PN-003: owner review of NPC interaction and dialogue**. See [Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4), [implementation specification](docs/PN-003-SPEC.md), [Task Queue](docs/TASKS.md) and [Client instructions](client/README.md).

## How to begin

1. Read [Game Design Document](docs/GDD.md).
2. Review [Decisions and open questions](docs/DECISIONS.md).
3. Follow [Roadmap](docs/ROADMAP.md) and [Architecture](docs/ARCHITECTURE.md).
4. Open the initialized Godot 4.7.2 project at `client/project.godot`; follow [client setup](client/README.md).

## Development principles

- Build one vertical slice, prove it works, then expand.
- Keep story state per player; keep world presence shared.
- Keep Pokémon collection account-wide but enforce separate regional story-team rules.
- Keep battle logic deterministic, testable and independent of rendering.
- Treat any real-world prizes and purchasable protections as subjects for later economic, fairness and legal review.
- Never place secrets, copyrighted ROMs or unlicensed assets in the repository.

## Current status

- [x] Project name and GitHub repository established
- [x] Foundational design documentation
- [x] PN-001 Godot client bootstrap merged and verified
- [x] PN-002 first walkable test world merged
- [ ] 2D offline vertical slice
- [ ] Multiplayer test
- [ ] Regional content and progression
- [ ] PvP and Regional Legends Challenge

**Project:** PokeNavis  
**Repository:** https://github.com/MrLluminati/PokeNavis
