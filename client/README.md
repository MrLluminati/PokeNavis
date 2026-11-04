# PokeNavis Godot Client

**Status:** PN-002 first walkable test world is implemented in [PR #3](https://github.com/MrLluminati/PokeNavis/pull/3) and awaiting review. This is an offline prototype, not a playable RPG.

## Requirements and launch

- Godot **4.7.2 stable, standard edition** (GDScript; no .NET SDK): https://godotengine.org/download/archive/4.7.2-stable/
- GL Compatibility renderer; no third-party plugins or proprietary assets.
- Open `client/project.godot` in the editor and press **F5**. The project starts in **Test Village**. Press **F6** with `scenes/main.tscn` open to inspect the preserved PN-001 splash screen.

## Controls and navigation

| Input | Result |
| --- | --- |
| W / Up arrow | Move up |
| A / Left arrow | Move left |
| S / Down arrow | Move down |
| D / Right arrow | Move right |

Movement is 96 pixels per second while a key is held and stops when released. If horizontal and vertical keys are held together, horizontal input takes priority; the player never moves diagonally faster. The camera follows the player and stays within each 1280×896 map. Solid blue-gray blocks and the outer border stop movement.

From the Village starting point, walk **east** along the tan path to the cyan exit. You arrive safely on the west side of **Test Route**. Walk **west** along its path to the cyan return exit; you arrive near the east side of Village. Relaunch starts at the original Village spawn. No progress is saved.

The zones use original colored geometry on a 32×32 design grid, with grid-aligned Godot collision shapes. They do not use `TileMapLayer` yet; this keeps the small prototype editable through the shared `scripts/world.gd` layout. The player is one reusable `CharacterBody2D` scene, and the transition trigger is an `Area2D` in each zone. These are temporary engineering defaults, not final art or balance decisions.

## Source layout

```text
client/
  project.godot                 Main scene and WASD/arrow input actions
  scenes/main.tscn              Preserved PN-001 splash scene
  scenes/player.tscn            Reusable player, collision and camera
  scenes/world/test_village.tscn
  scenes/world/test_route.tscn
  scripts/player.gd             Cardinal movement in physics updates
  scripts/world.gd              Placeholder maps, blockers and exits
  tests/world_smoke.gd          Focused movement and transition checks
```

Godot-generated `.godot/` cache files are ignored. Generated `.gd.uid` files are tracked with the scripts.

## Reproduce verification

From the repository root, with Godot 4.7.2 standard on `PATH` as `godot` (or replace it with the executable's full path):

```bash
godot --version
godot --headless --path client --import
godot --headless --path client --quit-after 30
godot --headless --path client --script res://tests/world_smoke.gd
```

In the editor, press F5 and confirm the Village scene displays at 960×540 with no errors. Move with WASD and arrows, try simultaneous horizontal and vertical input, collide with solid blocks and the map edge, and walk through the cyan exits in both directions. Stop and press F5 again to verify the original Village spawn.

## Actual verification on 2026-11-04

Windows x86_64; official Godot standard executable `Godot_v4.7.2-stable_win64_console.exe`, version `4.7.2.stable.official.ed1daf0bf`:

| Check | Observed result |
| --- | --- |
| `--version` | Exit 0; printed `4.7.2.stable.official.ed1daf0bf` |
| `--headless --path client --import` | Exit 0; import completed without errors |
| `--headless --path client --quit-after 30` | Exit 0; no script or resource errors |
| `--headless --path client --script res://tests/world_smoke.gd` | Exit 0; all 32 checks passed, including key mappings, movement, camera limits/follow, blockers/edges, two-way exits, safe arrivals and relaunch |
| Editor F5 | Village displayed in the 960×540 debug window; the editor Output panel showed zero errors and zero warnings |
| Graphical capture of Village and Route | Both commands exited 0; GL Compatibility rendered 960×540 frames. Inspected frames are in [`docs/screenshots`](../docs/screenshots/). |

The movement and transition checks above were driven by the development test in a physics session. The graphical F5 check established launch and appearance; a continuous manual keyboard traversal was not recorded. The test and editor checks together cover the specified behavior. See [PN-002 specification](../docs/PN-002-SPEC.md) and [Issue #2](https://github.com/MrLluminati/PokeNavis/issues/2).

![Test Village startup](../docs/screenshots/pn-002-test-village.png)

![Test Route opened directly](../docs/screenshots/pn-002-test-route.png)

**Scope:** No NPC dialogue, encounters, battles, inventory, save system, networking or Pokémon-owned assets were added.
