# PokeNavis — Design Decisions and Open Questions

**Last updated:** 2026-11-04

This register distinguishes **confirmed user decisions** from **proposals** and **unresolved choices**. Do not implement an open proposal as a final rule without agreement.

## Confirmed

| ID | Area | Decision |
| --- | --- | --- |
| D-001 | Brand | Name: **PokeNavis**; repository: `MrLluminati/PokeNavis` |
| D-002 | Visuals | Retain **2D sprite style** inspired by Generation 5 |
| D-003 | World | Nine-region long-term goal, from Kanto through Paldea |
| D-004 | Start | New player may choose any available starting region |
| D-005 | Travel | To unlock another new region, finish the present region's main story and League/equivalent |
| D-006 | Story | Preserve original-style regional stories; add secret, side and weekly missions |
| D-007 | Postgame | One **optional ultimate boss per region** unlocked after defined 100% completion |
| D-008 | Boss cadence | Fixed worldwide daily reset; one credited win per region boss per day |
| D-009 | Boss attempts | First loss forgiven; second defeat breaks streak unless player opts to use a protection |
| D-010 | Protection | Spending one protection after a potentially streak-breaking defeat unlocks another attempt; further losses require additional protection to continue |
| D-011 | Protection grants | One free protection monthly; unused protections **accumulate** |
| D-012 | Protection ownership | Account-wide and non-tradable initially; possible trading later |
| D-013 | Protection store | Additional protections can be purchased from an in-game store |
| D-014 | Records | Regional streak world records, rankings and top-three annual rewards |
| D-015 | Development | Start with small playable 2D prototype; grow to persistent MMO |

## Proposals not yet confirmed

| ID | Proposal | Why it matters |
| --- | --- | --- |
| P-001 | Global daily reset at 00:00 UTC | Uniform worldwide fairness |
| P-002 | PC client in Godot 4, TypeScript backend | Simple incremental architecture |
| P-003 | Use GDScript for initial client | Fast Godot iteration; can choose C# |
| P-004 | One canonical modern battle ruleset, classic formats later | Compatibility across generations |
| P-005 | Story party restrictions in every newly started region | Prevent high-level imports trivializing stories |
| P-006 | Annual regional and/or global trophies with cosmetic prizes | Awards need unambiguous eligibility |
| P-007 | Public 'unprotected streak' prestige category | Recognize win consistency separately from consumables |
| P-008 | Standardized, versioned daily boss rotations | Verifiable fair comparison |
| P-009 | Anti-abuse caps on daily protection redemptions | Guard against purchasable unlimited retries |
| P-010 | Approved original test region (temporary maps and creatures) for MVP | Safely validate game engine first |

## Decisions needed before specific implementation

### Before combat engine
1. Choose canonical battle generation and learnset policy.
2. Choose initial feature subset, move/ability order and status rules.
3. Decide if and how Mega Evolution, Z-Moves, Dynamax and Terastallization coexist.
4. Choose GDScript or C# client and how it calls the TypeScript engine locally/offline.

### Before multi-region story
5. Choose narrative version per region (e.g., Black/White or sequels).
6. Define import/obedience/level-sync rules for previously captured Pokémon.
7. Publish exact, finite 100% completion checklists.

### Before boss records and monetization
8. Confirm daily reset time and match overlap/grace/disconnect policy.
9. Define unlimited vs capped protection consumptions per day.
10. Decide whether paid protections count in official prize-eligible rankings.
11. Define annual score, tie-breakers, geography/age eligibility and reward rules.
12. Specify free monthly grant date and policy for newly created accounts.
13. Define whether protections are shared across regional bosses (current design says account-wide).
14. Confirm what constitutes a 'defeat' for disconnects, surrenders and draws.

### Before public release
15. Asset, character, region, ROM, software and name rights clearance.
16. Store currency, anti-fraud measures, moderation, privacy, retention and incident policies.

## Decision-record process

Each change should record:
- Date and decision ID.
- Previous behavior vs new rule.
- Why the change was made.
- Effect on saves, battle replays, rankings and economy.
- Migration/version plan where applicable.

**Next recommended decision:** Scope the first battle simulator, then the first playable Godot test world.
