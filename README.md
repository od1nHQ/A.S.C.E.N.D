# Ascent

**A.S.C.E.N.D** is a portable Windows GUI tool for calculating and testing TerraFirmaCraft-style anvil working sequences.

The program helps you work with anvil target positions, required final moves, manual move input, and saved item templates.

![Main window](docs/images/main-window.png)

## Features

- Calculator mode for finding a valid forging sequence.
- Manual mode for testing moves step by step.
- Movable start and target markers.
- Final move slots with visual matching.
- Manual history slots showing the last three moves.
- Template system:
  - load saved templates;
  - save new templates;
  - delete templates;
  - search templates;
  - assign item icons.
- Portable Windows build. No installer required.

## Download

The easiest way to use Ascent is to download the portable release.

1. Open the GitHub repository page.
2. Find **Releases** on the right side of the page.
3. Open the latest release.
4. Download the portable archive:

   ```text
   A.S.C.E.N.D_v0.2.0_portable.zip
   ```

5. Extract the ZIP archive.
6. Open the extracted folder.
7. Run:

   ```text
   A.S.C.E.N.D.exe
   ```

Do **not** run the program directly from inside the ZIP archive. Extract the whole folder first, because the executable needs the included Qt DLLs and plugin folders.

## Windows SmartScreen warning

The current Windows build is unsigned.

Windows SmartScreen may show an "Unknown publisher" warning because the executable does not have a paid code-signing certificate yet.

Recommended safety checks:
- download only from the official GitHub Releases page;
- extract the full ZIP archive before running;
- inspect the source code if needed;
- do not run copies downloaded from third-party mirrors.

If you trust the official release, you can choose "More info → Run anyway".

## Screenshots

### Main window

![Main window](docs/images/main-window.png)

### Template panel

![Template panel](docs/images/template-panel.png)

### Save template panel

![Save template panel](docs/images/save-template.png)

### Sequence result

![Sequence result](docs/images/sequence-result.png)

## Basic usage

### Calculator mode

Calculator mode is used when you want the program to find a valid sequence automatically.

1. Select the required final moves in the three upper slots.
2. Move the red marker to the target position.
3. Optionally move the green marker if you want a custom start position.
4. Press the sequence button.
5. The program will show the calculated move sequence.

### Manual mode

Manual mode is used when you want to test moves yourself.

1. Switch to manual mode.
2. Press the move buttons manually.
3. The green marker moves according to your input.
4. The lower slots show the last three moves.
5. If a move matches the selected final moves, the matching slot is highlighted.

## Templates

Templates save commonly used forging setups.

A template stores:

- item name;
- material;
- item icon;
- target value;
- required final moves.

### Load a template

1. Press the template button.
2. Search for a saved template if needed.
3. Click the template.
4. The program automatically applies:
   - the item icon;
   - the target position;
   - the required final moves.

When a template is selected, the green start marker is reset to `0` and the program switches back to calculator mode. You can still move the green marker manually afterward if you need a custom start position.

### Save a template

1. Set the target position with the red marker.
2. Select the required final moves in the upper slots.
3. Open the template panel.
4. Press **SAVE**.
5. Select an item icon.
6. Edit the template name if needed.
7. Save the template.

The new template will appear in the template list.

### Delete a template

1. Open the template panel.
2. Find the template in the list.
3. Press **DEL** next to the template.

## Template storage

Saved templates are stored in:

```text
%APPDATA%\A.S.C.E.N.D\templates.json
```

On Windows this usually means:

```text
C:\Users\<YourUserName>\AppData\Roaming\A.S.C.E.N.D\templates.json
```

This file contains user-created templates. It is separate from the program files.

## Build from source

### Requirements

- Qt 6
- Qt Creator
- CMake
- MinGW 64-bit toolchain

### Build steps

1. Clone the repository.
2. Open the project in Qt Creator using:

   ```text
   CMakeLists.txt
   ```

3. Select a Qt MinGW kit, for example:

   ```text
   Desktop Qt 6.x.x MinGW 64-bit
   ```

4. Choose a build configuration:
   - `Debug` for development;
   - `Release` for release builds.

5. Build the project.

## Repository structure

```text
ASCEND_GUI/
├── assets/
│   ├── moves/
│   ├── templates/
│   │   └── items/
│   └── ui/
├── core/
├── docs/
│   └── images/
├── Main.qml
├── main.cpp
├── SolverBridge.h
├── SolverBridge.cpp
├── TemplateBridge.h
├── TemplateBridge.cpp
├── TemplateData.h
├── TemplateStorage.h
├── TemplateStorage.cpp
└── CMakeLists.txt
```

## Important note

Ascent is a standalone planner and practice tool.

It does not modify Minecraft, does not inject into the game, does not automate clicks, does not read game memory, and does not interact with servers.

It is intended for learning, planning, and practicing TerraFirmaCraft-style anvil working.

## Notes on TerraFirmaCraft assets

Some item/icon assets are derived from or based on TerraFirmaCraft resources.

TerraFirmaCraft is developed by its respective authors.
This project is not affiliated with, endorsed by, or maintained by the TerraFirmaCraft team.

Third-party assets remain under their original licenses and ownership.
See `ATTRIBUTION.md` for details.

## License

This project is licensed under the European Union Public Licence v1.2.

See the [`LICENSE`](LICENSE) file for details.
