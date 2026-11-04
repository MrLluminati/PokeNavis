# PokeNavis — Work Queue

**Last updated:** 2026-11-04  
**Owner-approved roadmap:** [ROADMAP.md](ROADMAP.md)  
**Implementation rules:** [AGENTS.md](../AGENTS.md) and [CONTRIBUTING.md](../CONTRIBUTING.md)

This file is the human-readable task queue until an equivalent GitHub Issues/Projects workflow is adopted. It must always show **what's next, who's responsible, what blocks it and what counts as done**.

**Statuses:** `Backlog` · `Ready` · `In progress` · `Blocked` · `In review` · `Done`.

A proposed task is not authorization to implement undefined product decisions. Codex may investigate or propose solutions but must seek a recorded approval to make a gameplay rule permanent.

## Current task board

| ID | Task | Priority | Status | Owner / next actor | Dependencies |
| --- | --- | --- | --- | --- | --- |
| PN-001 | Bootstrap runnable Godot client project | P0 | **Done** | Merged [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) on 2026-11-04 | None |
| PN-002 | [First 2D test world, movement and collision](PN-002-SPEC.md) | P0 | **Done** | [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) merged 2026-11-04 | None |
| PN-003 | [NPC interaction and dialogue](PN-003-SPEC.md) | P0 | **Done** | [PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) merged 2026-11-04 | None |
| PN-004 | Pure battle state/action/event schema | P0 | Backlog | ChatGPT specification + owner approval; Codex implementation | Battle rule scope |
| PN-005 | Deterministic battle core with tests | P0 | Backlog | Codex | PN-004 |
| PN-006 | Battle scene and engine adapter | P1 | Backlog | Codex | PN-001, PN-005 |
| PN-007 | Data-driven wild encounter trigger | P1 | Backlog | Codex | PN-002, PN-005 |
| PN-008 | Capture, party and storage (local) | P1 | Backlog | Codex | PN-005, PN-006 |
| PN-009 | Local versioned save/load | P1 | Backlog | Codex | PN-008 |
| PN-010 | Automated checks/CI for runnable components | P1 | Backlog | Codex | PN-001 and/or PN-005 |

The sequence above is the approved **Phase 1 offline vertical slice** backlog. PN-001, PN-002 and PN-003 are Done on main. PN-004 remains Backlog pending a minimal battle-rules scope and owner approval; subsequent tasks are not started.

## Parallel research — REF-001

**Status:** In review in [PR #7](https://github.com/MrLluminati/PokeNavis/pull/7) on `research/REF-001-pokemmo-feature-analysis`; [Issue #6](https://github.com/MrLluminati/PokeNavis/issues/6). The [research report](research/pokemmo-feature-analysis.md) records a read-only installation metadata survey, public support-documentation evidence, independent architecture proposals, test ideas and gaps. No owner gameplay recordings or observations were available. Project owner reviews the report; PN-004 remains Backlog pending its own approved specification.

## Current next action — PN-004 design, not implementation

Define a minimal deterministic battle state/action/event schema and original placeholder combat rules, get owner approval, then create a scoped Codex task. Comparative research may use **observed gameplay**, authorized screenshots and notes, not PokeMMO client or ROM reverse engineering. See [Reference Research Protocol](REFERENCE-RESEARCH.md). PN-004 stays Backlog until specification and required rules are approved.

## Completed handoff: PN-003 — merged PR #5

**Specification:** [PN-003-SPEC.md](PN-003-SPEC.md) · **Issue:** [#4](https://github.com/MrLluminati/PokeNavis/issues/4) · **PR:** [#5](https://github.com/MrLluminati/PokeNavis/pull/5) · **Branch:** `feature/PN-003-npc-dialogue`, created from latest `main`.

**Objective:** Introduce one reusable original placeholder NPC in Test Village, a proximity-based E/Enter interaction prompt, three-line data-driven dialogue, and a reusable dialogue panel. Lock player movement while talking, support early cancellation, prevent one press from skipping multiple lines, and preserve Village↔Route movement and transitions.

**Verification (2026-11-04):** Official Godot 4.7.2 stable standard on Windows x86_64. Headless import and 30-frame startup exited 0. The existing PN-002 suite passed all 32 checks, and the new NPC dialogue suite passed 33 checks: range/line of sight, three lines, key debounce, movement lock, cancel after moving out of range, collision, round-trip transitions and scene cleanup. Editor F5 showed Village and the NPC with zero errors/warnings. The graphical capture command exited 0 and produced inspected [prompt](screenshots/pn-003-approach-prompt.png) and [dialogue](screenshots/pn-003-dialogue-panel.png) frames. At the time of Codex testing, a continuous keyboard conversation was not separately recorded; test input was driven by Godot events. **Owner follow-up (2026-11-04): manual NPC interaction test passed, as reported by the project owner.** See [client README](../client/README.md) for original commands and the follow-up verification distinction.

**Completion:** [PR #5](https://github.com/MrLluminati/PokeNavis/pull/5) merged into main 2026-11-04 after owner-reported manual NPC interaction passed. PN-004 remains Backlog until the owner approves its battle-schema scope.

## Completed handoff: PN-002 — merged PR #3

**Objective:** Two original placeholder zones, four-direction player movement, collision, camera bounds and safe two-way exits. **Branch:** `feature/PN-002-world-movement`. **Issue:** [#2](https://github.com/MrLluminati/PokeNavis/issues/2). **PR:** [#3](https://github.com/MrLluminati/PokeNavis/pull/3). **Status:** Done — merged into main on 2026-11-04.

**Observed on 2026-11-04:** Windows x86_64, official Godot 4.7.2 standard (`4.7.2.stable.official.ed1daf0bf`). Headless import and 30-frame startup exited 0 with no script/resource errors. The development test `godot --headless --path client --script res://tests/world_smoke.gd` exited 0 with 32 passing checks: physical D/Up-arrow mapping, cardinal movement, stop on release, camera follow/limits, village and route blockers/edges, both transitions, safe arrival and relaunch. Editor F5 displayed Village at 960×540; Output showed zero errors and warnings. Command-line graphical captures of both zones exited 0 and are in [screenshots](screenshots/). See [client README](../client/README.md) for commands and limits of graphical input verification.

**Completion:** [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) merged into main 2026-11-04 after review. Codex's 32 automated checks and F5 launch are documented. A separate continuous manual keyboard traversal was not recorded; do not claim it passed. PN-003 is next.

## Completed handoff: PN-001 (merged PR #1)

**Objective:** Create the smallest reproducible, runnable Godot 4.x 2D project in `client/` with a minimal test scene. Do not implement player movement, battles, networking, Pokémon content or an asset pipeline yet.

**Confirmed decision:** Godot 4.7.2 stable (standard) and GDScript, see D-016. **PR:** https://github.com/MrLluminati/PokeNavis/pull/1 . Headless, graphical launch and editor F5 verification passed on Windows x86_64.

**Verification (2026-11-04):** Official standard build `4.7.2.stable.official.ed1daf0bf`. `--headless --path client --import` exited 0 without errors. `--headless --path client --quit-after 5` exited 0 and printed `PokeNavis PN-001: startup scene ready`. A graphical `--path client --write-movie <temporary-output>.png --quit-after 5` run exited 0; an inspected 960×540 frame showed the expected title, subtitle and status. In the Godot editor, F5 launched the scene; the Output panel showed the startup message and zero errors. See [client README](../client/README.md) for the commands. Godot generated `.godot/` is ignored; generated `main.gd.uid` is tracked as source metadata. No runtime fix was needed.

**Branch:** `feature/PN-001-godot-bootstrap`. **Allowed changes:** `client/` source scenes/config, `client/README.md`, and targeted docs or verification tests only.

**Acceptance criteria**
- `client/` contains a valid Godot project that opens in the chosen supported version.
- A placeholder scene loads and runs without missing dependencies.
- README explains precise engine version, how to launch and what the demo contains.
- Any autogenerated engine files are gitignored appropriately; only necessary source files committed.
- A real smoke test is performed and reported; if Godot execution is unavailable, the PR plainly says **not tested**, with reproduction steps.
- No unlicensed Pokémon assets, ROM content, secrets or unrelated game features are added.
- `docs/TASKS.md` and `docs/STATUS.md` reflect actual progress and contain PR/commit links.

**Completion evidence:** [PR #1](https://github.com/MrLluminati/PokeNavis/pull/1) merged 2026-11-04 after owner F5 verification, and [client verification record](../client/README.md) documents passing Godot import, headless start and graphical rendering. Do not reopen this task without a regression.

## Follow-up tasks (outline)

**PN-002 — First test world (Done)**
- [Full specification and acceptance tests](PN-002-SPEC.md) · [GitHub Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2).
- Two original placeholder zones, WASD/arrow movement, collisions, Camera2D, and safe two-way map transitions.
- **Result:** [PR #3 merged](https://github.com/MrLluminati/PokeNavis/pull/3); first walkable prototype is in main.

**PN-003 — NPC interaction (Done)**
- [Full specification](PN-003-SPEC.md) and [GitHub Issue #4](https://github.com/MrLluminati/PokeNavis/issues/4).
- Reusable NPC and data-driven dialogue, proximity prompt, movement lock and input handling.
- **Result:** [PR #5 merged](https://github.com/MrLluminati/PokeNavis/pull/5); NPC interaction and dialogue are in main.

**PN-004 — Battle contract**
- Typed combatant/move/action/state/event definitions; turn-resolution ordering documented.
- Acceptance: clear versioned schema and unit tests for invalid inputs.

**PN-005 — Deterministic simulation**
- Basic move selection, speed/order, accuracy, damage and win/lose state.
- Acceptance: identical inputs/seed produce identical results; tests cover failure cases.

## Maintenance protocol

When Codex or a contributor starts a task:
1. Change `Status` to `In progress` and associate the branch/PR (when available).
2. Do not call it Done while tests or review are pending.
3. Update evidence and blockers in PR and/or task notes.
4. Change to `In review` when PR is ready.
5. Change to `Done` only after acceptance criteria, tests and merge are verified.
6. Add the next task and update [STATUS.md](STATUS.md) if the overall next action changes.

For work that cannot be completed automatically, write a concrete handoff: manual steps, environment/tool requirements, any files produced, decision needed and who must act.
