# PokeNavis Godot Client

**Status:** PN-001 starter scene verified with Godot 4.7.2; awaiting PR review. This is not a playable RPG yet.

## Required environment

- **Godot 4.7.2 stable, standard edition** (not the .NET/C# edition): https://godotengine.org/download/archive/4.7.2-stable/
- **Scripting:** GDScript.
- **Renderer:** GL Compatibility for this small 2D prototype.
- No third-party plugins, extracted Pokémon assets or separate packages.

## Editor launch (Windows or other desktop OS)

1. Download the **Godot 4.7.2 standard** executable.
2. Launch Godot; use Project Manager **Import** to select `PokeNavis/client/project.godot`.
3. Open the project and press **F5** (Run Project).
4. Expect a dark 960×540 startup window showing "PokeNavis", "2D Multiplayer RPG - Prototype", and `PN-001 | Godot 4.7.2 + GDScript`.
5. Confirm the Output panel contains `PokeNavis PN-001: startup scene ready` without script/resource errors.

## Headless smoke tests (from repository root)

If the Godot executable is on PATH as `godot`:

```bash
godot --version
godot --headless --path client --import
godot --headless --path client --quit-after 5
```

The first command should report 4.7.2 stable. The next two import and launch the minimal startup scene without a window. The last command should print the PN-001 startup message.

On Windows, replace `godot` with the full executable path if it is not in PATH. The launch steps do not require C#/.NET tooling.

## Verification (2026-11-04)

Windows x86_64, official Godot 4.7.2 stable **standard** build (`4.7.2.stable.official.ed1daf0bf`):

| Command from repository root | Result |
| --- | --- |
| `Godot_v4.7.2-stable_win64_console.exe --version` | Passed; printed `4.7.2.stable.official.ed1daf0bf` |
| `Godot_v4.7.2-stable_win64_console.exe --headless --path client --import` | Passed; exit code 0, import and editor initialization completed without errors |
| `Godot_v4.7.2-stable_win64_console.exe --headless --path client --quit-after 5` | Passed; exit code 0, printed `PokeNavis PN-001: startup scene ready` |
| `Godot_v4.7.2-stable_win64_console.exe --path client --write-movie <temporary-output>.png --quit-after 5` | Passed; exit code 0, GL Compatibility rendered five 960×540 frames. The inspected frame displayed the expected title, subtitle and status text; output contained the startup message without errors. |
| Godot editor: open `client/project.godot`, press F5 | Passed; the running scene displayed the expected title, subtitle and status, and the Output panel printed `PokeNavis PN-001: startup scene ready` with zero errors. |

The graphical scene was launched from the command line and its rendered frame inspected. The editor F5 workflow was also verified. Generated `.godot/` files remain ignored. The generated `scripts/main.gd.uid` is committed as source metadata.

## Files

```text
client/
  project.godot
  scenes/main.tscn
  scripts/main.gd
  scripts/main.gd.uid
  README.md
```

**Scope boundary:** No movement, tilemaps, encounters, battles, networking or external Pokémon assets are part of PN-001.

**Next:** Project owner reviews PN-001 in PR #1. PN-002 (test-zone movement and collision) remains outside this task.
