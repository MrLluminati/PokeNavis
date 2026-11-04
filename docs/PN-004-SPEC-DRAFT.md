# PN-004 — Battle State, Action and Event Contract (DRAFT)

**Status:** **Draft for project-owner review — not approved and not Ready for implementation**  
**Priority:** P0 · **Dependency:** PN-003 merged ([PR #5](https://github.com/MrLluminati/PokeNavis/pull/5))  
**Research reference:** [REF-001 report](research/pokemmo-feature-analysis.md) ([PR #7](https://github.com/MrLluminati/PokeNavis/pull/7))  
**Architecture reference:** [ARCHITECTURE.md](ARCHITECTURE.md) and [DECISIONS.md](DECISIONS.md)

## 1. Purpose and boundaries

Define a **pure, testable, versioned battle protocol** that will eventually support both an offline Godot prototype and a server-authoritative multiplayer game. PN-004 is for **types, validation, documentation, serialization and contract tests**. The damage algorithm, turn-order resolution, move effects, AI, UI and actual gameplay are **future tasks**, chiefly PN-005 and PN-006.

This document is a **proposal** and must not be treated as permission to implement unconfirmed product rules. No part of PokeMMO's ROM, client or data is a source of implementation code. The REF-001 study was based on public support documents and installation metadata, not direct gameplay observation.

## 2. Proposed minimum domain model (not final)

- **`BattleDefinition`** — battle ID; schema/ruleset/content version identifiers; battle mode; participant IDs; original placeholder roster references; optional recorded RNG seed configuration.
- **`BattleState`** — battle ID, revision, turn index, current phase, participants/sides, active-slot references, party creature instances, HP/resources and a terminal outcome; no Godot nodes or mutable UI objects.
- **`CombatantState`** — stable instance ID, side ID, active/bench position, current and maximum HP, battle-relevant numeric stats, move-slot references and a versioned extensible field for temporary effects; avoid importing any proprietary data.
- **`BattleCommand`** — `commandId` for deduplication, `battleId`, `expectedRevision` for stale-action rejection, `actorId` and a discriminated action payload; no direct client authority over outcome.
- **`BattleEvent`** — immutable event ID/sequence, battle ID, resulting revision, turn, typed event kind and original payload. Strict total order, no UI text hard-coded into simulation.
- **`CommandResult`** — explicit accept/reject response, standardized error reason, resulting state revision and ordered events; invalid commands do not partially mutate battle state.
- **`BattleReplayEnvelope`** — schema and content version, initial state, recorded seed (when randomness exists), accepted commands and ordered events for future reproducible replay.

### Candidate turn-phase values

`setup`, `awaiting_actions`, `resolving`, `finished`. These are **illustrative**, not an approval of simultaneous turn selection or exact action order. Include room for a later ruleset-specific phase model.

### Candidate command payload variants

| Variant | PN-004 treatment | PN-005+ treatment |
| --- | --- | --- |
| `Move` | Proposed typed structure: source, move, target; validate IDs and required fields | Move legality, accuracy, effects and damage |
| `Switch` | Proposed typed structure: source slot and replacement creature | Switching constraints, order, costs and faint replacement |
| `Forfeit` | Optional typed structure; owner must approve for first slice | Termination and PvP outcome policy |
| `Item`, `Capture` | **Deferred** from first implementation unless separately approved | Inventory, capture and battle inventory rules |

### Candidate event variants

`BattleStarted`, `TurnStarted`, `ActionSubmitted`, `ActionRejected`, `ActionResolved`, `MoveAttempted`, `DamageApplied`, `HealingApplied`, `EffectApplied`, `CombatantFainted`, `SwitchCompleted`, `BattleEnded`.

For the first contract, define a **minimal permitted subset** and separately document which variants are reserved for future versions. An event means a completed state transition, not merely an animation cue.

## 3. Proposed API boundary

The long-term interface resembles:

```ts
type SubmitCommand = (
  current: Readonly<BattleState>,
  command: BattleCommand,
  ruleset: VersionedRuleset,
) => CommandResult;

// Future PN-005 behavior:
type ResolveTurn = (
  current: Readonly<BattleState>,
  acceptedCommands: readonly BattleCommand[],
  rng: DeterministicRng,
) => { nextState: BattleState; events: readonly BattleEvent[] };
```

PN-004 may define interfaces and **contract validation**; it must not claim to simulate a completed turn. Exact function signatures, TypeScript runtime/tool versions, and serialization library choice require engineering review. The package must not require Godot, a server, a database, a network connection or a wall clock.

Proposed serialization: stable JSON-compatible messages with explicit schema versions and no arbitrary executable payloads. Future Godot adapter only *reads* events and submits intended actions; it does not author damage or award wins.

## 4. Proposed invariants and schema-level tests

1. Every combatant ID is unique within a battle; every active-slot reference names an existing eligible combatant.
2. HP is bounded by `0 <= currentHp <= maxHp` and `maxHp > 0`; numeric fields reject NaN and Infinity.
3. IDs, participant assignments, roster size and active-slot cardinality must pass explicit validation.
4. Duplicate `commandId` and stale `expectedRevision` must be rejected without mutations (or return the precisely cached result, if idempotent replay policy is approved).
5. Only a participant with the relevant authority may submit a command. No command may self-author a win or arbitrary HP change.
6. A terminal battle rejects further actions except any separately specified replay/read API.
7. Event sequence numbers are strictly increasing; events refer to the current battle and consistent revisions.
8. Unknown schema version, invalid action discriminator and missing required fields are explicit errors.
9. Serialization/deserialization is stable for approved fixtures; no executable behavior in JSON content.
10. No source module imports UI, Godot, HTTP, database or time APIs into the pure contracts.

**Minimum test categories (proposed):** valid state fixture; missing participant; invalid IDs; duplicate IDs; invalid active slot; negative HP; HP exceeding max; non-finite number; missing move ID; invalid command type; duplicate command ID; stale revision; terminal-state command; bad event ordering; unknown schema version; JSON round trip; rejected action state immutability; type-level exhaustive action/event handling.

Tests must be **actually run** and documented in the implementation PR. A passing schema test is not evidence that battle mechanics work.

## 5. Proposed implementation footprint (after approval)

```text
battle-engine/
  package.json
  tsconfig.json
  src/
    contracts/
      battle-state.ts
      battle-command.ts
      battle-event.ts
      result.ts
    validation/
    index.ts
  tests/
    fixtures/
    contracts.test.ts
  README.md
```

No original or third-party Pokémon names, ROM-derived species tables, proprietary move text or original-game artwork should be included. Use neutral placeholder combatants and attacks for tests. Choose pinned Node.js/TypeScript/test dependencies and document their licenses before implementation.

## 6. Owner approval gate — unresolved decisions

These decisions must be **recorded as confirmed**, or left intentionally deferred with a contract that does not hard-code them:

| Question | Suggested prototype default, **not approved** | Why this matters |
| --- | --- | --- |
| Battle modes | One-on-one PvE singles first; multiplayer and doubles later | Determines active slot and participants schema |
| Initial action set | Move and Switch; Forfeit if desired; Item/Capture later | Discriminated unions and legal-action queries |
| Turn submission | Both sides choose before resolution; exact timing deferred | State phase model and command ownership |
| Initial stats | HP, attack, defense, speed; add other stats by version | Prevents early overfitting to an unselected generation |
| Status/ability complexity | No abilities/weather/terrain in first contract; extensible effects | Keeps PN-004 schema small |
| Damage, accuracy and speed ties | **Defer all formulas to PN-005** | Avoids silently adopting another game's rules |
| RNG / replay | Seeded randomness and version metadata required later; no RNG draws in PN-004 | Determinism and auditability |
| Godot/TypeScript offline integration | Serialization boundary only now; adapter spike later | Do not commit to an untested runtime bridge |
| Canonical generation / cross-generation special mechanics | Not decided; contract must be extensible | Existing open items in DECISIONS.md |

**No choice in this table is confirmed simply because it appears here.** PN-004 remains Backlog until the project owner approves a sufficiently narrow subset and acceptance criteria.

## 7. Review and next actions

1. Project owner reviews the proposal in light of [REF-001](research/pokemmo-feature-analysis.md), [GDD](GDD.md) and [DECISIONS](DECISIONS.md).
2. Confirm only what PN-004 needs; defer PvP ranking, capture, mechanics across nine regions, paid protections, and live server questions.
3. Record approvals in DECISIONS.md, refine this document to **Approved**, and change the PN-004 task from Backlog to Ready.
4. Only then may Codex create an implementation branch, add typed contracts/validators/tests, run actual commands and submit a PR.
5. PN-005's deterministic turn engine and PN-006 Godot presentation are separate milestones.

**Scope boundary:** Draft/specification work is now possible, but **no PN-004 gameplay or schema implementation has been authorized yet**.
