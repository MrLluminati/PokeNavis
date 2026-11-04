# PN-003 — NPC Interaction and Dialogue

**Status:** Ready for Codex implementation; not yet started.  
**Dependency:** [PN-002 merged](https://github.com/MrLluminati/PokeNavis/pull/3).  
**Phase:** 1 — offline vertical slice · **Priority:** P0.  
**Godot:** 4.7.2 stable (standard), GDScript, GL Compatibility.  
**Suggested feature branch:** `feature/PN-003-npc-dialogue`.

## 1. Goal

Extend the existing Test Village with a **reusable, interactable NPC** and a small, data-driven dialogue window. Players should approach the NPC, press an interaction key, read a short multi-line conversation, advance the dialogue and close it cleanly. The character should not walk while dialogue is open.

This is a technical test of an interaction/dialogue system, **not** the introduction of canonical Pokémon NPCs, quests or narrative content. Use original placeholder geometry/text.

## 2. Scope — required

1. **Preserve PN-002 behavior.** Test Village and Test Route remain navigable, and existing 32 physics/input checks continue to pass.
2. **Reusable NPC component.** Create a scene and script for an NPC that can be placed without rewriting world code. The NPC is visibly identifiable using original pixel art or simple colored placeholder geometry.
3. **One accessible Test Village NPC.** Place it on a reachable, walkable part of the map, away from the route exit and solid obstacles. Give it a collider so the player cannot walk through it. Do not trap the player or block the main path.
4. **Proximity-gated interaction.** Define a small interaction radius (initial default 40–48 pixels from the player's center) and require an explicit interaction key. A visible `E: Talk` or equivalent prompt appears only while in range. Ensure the player cannot interact through an intervening solid wall; either a facing check/short raycast or careful accessible placement plus line-of-sight check should be documented.
5. **Input mapping.** Bind `interact` to **E** and **Enter** (keyboard support). Existing WASD and arrow input must not regress. Use physical keys or document layout assumptions.
6. **Multi-line, data-driven dialogue.** Create at least one example conversation containing **three distinct lines**. Store the speaker name and text in a data structure separate from the dialogue UI (e.g., Resource, JSON or small GDScript data source). Replacing the content must not require changing UI scene logic.
7. **Dialogue UI.** Use a reusable `CanvasLayer`-hosted panel visible within the 960×540 viewport. Show NPC name, current line and a simple advance/close indicator. Press the interaction key to progress; the final line closes the panel. Escape (or a documented cancel key) closes early.
8. **Movement lock.** Disable normal player movement while dialogue is active; restore it immediately after closing. If arrow keys navigate UI, they must not move the player simultaneously. Keep the character and camera in place during conversation.
9. **Input debouncing.** The same keypress that opens the window must not also skip the first line. Holding the key must not auto-advance through all dialogue. Pressing interact out of range should do nothing.
10. **Robust scene lifecycle.** NPC/dialogue references should not break on Village→Route→Village scene transitions, on a new F5 session, or if the player moves into/out of the proximity radius. The dialogue panel should close or clean itself up if the world changes.
11. **Documentation.** Update `client/README.md` with controls, NPC location, interaction flow, test instructions and known limitations.

### Engineering defaults — not permanent game rules

- Use the existing player `CharacterBody2D` and GDScript; avoid networked NPC authority at this stage.
- Keep player–NPC interaction reusable, rather than hard-coded into Village's monolithic `world.gd`.
- A modest, readable bottom-of-screen dialogue box is sufficient; no portraits or animation are required.
- Implement minimal dialogue data versioning only if simple; do **not** add a full scripting language or localization system yet.
- Use `InputEvent.is_echo()` filtering, just-pressed actions, or equivalent state guards to prevent key-repeat/skipped text.
- If `Enter` also triggers Godot editor/window behavior on some systems, document any limitations and prioritize E.

## 3. Out of scope

- Quests, objective tracking, rewards, branching choices, conditional dialogue, saving NPC state, voice-over, shops, trading, networking, MMO chat, battle triggers, Pokémon species/canon characters, complex animation or cinematic dialogue.
- A complete map editor or a final production art set.
- Changes to the game's confirmed region/streak/PvP rules.

## 4. Acceptance criteria

The owner can run Godot 4.7.2 and verify:

1. F5 opens Test Village without parser or runtime errors.
2. The PN-002 player moves normally; all original blockers and Village↔Route transitions still function.
3. At least one NPC is visible, reachable and physically non-passable.
4. When out of range, `E` / `Enter` does not open dialogue and the prompt is absent.
5. When in range, the prompt appears, and exactly one interaction opens the panel on the **first** dialogue line.
6. Each subsequent distinct keypress advances exactly one line through at least three lines. Holding the key does not advance multiple lines.
7. The speaker label and current text display correctly; the final interaction closes the UI.
8. `Escape` exits dialogue early (if chosen as cancel) and returns normal movement.
9. While dialogue is open, WASD/arrows do not move the player; movement resumes after close.
10. Leaving interaction range suppresses the prompt; no distant interaction succeeds.
11. After a zone change and return, the NPC still works; no stale references or leaked panels.
12. The UI is legible and fits within the 960×540 Godot viewport.
13. The PN-001 splash remains accessible using its documented path.
14. There is no copyrighted Pokémon art, text or asset introduced.

## 5. Tests and review evidence

Run from the repository root with Godot 4.7.2 stable standard:

```bash
godot --version
godot --headless --path client --import
godot --headless --path client --quit-after 30
godot --headless --path client --script res://tests/world_smoke.gd
```

The original 32 checks should remain green. Add a focused `npc_dialogue_smoke.gd` test (or similarly named focused suite) that verifies: proximity/no prompt at distance; opening state and initial line; exactly one advance per press; final close and escape-close; player movement lock/unlock; NPC collision; zone transition cleanup and ability to interact again on return.

For manual verification in the editor, report actual outcomes for approaching the NPC, seeing the prompt, talking through the full three-line script, trying to move during dialogue, closing early, and returning from Test Route. Screenshots of one dialogue panel and the approach prompt are useful but optional. **Do not claim graphical or manual checks passed unless they were actually run.** Record exact command, exit code, Godot version and known limitations.

## 6. Deliverables and Codex handoff

- Reusable NPC scene/script, dialogue UI scene/script, separate sample dialogue data, and minimal integration with Test Village.
- Tests for NPC interaction and regression of PN-002, with actual results.
- Updated `client/README.md`, `docs/TASKS.md`, `docs/STATUS.md` and `CHANGELOG.md` **in the PR branch**, not as an unreviewed implementation on `main`.
- A PR titled `PN-003: Add NPC interaction and dialogue` against `main`, referencing the GitHub issue and this specification.
- State deviations from the design, anything not verified, and next actor.

**Codex instructions:** Pull the latest `main`. Read `AGENTS.md`, this specification, `docs/DECISIONS.md`, `docs/TASKS.md` and `client/README.md`. Create `feature/PN-003-npc-dialogue`. Implement only PN-003, test, document and open a PR. Do not start PN-004 or add a quest system. Do not mark PN-003 Done until the owner accepts and merges it.

## 7. Risks / design concerns

- Simultaneous `E` input opening and advancing dialogue.
- Collision/interaction range disagreement near obstacles.
- Player movement continuing because dialogue UI is in a separate scene.
- Player/NPC references becoming invalid on world transition.
- Text going outside the viewport at 960×540.

If a substantive game-design decision appears necessary, document it for owner approval instead of choosing a permanent rule.
