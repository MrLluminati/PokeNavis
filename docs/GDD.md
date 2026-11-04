# PokeNavis — Master Game Design Document

**Version:** 1.0 (foundation draft)  
**Date:** 2026-11-04  
**Status:** Pre-production. Features marked *proposed* or *open* are not final.  
**Target:** A persistent, 2D, pixel-art, Pokémon-inspired multiplayer RPG.

> **Scope and rights:** This is a design specification, not authorization to publish Pokémon-owned characters, names, maps, dialogue, sprites, sounds or mechanics protected by specific rights. Build the first technical prototype with original placeholder content. A Pokémon-specific release requires rights clearance. Keep independently authored client/server code distinct from third-party data and assets.

## 1. Product vision

**Working title:** PokeNavis  
**Tagline:** One World. Every Region. Endless Adventures.

Build a modern online RPG that retains the feel of classic Pokémon adventures while addressing three weaknesses identified in PokeMMO:

1. Move restrictions should not unnecessarily limit story/PvE play. Competitive formats have independently defined rules.
2. Region coverage should ultimately extend from Kanto through Paldea rather than stop after five regions.
3. PvP should feature robust ranked formats, matchmaking, replays, observable ratings and transparent rule changes.

A fourth distinguishing feature is a **Regional Legends Challenge**: optional, difficult daily postgame boss fights that support verified consecutive-day world records and annual awards.

### Product pillars

1. **Classic feel, unified presentation:** Generation 5-inspired top-down 2D/2.5D pixel art and readable turn-based battles.
2. **Player-chosen journey:** Start in any released region; finish its main narrative before unlocking the next new region.
3. **Shared online world, personal adventure:** Players coexist in towns/routes, but their main story and Gym/League state belong to the individual.
4. **Competitive integrity:** Deterministic, server-validated battles and transparent PvP/PvE rankings.
5. **Long-term retention without compulsory grinding:** Optional quests, postgame bosses, weekly activities and meaningful achievements.

## 2. Target experience and release strategy

- **Initial platform:** Windows PC; **later:** Android (after input, performance and backend testing).
- **Visual direction:** Tile-based overworld, animated sprites, layered environments, clear top-down navigation. Suggested initial tile base: 32 × 32 pixels; final tile scale pending visual prototype.
- **Online model:** Persistent accounts; shared zones; private story states and instanced battles.
- **Development approach:** Offline vertical slice → server-validated multiplayer alpha → one complete region → competitive endgame → additional regions.
- **Full-world scope:** Kanto, Johto, Hoenn, Sinnoh, Unova, Kalos, Alola, Galar, Paldea as the **long-term target**, not a launch promise.
- **Starting selection:** Any region that is implemented and released can be selected for a new character.

## 3. Core gameplay loop

`Explore → Encounter → Battle/Capture → Train & Build Team → Complete Story/Quests → Unlock Areas → PvP/Postgame → Return for New Goals`

Supporting loops:
- Collection and creature development.
- Multiplayer trading and social interaction.
- Competitive PvP ladders and hosted tournaments.
- Daily regional boss challenges and all-time record tracking.
- Secret quests and weekly objectives.

## 4. Regions and story progression

### 4.1 New-character start

1. Create an account and character.
2. Select any **released** starting region.
3. Begin that region's traditional-style storyline and obtain its starter under the chosen content rules.
4. Finish region-specific main-story objectives, including the Pokémon League or a canon-appropriate equivalent.
5. The system unlocks selection of another **uncompleted** region.

There is **no mandatory generation order**.

### 4.2 Region state

Each character has independent state for each region:

- `not_started`
- `in_progress`
- `main_completed`
- `completion_100_percent` (postgame checklist completed; see §9)

Rules:
- A new uncompleted region remains locked while the current new region's main story is in progress.
- Main-story completion unlocks the choice of another new released region.
- Previously completed regions remain freely revisitable, even when a different region's main storyline is active.
- Optional weekly/side/secret quests never block core region unlock.
- Full postgame completion is distinct from main-story completion.
- Completion criteria are data-driven per region: Kanto/Johto-like Gyms and Elite Four; Alola's island trials; Galar's Champion Cup; Paldea's three paths plus Area Zero conclusion.

### 4.3 Pokémon collection across regions

- Account-wide collection/storage is persistent.
- Each new region gets an appropriate **regional story progression team** so high-level imports cannot trivially bypass the adventure.
- PvP and already completed regions can use the permitted global collection, according to their battle rulesets.
- **Open:** Whether story team restrictions use new-region-only eligibility, imported-monster level synchronization, obedience limits, or a hybrid.
- Travel and storage UI must clearly explain available party members and restrictions.

### 4.4 Multiplayer and phasing

- Shared: overworld presence, town social areas, chat, friends, permitted trading, group activities.
- Per-character/instanced: cutscenes, Gym/League fights, villain events, story-state-specific NPC dialog.
- Battle participants share a battle instance; spectators join only through authorized spectator/replay channels.
- Zone occupancy, encounter spawning and instanced content scale independently.

## 5. Quest categories

| Quest type | Availability | Purpose |
| --- | --- | --- |
| Main story | Once per region | Canon-style progression, unlocks, badges |
| Side quests | Optional, permanent or repeatable where specified | Lore, exploration, supplies, cosmetics |
| Secret quests | Hidden, prerequisite-driven | Discovery, rare encounters, titles |
| Weekly quests | Rotating on global weekly reset | Retention, diverse activities |
| Postgame quests | After main-story completion | Endgame challenge, regional activities |

- Weekly quests must be achievable within currently unlocked regions.
- Quest objectives and rewards are defined by structured data; server controls completion.
- Do not make essential battle moves or must-have competitive options exclusively time-limited.
- Quests need localization-ready dialogue IDs and progression flags.
- No hidden requirement may be part of the 100% checklist unless explicitly announced to the player; secret quests may exist outside that checklist.

## 6. Battle system

### 6.1 Common rules engine

The core battle engine must be **deterministic, versioned, replayable and independent of UI**. It consumes validated teams, initial random seed and player choices; it produces authoritative events.

Initial feature set:
- Singles wild/trainer battles; health, turn order, move damage, accuracy, status, fainting.
- Type matchup chart, stats, nature, abilities, items and switching as implementation advances.
- Capture and experience/evolution for eligible PvE.
- Later: doubles, weather, field effects, hazards, multi-turn moves, complete move/ability/item catalogs.

Tests must cover seeded battle replays and interaction edge cases.

### 6.2 Moves, learnsets and formats

- Move availability in PvE should be as broad as the chosen content rules allow.
- Keep **creature learnsets** separate from **format bans** and **ruleset constraints**.
- Each battle has a `ruleset_id` and `ruleset_version`.
- PvE/casual may permit combinations restricted in specific ranked formats.
- Data from different Pokémon generations may conflict; a documented **canonical modern ruleset** and optional classic formats are needed.
- **Open:** Which generation is canonical for move stats, abilities, items, evolutions and balance changes; which battle gimmicks are enabled per format.

### 6.3 Competitive PvP

Target formats:
- Ranked Singles; ranked Doubles later.
- Casual battles and friend challenges.
- Tournaments and seasonal rankings.
- Replays, match histories, player ratings and transparent rulesets.
- Anti-cheat, anti-win-trading and matchmaking abuse detection.

**Open:** initial team size/rank tiers, matchmaking rating formula, season length and queue availability. Do not fragment the first alpha's player base across many queues.

## 7. Economy, collection and social systems

- Account-owned party, inventory, collection, currency and progression.
- Trading, marketplace, purchase records and consumption are server-authoritative.
- Future: breeding and IV/EV optimization, trading post, guilds, cooperative raids, cosmetics.
- Prioritize idempotent economy operations, audit trails, transactional updates and duplicate-item prevention.
- Currency sinks and acquisition rates require simulation before live operation.
- Design objective: avoid exclusive pay-to-win battle power and preserve competitive fairness.

## 8. Regional Legends Challenge (signature endgame)

### 8.1 Unlock and boss structure

- Exactly one designated **optional ultimate regional boss** per released region initially.
- Becomes available after a published, finite **100% regional completion checklist**.
- The boss itself is **not** a prerequisite to the 100% checklist.
- Boss battles are replayable once per global challenge day **after the day's victory**; unsuccessful players may retry under the attempt/protection rules.
- Boss fights are independent per region: Johto and Sinnoh rankings are not directly interchangeable.
- Design references might include an opponent like Red on Mt. Silver, but no protected character/asset is included in the prototype.

### 8.2 Daily attempts and streak protection — agreed rules

- Attempt 1 is included in each challenge day.
- Defeat on Attempt 1 **does not break the streak**; Attempt 2 is available.
- A victory on Attempt 1 or 2 marks the day as won and increases the streak by 1.
- Defeat on Attempt 2 **breaks the streak unless the player elects to consume one Streak Protection** to unlock Attempt 3.
- On every later defeat, another protection is needed to continue (if eligible under any eventual cap).
- If the player declines protection, has none available or fails to win before the next daily reset, active streak = 0.
- A win on any permitted attempt advances the daily streak exactly once; after victory the boss is locked until the next daily reset.
- Protection cannot excuse an entire missed day or retroactively revive a lost streak.
- Protections are **account-wide, stackable, consumed per extra attempt, and non-tradable at launch**.
- Each account receives **one free protection per calendar month**; unused protections accumulate indefinitely unless a future inventory cap is approved.
- Additional protections may be purchased from an in-game store; currency, pricing and competitive use restrictions are **open**.
- The server must show a confirm/decline prompt after a potentially streak-breaking defeat; consume only after confirmation.

Examples (starting streak 49):

| Today's outcome | End-of-day streak |
| --- | ---: |
| Win attempt 1 | 50 |
| Lose attempt 1; win attempt 2 | 50 |
| Lose attempts 1 & 2; decline protection | 0 |
| Lose attempts 1 & 2; spend protection; win attempt 3 | 50 |
| Lose attempts 1, 2 & 3; no further protection | 0 |
| Miss challenge day or no win by reset | 0 |

### 8.3 Reset and time boundaries

- **Proposed:** single worldwide challenge reset at **00:00 UTC**. This is not yet a final clock-time decision.
- Use an explicit `challenge_day` derived from UTC server time (never client clock).
- **Proposed:** a match begun before reset must finish by a published grace deadline; avoid exploiting two days in one match.
- Free protection allocation occurs once per **calendar month** at the designated global boundary.
- Incident policy needed for outages, disconnects and emergency maintenance.

### 8.4 Rankings and records

Maintain separate verified metrics, per boss:
1. **Current active daily win streak**.
2. **Lifetime personal best streak**.
3. **All-time world record** with historical holders.
4. **Annual season score**; lifetime streaks continue through annual year boundaries.
5. **Unprotected / flawless performance** as an additional prestige indicator.

Records must retain all attempt outcomes, protection consumptions, ruleset versions and battle evidence. Changing a boss team or difficulty across seasons requires a versioned fairness plan.

### 8.5 Rewards

- Daily win: modest controlled reward.
- Milestone rewards: e.g. 7/30/100/365 days; mostly cosmetic/recognition.
- Annual: special recognition and prizes for the top three under the chosen regional/global award format.
- **Open:** Exact monetary/non-monetary prize rules, tie breakers, anti-alt-account policy, regional versus global top-three, purchasable protection eligibility and daily protection redemption caps.
- Do not promise real-money prizes until rules, eligibility, regulatory, anti-fraud and operational checks are complete.

## 9. 100% regional completion

Each region has a **published** completion checklist, separate from normal main-story completion. A possible framework:
- Finish all main story and League/equivalent objectives.
- Finish clearly enumerated postgame story arcs.
- Defeat listed optional trainer challenges.
- Discover required major areas (excluding unattainable or time-limited content).
- Complete a finite set of visible region-specific milestones.

**Not required:** every shiny, all species, random drops, active seasonal events, limitless repeatable quests or the Regional Legends boss itself.

This ensures the challenge remains difficult but objectively achievable.

## 10. Visual, content and UX standards

- Classic readable sprites and cohesive tile scale across all regions.
- Town/route maps support collision, layers, interior transitions, weather and event markers.
- UI supports mouse/keyboard now; touch later.
- Usability focus: concise item descriptions, clear battle feedback, explainable progression restrictions, screen-reader/contrast considerations where feasible.
- Content must be authored via validated structured data, not hard-coded into UI scenes.

## 11. Non-functional requirements

- **Authority:** Server validates account changes, battles, trades, item purchases and streaks.
- **Integrity:** Replay/transaction logging, anti-duplication, rate limits, abuse detection.
- **Reliability:** Reconnect handling, backups, data migrations, monitoring.
- **Performance:** Build budgets from prototype profiling; do not claim a concurrent-user capacity before load tests.
- **Privacy/security:** Minimal personally identifiable data; secret management, HTTPS/TLS, hashed passwords or suitable external auth provider; account recovery design.
- **Operations:** Admin audit logs, incident compensation policy, ruleset rollback plan and clear player communication.
- **Testing:** Unit/property tests for deterministic combat, integration tests for trades, concurrency tests for streak protection and daily reset race conditions.

## 12. Exclusions from prototype

Not part of the first playable slice: nine full regions, live marketplace, global matchmaker, commercial store, multi-year records, all existing Pokémon species, complete battle gimmicks, major guild systems or Android optimization.

## 13. Current open questions

See [DECISIONS.md](DECISIONS.md), especially:
- Story-team regional transfer restrictions.
- Canonical generation rules and battle gimmicks.
- Scope of the first fully built region.
- Boss team and AI difficulty versioning.
- Paid protection fairness and caps.
- Annual rank definitions and prizes.
- Exact daily reset/grace policy.
- Rights and third-party content clearance.

## 14. Milestone gates

- **Gate A:** Local offline vertical slice passes movement, encounter, battle, capture and save tests.
- **Gate B:** Two authenticated clients coexist; server-owned inventory and trades are transactionally safe.
- **Gate C:** One region's main-story completion and region unlock work in automated tests.
- **Gate D:** Ranked battle formats, auditable daily boss streaks and protection prompts withstand concurrency/clock testing.
- **Gate E:** A release candidate meets performance, content, operations, security and rights-clearance requirements.

The next work item is **Gate A**. Do not prematurely implement expansion content.
