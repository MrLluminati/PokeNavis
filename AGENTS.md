# Codex / Agent Instructions — PokeNavis

These instructions apply across the repository. **Read this file first** when starting work or reviewing a task.

## Mission and current phase

PokeNavis is a 2D pixel-art, multiplayer monster-battling RPG concept. We are currently in **Phase 1 — offline vertical slice**. PN-001 bootstrap, PN-002 walkable world and PN-003 NPC dialogue are merged. PN-004 battle contract remains Backlog until owner-approved scope is prepared. There is no backend or complete RPG yet. Do not describe a feature as implemented unless files and tests establish that it is.

The long-term goal involves multiple regions, character progression, PvP and optional regional boss world records. Do not attempt those systems ahead of the approved milestone.

## Mandatory reading order

1. [README.md](README.md): orientation and links.
2. [docs/STATUS.md](docs/STATUS.md): current state, next action and blockers.
3. [docs/TASKS.md](docs/TASKS.md): accepted backlog and task acceptance criteria.
4. [docs/DECISIONS.md](docs/DECISIONS.md): **confirmed user decisions** versus proposals/open questions.
5. [docs/GDD.md](docs/GDD.md): game design and rules.
6. [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md): module boundaries.
7. [docs/ROADMAP.md](docs/ROADMAP.md): development gates.
8. [CONTRIBUTING.md](CONTRIBUTING.md): branching, testing, PR and documentation requirements.
9. [docs/REFERENCE-RESEARCH.md](docs/REFERENCE-RESEARCH.md): safe comparative study of third-party games.

## Decision authority

- **Project owner (user):** final approval of gameplay, product, budget, milestones and unapproved design tradeoffs.
- **ChatGPT:** assists with specifications, architecture, prioritization, handoffs, reviews and documentation.
- **Codex/contributors:** implement approved tasks, run relevant checks, explain results, and propose (not silently adopt) design changes.

An issue, task or agent suggestion is **not automatically product approval**. If documents conflict, prioritize explicit decisions in `docs/DECISIONS.md`, then the current approved task; point out the conflict in the PR. Do not silently overwrite confirmed rules.

## Working protocol for every task

1. Read the relevant task in `docs/TASKS.md` and check dependencies and status.
2. If the task is not marked **Ready**, restrict work to investigation/proposals unless the project owner approved implementation.
3. Inspect existing code before editing. Keep scope limited to that task.
4. If a product decision is missing, state it plainly. Do not invent a permanent rule.
5. Implement the smallest complete change in a feature branch named `codex/PN-###-short-name` or `feature/PN-###-short-name`.
6. Add or update automated tests where feasible. Run relevant build/lint/test commands if available.
7. Document exactly what ran, whether it passed and what could not be tested. **Never claim a build passed without running it.**
8. Update `docs/TASKS.md` with status/PR link when known, and `docs/STATUS.md` if the current milestone, blocker or next action changes.
9. Update `docs/DECISIONS.md` only for an explicitly approved decision; proposals go into the open-questions section.
10. Submit a PR using the template; wait for owner review before merging product-affecting changes.

If execution cannot be completed (for example Godot not installed, engine not running or assets missing), create a precise handoff with blockers, files changed, commands attempted and next steps.

## Reference-game research (mandatory)

- Study PokeMMO through normal, authorized gameplay observation, notes and permitted screenshots/recordings. Treat reference mechanics as observations, not as permissions or approved PokeNavis design decisions.
- Do not ingest, extract, decompile or reverse-engineer the PokeMMO client or ROM binaries; do not commit any third-party ROMs, copyrighted graphics, dialogue, audio, maps or derived asset dumps.
- Implement original code/assets/data and keep a record of design choices. Follow [Reference Research Protocol](docs/REFERENCE-RESEARCH.md).

## Engineering constraints

- Planned stack: Godot 4.x client; TypeScript battle engine; Node.js/TypeScript server; PostgreSQL when persistent multiplayer begins. **Exact version/language choices remain subject to approval.**
- Maintain a **deterministic and independently testable** turn-based battle simulation separate from UI, network and persistence.
- Keep all future competitive actions and economy transactions **server-authoritative**.
- Prefer modular, understandable architecture over speculative microservices.
- Use data-driven content, typed contracts, source control and small reviewable changes.
- Avoid unnecessary dependencies and unrelated refactors.
- Never commit credentials, tokens, personal data, ROMs, extracted Pokémon assets, music or other uncleared proprietary assets. Early tests use original or appropriately licensed placeholders.
- Do not use third-party source code without checking licence compatibility and attributing it where required.
- Preserve accessibility and eventual PC/mobile support where reasonably practicable, without expanding the current scope.

## Confirmed gameplay invariants: don't change without approval

- 2D, Generation-5-inspired visual direction.
- Player can choose any **released** starting region; travel to a new region requires completion of the active region's main story and League/equivalent.
- Side/secret/weekly missions are optional; regional 100% completion unlocks an **optional** ultimate daily boss.
- First daily boss defeat does not break streak. On the second and each subsequent defeat, player may choose to spend **one Streak Protection** to unlock an additional attempt; otherwise the streak breaks. No daily victory by reset breaks streak.
- Protections are **account-wide**, accumulate from one free monthly grant, and are **non-tradable at first**. Additional in-game-store purchases are envisaged.
- Exact daily reset time, ranking eligibility for bought protections, max retries and prize details are **open**, not finalized.
- The leaderboard must never accept client-declared wins.

## Handoff format (in PR or task note)

- **Task ID and objective**
- **Current status:** Not started / Ready / In progress / Blocked / In review / Done
- **What changed:** list paths and behavior
- **Tests:** command, result, environment, or 'not run' with reason
- **Risks/blockers/open decisions**
- **Next action and responsible party**
- **PR/commit links**

## Definition of done

A task is **Done** only when its acceptance criteria pass, relevant automated tests (if applicable) are run, implementation and user-facing documentation are updated, and the change is reviewed/merged. A draft PR is **In review**, not Done.
