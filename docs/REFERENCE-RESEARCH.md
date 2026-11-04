# PokeNavis — Reference Research Protocol

**Status:** Active research guidance (2026-11-04).  
**Scope:** Studying publicly observable game design and behavior without importing third-party code or assets.

## Purpose

PokeMMO and Pokémon games may be studied as **design references** for the independently implemented PokeNavis prototype: controls, visual readability, world/zone transitions, dialogue pacing, battle UX, party management, PvP usability and postgame loops.

**This document does not grant intellectual-property rights, alter third-party terms, or approve ROM/client reverse engineering.** Each contributor must ensure any referenced material is lawfully accessed and used.

## Allowed/reference-first workflow

1. The project owner identifies the **local PokeMMO installation folder** and, separately, any reference-material folder they are comfortable sharing. No installation path or file content is presumed to be available to Codex unless the user grants access.
2. **Read-only file survey:** Codex may list file names, folder layout, extensions and sizes to identify user-facing settings, logs, screenshots, supported mod/theme locations and relevant documentation. Reading an ordinary configuration, text log or freely licensed mod's public instructions is permitted **only when lawful, terms-compliant, necessary for the research and free of user secrets**. Redact account names, tokens, login information and private data from any shared notes.
3. **Do not treat a ROM or proprietary executable as ordinary documentation.** Do not unpack, disassemble, decompile, decrypt, circumvent protections, dump internal data, inspect runtime memory, intercept network traffic or reverse-engineer PokeMMO clients, servers or proprietary ROM contents. File metadata alone does not authorize studying protected internals.
4. The project owner runs the game **normally and manually** using files they are authorized to use. Codex can analyze supplied screen recordings/screenshots or the owner's descriptions; it should **not bot, macro, script or automate PokeMMO gameplay**.
5. Observe and document **visible behavior**: input, UI flow, timings, state transitions, feedback, error states and player-facing rules. Note uncertain inferences as hypotheses, not verified implementation details.
6. Write **original, high-level notes** or a feature comparison, recording the source and date. Reference gameplay footage or screenshots by links/brief descriptions only when authorized. Keep protected material out of the PokeNavis repository.
7. Identify improvements, implementation options and independently defined desired behavior. Separate **observations** from **engineering hypotheses** and **owner-approved PokeNavis decisions**.
8. Add the proposed behavior and trade-offs to a task or design document for project-owner approval. Only then should Codex implement independent code with original assets and data, tested against PokeNavis requirements rather than copying internal implementations.

## Do not do in the development repository

- Upload or commit ROMs, game installers, modified clients, proprietary art, tilesets, sounds, dialogues, extracted map tables, game binaries or third-party source code without clear rights and an explicit approved need.
- Instruct Codex to decompile, decrypt, unpack or bypass protections in the PokeMMO client; do not use cheating tools, automated play or client tampering for research.
- Copy sprite sheets, map geometry, NPC scripts, protected characters, names, music, audiovisual UI artwork or extracted data to PokeNavis.
- Assume ownership of a cartridge, access to a ROM, or a private research purpose automatically authorizes redistribution, commercial use or incorporation into this game.
- Upload raw files from a third-party installation to cloud tools merely for exploration. Keep unknown files local until rights, terms and necessity are assessed.

### Separate engine/code from creative content

A general design pattern (e.g., a top-down camera or turn-based actions) can inform a new independent implementation. The exact creative expression, source implementation and assets are a separate rights question. Review license terms of any proposed compatible open-source engine before adoption.

## Required deliverable: engineering research report

Write a reviewable Markdown report under `docs/research/` (e.g., `pokemmo-feature-analysis.md`) with these sections:

1. **Scope and provenance:** installation directories inspected (path may be redacted), observations provided by the owner, dates and versions, what could *not* be accessed, and permission/terms boundaries.
2. **Local file inventory (metadata only):** relevant categories such as settings, supported customizations, logs and nonproprietary documentation; exclude account IDs, secrets, ROM content, binary dumps, file hashes intended to identify proprietary assets and raw third-party code.
3. **Feature-by-feature behavior:** input → visible state transition → feedback → edge cases; include separately flagged observations and unverified inferences.
4. **PokeNavis architecture mapping:** suggest original modules/classes/contracts, scene graphs, event flow and data models for each relevant feature; describe why the design would be more maintainable, testable, secure or accessible.
5. **Comparative improvement matrix:** what to retain as a general interaction idea, what to simplify, what to redesign, and what new feature to add.
6. **Incremental implementation plan:** dependencies and milestones, prioritizing PN-004's battle state/action/event schema without silently deciding unresolved battle mechanics.
7. **Open questions and risk register:** decisions requiring the owner's approval; feasibility and technical uncertainties.

**This is a research-only deliverable.** Do not edit gameplay code or advance PN-004 status based on observations alone. Prefer concise representative screenshots in an owner-controlled location over committing third-party game images to the public repository.

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

> Read AGENTS.md and docs/REFERENCE-RESEARCH.md. I will give you the local PokeMMO installation path and optional screenshots/gameplay recordings. **Read-only inventory** the installation's file names, directory structure and relevant nonsecret, accessible configuration or supported customization documentation. Do not reverse-engineer client binaries or ROMs, extract proprietary assets, automate game inputs or access memory/network internals. Study the game's visible features via my observations and permitted recordings. Produce a research report mapping each feature to an **independent PokeNavis design**, including architecture, Godot implementation options, improvements, acceptance tests and dependencies. Distinguish observations from assumptions and seek owner approval before changing gameplay code.

## Legal and platform cautions

- PokeMMO's published [penalty policy](https://support.pokemmo.com/knowledgebase/article/penalty-policy) identifies client reverse engineering as prohibited.
- PokeMMO's [download instructions](https://pokemmo.com/en/downloads/) require the user to have the legal right to use their ROMs.
- PokeMMO's [video policy](https://pokemmo.com/en/video_policy/) permits playthrough-type video use subject to conditions, but does not grant rights to separately distribute extracted assets.
- Indian Copyright Act, 1957, section 52 includes limited computer-program observation, study and interoperability exceptions; the availability of any exception depends on facts and does not establish a broad right to republish protected content. See the [Copyright Office text](https://copyright.gov.in/Copyright_Act_1957/chapter_xi.html).

No ROM analysis is required for PN-004. The first battle-engine schema must be a standalone, independently authored specification with a deliberately limited set of original placeholder content.
