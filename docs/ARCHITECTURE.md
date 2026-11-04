# PokeNavis — Technical Architecture

**Version:** 1.0 foundation draft · **Status:** Proposed.  
**Goal:** Implement a testable offline 2D RPG slice, then extend it into a server-authoritative MMO.

## 1. Technology choices

| Layer | Starting plan | Notes |
| --- | --- | --- |
| 2D game client | Godot 4.x | Use version pinned after first build |
| Client scripting | GDScript initially | C# is viable; choose once before coding |
| Backend | Node.js + TypeScript | Start as a modular monolith |
| Battle rules | TypeScript pure simulation module | Standalone module reused by backend |
| Persistence | PostgreSQL | Relational transactional core |
| Caching/queues | Redis optional | Add only when justified |
| Assets | Original/temporary pixel art | No ROMs or proprietary sprites |

### Why modular first

One deployable backend with clear internal modules is easier to iterate and debug than many microservices. Split services only after profiling, concurrency tests or independent deployability requires it.

## 2. Logical modules

```text
Godot Client (Windows → Android later)
        │ secure session + real-time messages
        ▼
API / Session Gateway
        │
        ├── Accounts & Authentication
        ├── Characters & Regional Progression
        ├── World & Zone Presence
        ├── Encounters & Party/Storage
        ├── Battle Orchestrator ─── Pure Battle Engine
        ├── Quests & Rewards
        ├── Inventory, Trade & Economy
        ├── PvP Matchmaking & Replays
        ├── Legends Challenge / Leaderboards
        └── Admin / Anti-Abuse / Telemetry
        │
        ▼
PostgreSQL (durable state & transactions)
        └── Redis (optional cache/queues)
```

## 3. Ownership rules

- Client owns animations, UI, input prediction and rendering; it does **not** own authoritative account state.
- Server owns character location validation, encounters, capture outcomes, ownership transfers, rewards, story flags and financial balances.
- Battle engine owns deterministic battle outcomes but never writes to the database directly.
- Database records immutable receipts/events for high-value state changes; dedupe requests with idempotency keys.

## 4. Proposed monorepo

```text
client/                 Godot project
server/                 Node.js/TypeScript app
battle-engine/          Pure TypeScript library and tests
database/               SQL migrations, schema docs and seeds
assets/                 Authorized original/placeholder content
docs/                   Product and system specifications
```

When implementation begins, add pinned tool versions, package manifests, formatting/linting, test scripts and CI.

## 5. Important initial data entities

- `account`, `character`, `auth_session`
- `region`, `character_region_progress`, `quest_definition`, `quest_progress`
- `creature_species`, `creature_instance`, `moveset_version`
- `party_slot`, `storage_location`, `inventory_balance`, `inventory_transaction`
- `battle`, `battle_action`, `battle_result`, `battle_replay`
- `challenge_boss`, `challenge_day`, `boss_attempt`
- `streak_state`, `streak_history`, `protection_ledger`
- `pvp_format`, `pvp_season`, `rating_history`
- `trade`, `trade_item`, `trade_settlement`

Data model is subject to migration/prototyping. Do not establish final table names or columns until server modules and invariants are specified.

## 6. Battle engine boundary

Suggested pure API, illustrative only:

```ts
simulateTurn(
  ruleset: VersionedRuleset,
  state: BattleState,
  actions: PlayerAction[],
  rng: DeterministicRng
): { nextState: BattleState; events: BattleEvent[] }
```

Requirements:
- No network, UI, direct database writes or clock in simulation core.
- All randomness seeded/recorded for audit and replay.
- Content data version and ruleset version included in record.
- Fuzz/property tests for invalid actions, fainting, switching, status effects and edge cases.
- Review code licences and content/data rights independently before using third-party libraries.

## 7. Region progression boundary

- Store a character's progress **per region**, not as one global badge count.
- Only one new/uncompleted region may be active for its main adventure at a time.
- Travel to a *new* region requires completion of the current region main-story gate.
- Completed regions can be revisited.
- Region completion checklist is data-defined and may differ for nontraditional Pokémon League structures.
- Server enforces team eligibility for story battles; global collection remains intact.

## 8. Streak protection: correctness invariants

The Regional Legends service must enforce:

1. At most **one credited victory per boss per account per challenge day**.
2. On first defeat of a challenge day, next standard attempt is eligible and active streak is not reset.
3. On second and later defeats, either consume one confirmed protection and unlock the next eligible attempt, or reset active streak to zero.
4. Protection balances never become negative; one redemption consumes exactly one item.
5. The monthly free grant is at-most-once per account per calendar month, even if the grant job repeats.
6. A day with no credited victory at reset breaks the active streak; optional grace/incident policy must be explicit.
7. Every battle uses a versioned boss setup and signed/verified result evidence.
8. All changes are transactional, audited and idempotent.

Proposed transactional operations:
- `recordBossBattleResult(battleId, outcome)`
- `redeemProtection(accountId, bossId, challengeDay, idempotencyKey)`
- `creditDailyBossWin(accountId, bossId, challengeDay, battleId)`
- `grantMonthlyProtection(accountId, calendarMonth)`
- `closeChallengeDay(challengeDay)`

Use row-level locks / serializable or equivalent carefully chosen transaction semantics to avoid double-spend when concurrent redemption requests arrive.

## 9. Network and scale plan

**Prototype:** Offline local state, no backend dependency, all battle engine calls local through an adapter.

**Multiplayer alpha:** Authenticated gateway; server-owned player positions/zone membership; battles on server; transactional creature ownership; PostgreSQL persistence.

**Expansion:** Per-zone presence subscriptions, matchmaking queues, batched snapshots and horizontal scaling only when measured capacity requires it.

Evaluate WebSockets initially; select more specialized transport only when packet loss, mobile network behavior and latency tests justify it.

## 10. Security and maintenance

- Never embed API secrets or database passwords in the client/repo.
- Secure password handling (or external identity provider), token expiry/rotation, TLS.
- Validate messages, rate-limit endpoints and authenticate every inventory mutation.
- Maintain backups and restore drills; use migrations and staging environments.
- Instrument logs/metrics for failed trades, battle disputes, disconnects and reset jobs.
- Preserve evidence for top leaderboard records and adjudication.
- Do not publish unlicensed content or infringing assets as 'test data'.

## 11. Immediate engineering sequence

1. Choose Godot client scripting option and pin tool versions.
2. Create tile-based test room with movement/collision/transitions.
3. Define battle state and action/event types.
4. Implement battle simulator with test vectors.
5. Integrate Godot battle presentation through an adapter.
6. Add capture/party/save state.
7. Only then add the persistent online server.

See [ROADMAP.md](ROADMAP.md) for acceptance gates.
