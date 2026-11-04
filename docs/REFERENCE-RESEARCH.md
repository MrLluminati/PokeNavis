# PokeNavis — Reference Research Protocol

**Status:** Active research guidance (2026-11-04).  
**Scope:** Studying publicly observable game design and behavior without importing third-party code or assets.

## Purpose

PokeMMO and Pokémon games may be studied as **design references** for the independently implemented PokeNavis prototype: controls, visual readability, world/zone transitions, dialogue pacing, battle UX, party management, PvP usability and postgame loops.

**This document does not grant intellectual-property rights, alter third-party terms, or approve ROM/client reverse engineering.** Each contributor must ensure any referenced material is lawfully accessed and used.

## Allowed/reference-first workflow

1. The project owner runs the reference game in the ordinary supported manner, with files they are authorized to use.
2. Observe and document **visible behavior**: input, UI flow, timings, state transitions, feedback, error states and player-facing rules.
3. Write **original, high-level notes** or a feature comparison, recording the source and date. Reference gameplay footage or screenshots by links/brief descriptions only when authorized.
4. Identify improvements or desired independent behavior, and separate **observations** from **product decisions**.
5. Add proposed behavior to a task or design document for project-owner approval.
6. Codex implements independent code with original assets and data; tests validate PokeNavis requirements rather than attempting binary equivalence with protected games.

## Do not do in the development repository

- Upload or commit ROMs, game installers, modified clients, proprietary art, tilesets, sounds, dialogues, extracted map tables, game binaries or third-party source code without clear rights and an explicit approved need.
- Instruct Codex to decompile, decrypt, unpack or bypass protections in the PokeMMO client; do not use cheating tools, automated play or client tampering for research.
- Copy sprite sheets, map geometry, NPC scripts, protected characters, names, music, audiovisual UI artwork or extracted data to PokeNavis.
- Assume ownership of a cartridge, access to a ROM, or a private research purpose automatically authorizes redistribution, commercial use or incorporation into this game.
- Upload raw files from a third-party installation to cloud tools merely for exploration. Keep unknown files local until rights, terms and necessity are assessed.

### Separate engine/code from creative content

A general design pattern (e.g., a top-down camera or turn-based actions) can inform a new independent implementation. The exact creative expression, source implementation and assets are a separate rights question. Review license terms of any proposed compatible open-source engine before adoption.

## Comparison worksheet (fill with observations, not extracted data)

| Area | Questions | Original PokeNavis design goal |
| --- | --- | --- |
| Overworld | How does navigation feel? Collision, interaction radius, camera, transitions? | Responsive, readable movement on PC and later mobile |
| NPC dialogue | How is a conversation opened/advanced/cancelled? | Reusable accessible dialogue |
| Battles | How are turn actions selected? What information is displayed? | Deterministic, auditable state/actions/events |
| Party and storage | What is confusing or efficient about organization? | Responsive data-driven management |
| Multiplayer | What should be visible to other players? Which actions need server validation? | Server-authoritative progression |
| PvP | How discoverable are ranked formats, rules and outcomes? | Clear versioned formats and replays |
| Quests/progression | How are story gates, side quests and travel communicated? | Clear independently defined progression |

## Codex handoff prompt

> Read AGENTS.md and docs/REFERENCE-RESEARCH.md. Perform **reference-oriented comparative analysis only** using the owner's lawfully captured gameplay notes, UI descriptions or permitted screenshots/recordings. Do not inspect, extract or reverse-engineer ROMs or the PokeMMO client. Write a factual observation matrix, then propose **original PokeNavis requirements** with tradeoffs and questions for approval. Do not introduce assets, source code or mechanics into gameplay without an approved task.

## Legal and platform cautions

- PokeMMO's published [penalty policy](https://support.pokemmo.com/knowledgebase/article/penalty-policy) identifies client reverse engineering as prohibited.
- PokeMMO's [download instructions](https://pokemmo.com/en/downloads/) require the user to have the legal right to use their ROMs.
- PokeMMO's [video policy](https://pokemmo.com/en/video_policy/) permits playthrough-type video use subject to conditions, but does not grant rights to separately distribute extracted assets.
- Indian Copyright Act, 1957, section 52 includes limited computer-program observation, study and interoperability exceptions; the availability of any exception depends on facts and does not establish a broad right to republish protected content. See the [Copyright Office text](https://copyright.gov.in/Copyright_Act_1957/chapter_xi.html).

No ROM analysis is required for PN-004. The first battle-engine schema must be a standalone, independently authored specification with a deliberately limited set of original placeholder content.
