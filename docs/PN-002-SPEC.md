# PN-002 — First 2D Test World, Player Movement and Collision

**Status:** Implemented on `feature/PN-002-world-movement`; [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) is in review, not merged. See [client verification](../client/README.md).
**Dependency:** [PN-001 merged](https://github.com/MrLluminati/PokeNavis/pull/1)  
**Priority:** P0 · **Engine:** Godot 4.7.2 stable (standard), GDScript, GL Compatibility  
**Working branch:** `feature/PN-002-world-movement` (created from current `main`).
**Owner approval:** The first playable test zone is part of the approved Phase 1 prototype. All details below are small engineering defaults rather than new long-term gameplay rules.

## 1. Objective

Turn the verified Godot bootstrap into a **walkable 2D prototype**. The player should be able to move around an original test village, collide with obstacles, follow a camera, and walk through a clearly marked map exit to an original test route and back.

The work is a technical vertical slice, **not an actual Pokémon region**. All maps, sprites and tiles must be newly created placeholders or properly licensed originals.

## 2. Scope

### Required

1. **Godot 4.7.2 project remains runnable**. Reuse existing project settings, do not change engine or language.
2. **One reusable player scene** backed by `CharacterBody2D`, `CollisionShape2D` and GDScript. Player representation can initially be a simple original pixel-art sprite or solid-color pixel block. Clearly distinct from background.
3. **Four-direction movement** with arrows and WASD. Implement deterministic cardinal-only direction selection if two keys are held; prevent diagonal speed advantage. Start with configurable speed around **96 px/second**; this is a prototype tuning default, not a permanent game-balance rule.
4. **World collisions** against obstacles/walls and outer boundaries using Godot collision layers/masks and `move_and_slide()` or appropriate Godot 4.x APIs. The character must not cross solid blockers, clip outside the map, or get stuck on spawn.
5. **Two connected placeholder zones**:
   - **Test Village:** original small top-down grid, visibly different walkable ground, walls/obstacles and one exit.
   - **Test Route:** original adjoining zone, different ground arrangement and a return exit.
6. **Camera2D** follows the player. Avoid revealing outside the active map, where reasonable, and avoid viewport jitter at pixel-art scale.
7. **Scene transitions** via an entry/exit trigger. Entering the Village exit loads Route at a safe spawn; the reverse exit returns to Village. Prevent immediate re-triggering as the new scene loads.
8. Preserve a simple launch route through **F5**. Keep a developer-friendly way to re-open the PN-001 splash screen if its main-scene entry changes, or document its replacement. Avoid losing source/history.
9. Provide readable scene names, a clear directory structure and comments explaining unusual logic. Document controls and navigation in `client/README.md`.

### Implementation guidance (not mandatory architecture)

- Use a **32×32 design grid** for the prototype. Godot 4.7 `TileMapLayer` is preferred for editable tile-based ground and colliders, but a transparent, testable alternative with grid-aligned colliders is acceptable if it keeps scope small.
- Example layout: `client/scenes/world/test_village.tscn`, `test_route.tscn`, `player.tscn`; `client/scripts/player.gd`; a map-exit component/shared transition script.
- Use placeholder geometry or authored pixel art. No downloaded or extracted Pokémon map assets.
- Keep player motion in physics updates (`_physics_process`), and keep input mapping explicit in `project.godot`.
- If a single controller/scene manager simplifies zone changes, prefer the simplest robust approach; don't introduce networking, persistence or an entity-component framework.
- Preserve camera positioning on maps smaller than the viewport; black borders are acceptable in early prototype only when documented.

## 3. Out of scope

Do **not** add NPC dialogue (PN-003), Pokémon encounter logic (PN-007), combat (PN-004/005), inventory, quests, saves, networking, MMO login, monetization, real regions, third-party Pokémon tilesets, a content-generation pipeline or Android builds.

## 4. Acceptance criteria / manual tests

A reviewer using Godot 4.7.2 standard can:

1. Open `client/project.godot` and run F5 without script, scene or resource errors.
2. See the Test Village and a clearly visible player at a walkable initial spawn.
3. Press **W/A/S/D** and **arrow keys**; character moves only in intended cardinal directions and stops when released.
4. Hold diagonal input; speed and direction remain well-defined (no faster diagonal motion).
5. Walk into a wall, obstacle and map edge; collision prevents crossing or leaving the play area. Repeated collision and sliding do not trap the player.
6. Observe the camera follow a moving player while respecting any configured map bounds.
7. Enter the Village exit; appear at the designated Route spawn. Re-enter the return exit; appear safely in Village (without transition loops or accidental repeated transitions).
8. Stop the game and relaunch; the scene still initializes cleanly at its initial test-world spawn. No persistence is required.
9. Confirm the title/startup screen from PN-001 can still be inspected by opening its scene (or that its replacement is explained).
10. Inspect the PR and `client/README.md` to reproduce controls, scene navigation and test instructions.

### Required automated/command-line verification

On a Windows PC with the official Godot 4.7.2 standard executable, or the corresponding binary on another OS:

```bash
godot --version
godot --headless --path client --import
godot --headless --path client --quit-after 30
```

Run actual tests and report **exact executable/version, commands, exit codes and errors**. Headless tests cannot establish that keyboard, collision and camera behavior are correct. Manually verify those in a graphical F5 session, ideally with reproducible screenshots or a short capture **if practical**.

If feasible, add focused tests or development-only assertions for spawn positions, camera/map bounds and transition destinations. Do not claim such tests ran unless they did.

## 5. Deliverables

- Godot scene(s), player script and any required original placeholder assets.
- Updated `client/project.godot` input map/main scene references as needed.
- Updated `client/README.md` with launch steps, controls, scene paths and actual test outcomes.
- Updated `docs/TASKS.md`, `docs/STATUS.md` and `CHANGELOG.md` to reflect **real** state.
- PR linked to task PN-002, with a concise explanation of code layout, commands run, results and known limitations.

## 6. Codex handoff

1. Pull latest `main` **after PR #1**.
2. Read `AGENTS.md`, `CONTRIBUTING.md`, `docs/STATUS.md`, `docs/TASKS.md` and this specification.
3. Create `feature/PN-002-world-movement` from current `main`.
4. Implement **PN-002 only**, favoring the simplest idiomatic Godot 4.7.2 approach.
5. Run headless import and startup, then manually test movement, collisions, camera and two-way scene transitions in Godot. Clearly identify anything untested.
6. Push the branch, open a PR against `main`, and report a reviewable, reproducible result.
7. Update task status to **In progress** in the PR when implementation starts; **In review** when it is ready. Do not mark Done before owner review and merge.
8. Do not start PN-003 without a separate task/authorization.

## 7. Known risks

- Correct collision coordinates when mixing tilemaps and player hitboxes.
- Transition loops if the player spawns inside an exit trigger.
- Camera/map-bound behavior at 960×540.
- Pixel rounding and animation jitter in GL Compatibility rendering.

Record any design deviation clearly in the PR; escalate questions affecting permanent gameplay behavior rather than silently deciding them.
