# PokeNavis Godot Client

**Status:** PN-001 starter scene on a feature branch, awaiting runtime smoke tests and review. This is not a playable RPG yet.

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

**Test evidence:** The bootstrap author could not run Godot because no Godot executable was available. These are instructions for Codex or a local contributor and **must not** be reported as passed until actually executed.

## Files

```text
client/
  project.godot
  scenes/main.tscn
  scripts/main.gd
  README.md
```

**Scope boundary:** No movement, tilemaps, encounters, battles, networking or external Pokémon assets are part of PN-001.

**Next:** Codex should run and document these tests on the open PN-001 pull request, fix any errors and request owner review. PN-002 (test-zone movement and collision) begins only after the bootstrap is validated.
