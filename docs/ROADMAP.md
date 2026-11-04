# PokeNavis — Development Roadmap

**Version:** 1.0 · **Updated:** 2026-11-04  
**Principle:** Release proof of function before investing in full-scale content.

> Dates are indicative for a capable small team, not guaranteed deadlines. Solo development can take substantially longer. Full nine-region coverage is a multi-year content goal.

## Phase 0 — Pre-production (initial 1–2 weeks)

**Output:** Coherent design, initial tooling, versioned repository.

- [x] Choose working project name, initialize GitHub repository.
- [x] Write GDD, architecture, roadmap and decision register.
- [ ] Freeze first vertical-slice scope and non-copyrighted placeholder content.
- [x] Select Godot 4.7.2 stable and GDScript for initial client (D-016).
- [ ] Define battle model: creature, team, moves, turns, state and events.
- [ ] Create a list of 15–25 essential tests.
- [x] Establish contributor/PR policy and draft initial client setup instructions (PN-001).

**Exit gate:** Complete prototype specification and accepted reference art style.

## Phase 1 — Offline vertical slice (illustrative 2–4 months)

**One original test village, one route, one indoor location; 10–30 placeholder creatures.**

- [ ] Set up Godot project with resolution, input map and scenes.
- [ ] Tile movement, run animation, collisions and map transitions.
- [ ] Camera, dialogue and one basic quest.
- [ ] Grass/encounter trigger logic and encounter table.
- [ ] Pure deterministic battle simulator with basic statuses and switch.
- [ ] Turn-based battle UI, animations and text log.
- [ ] Capture, party roster, inventory and minimal storage.
- [ ] Local saving/loading, including versioned state format.
- [ ] Tests for battle determinism, save/load integrity and progression gates.

**Exit gate:** Fresh player can explore → encounter → fight → capture → save → reload with correct state and no critical crash.

## Phase 2 — Persistent online alpha (illustrative 3–6 additional months)

- [ ] Account login and player character storage.
- [ ] Server-authoritative zone presence and movement validation.
- [ ] See other players in a shared zone; chat and friend basics.
- [ ] Server-authoritative battle/capture persistence.
- [ ] Two-player trade with transactionality and duplicate prevention.
- [ ] Monitoring, backups, schema migrations, rate limits and abuse reporting.
- [ ] Load-test 50–100 controlled connected users as a validation target.

**Exit gate:** Two clients can interact safely, restart/reconnect without item loss, and pass concurrency tests.

## Phase 3 — First complete released region (illustrative 6–12 additional months)

- [ ] Main storyline and region-specific League/equivalent.
- [ ] Badges/quest progression and story NPC phasing.
- [ ] Regional team progression/collection transfer policy.
- [ ] Side and secret quest framework; weekly rotation service.
- [ ] 100% regional completion checklist (without mandatory boss).
- [ ] Region-completion travel unlock tested with at least one sandbox destination.
- [ ] Content build pipeline, map toolchain and performance optimization.

**Exit gate:** Player can complete the first region, revisit it, and unlock next-region access.

## Phase 4 — Competitive endgame (illustrative 4–8 additional months)

- [ ] Ranked PvP Singles, rating and matchmaking; Doubles after sufficient demand.
- [ ] Replay/audit pipeline and format versioning.
- [ ] Regional Legends boss AI and challenge entry gate.
- [ ] Daily reset job, one-win-per-day constraint.
- [ ] First-loss forgiveness and second-loss protection prompt.
- [ ] Monthly stackable grant and protection ledger.
- [ ] Protection consumption concurrency and outage recovery tests.
- [ ] Verified active, all-time and annual leaderboards.
- [ ] Prize/tie rules, exploit policy and moderation workflow.

**Exit gate:** Verified streaks cannot be fabricated, doubled or saved through duplicate redemptions; annual ranking rules are publicly specified.

## Phase 5 — Expansion and live operations (ongoing)

- [ ] Incrementally add other regions and their completion criteria.
- [ ] Expand creature and battle-mechanic coverage.
- [ ] Guilds, cooperative raids, advanced economy and cosmetics.
- [ ] Android port and cross-platform input/performance testing.
- [ ] Operations staffing, community support, live events and telemetry.
- [ ] Balance adjustments and versioned ruleset migrations.

**Exit gate:** Only expand content once the currently shipped systems meet stability and retention targets.

## First sprint: suggested backlog

| ID | Item | Priority | Definition of done |
| --- | --- | --- | --- |
| PN-001 | Godot project setup | P0 | Clean launch with committed import settings |
| PN-002 | Test map | P0 | Movement, collision, town→route transition |
| PN-003 | Entity interaction | P0 | NPC dialogue and interact prompt |
| PN-004 | Battle state schema | P0 | Stable typed state/actions/events |
| PN-005 | First battle simulation | P0 | Deterministic seeded results with tests |
| PN-006 | Battle UI adapter | P1 | State events render without UI-driven logic |
| PN-007 | Encounter generation | P1 | Data-driven wild spawn/encounter |
| PN-008 | Party and capture | P1 | Captured creature retained in party/storage |
| PN-009 | Local save | P1 | Reload reproduces progress |
| PN-010 | CI pipeline | P1 | Lint + unit tests on pushes |

## Key dependencies

- Battle rules first → wild encounters, Gym PvE, ranked PvP and world-record bosses.
- Server authority first → trading, item store, prizes and official leaderboards.
- Per-region story flags first → region unlocking and 100% postgame gating.
- Reliable audit and reset semantics first → launch of the daily world-record competition.

## Risks and mitigations

- **Scope creep:** Keep Phase 1 to one placeholder area and limited mechanics.
- **Content workload:** Shared tilesets, reusable quest data and incremental regions.
- **PvP complexity:** Single initial ranked format; versioned rules.
- **Economy exploits:** Atomic settlement, ledger, idempotency, tests.
- **Leaderboards compromised by purchases:** Decide ranking eligibility/caps before launch.
- **Intellectual property:** Keep early prototype content original; clear rights before publishing Pokémon-based content.
