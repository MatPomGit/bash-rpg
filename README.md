# Bash RPG: The Terminal Chronicles

> An interactive terminal RPG game that teaches you Bash console commands through combat, exploration, and adventure.

## Overview

You are the **Bash Warrior** – destined to save the Kingdom of Terminal from creatures of chaos and confusion. Traverse five distinct regions, each guarded by monsters that test your knowledge of real Bash commands. Defeat them by answering correctly, level up your hero, and restore order to the terminal world!

## Features

- 🗡️ **Turn-based combat** – answer Bash command questions to attack enemies
- 📈 **RPG progression** – XP, levels, HP, attack/defense stats
- 🎒 **Inventory system** – collect potions and magical items
- 💾 **Auto-save** – progress saved to `~/.bash_rpg/save.dat` after each chapter
- 🎨 **Colorful terminal UI** – ANSI colors, ASCII art, status bars
- 📚 **50+ Bash challenges** across 5 categories

## Bash Commands Taught

| Chapter | Region                  | Commands                                      |
|---------|-------------------------|-----------------------------------------------|
| 1       | Forest of Navigation    | `ls`, `pwd`, `cd`, `mkdir`, `rmdir`           |
| 2       | Cave of Files           | `touch`, `cat`, `cp`, `mv`, `rm`, `ln`, `file` |
| 3       | Temple of Text          | `grep`, `find`, `head`, `tail`, `wc`, `sort`, `uniq`, `cut` |
| 4       | River of Pipes          | `\|`, `>`, `>>`, `<`, `2>`, `tee`, `xargs`   |
| 5       | Wizard's Tower          | variables, `if`, `for`, `while`, functions, `$?` |

## Requirements

- **Bash 4.0+** (macOS users: `brew install bash`)
- A terminal with ANSI color support (any modern terminal)

## How to Run

### Terminal (Linux / macOS / Windows with Git Bash)

```bash
git clone https://github.com/MatPomGit/bash-rpg.git
cd bash-rpg
bash bash_rpg.sh
```

### Double-click launcher

| System  | File            | What you need |
|---------|-----------------|---------------|
| Windows | `start.bat`     | [Git for Windows](https://gitforwindows.org/), [WSL](https://learn.microsoft.com/windows/wsl/install), [Cygwin](https://www.cygwin.com/), or [MSYS2](https://www.msys2.org/) |
| macOS   | `start.command` | Bash 4+ (`brew install bash`) |

**Windows** – double-click `start.bat`. It searches for Git Bash, then WSL, then any `bash` on your PATH. If none is found, it prints installation instructions.

**macOS** – double-click `start.command` in Finder. Right-click → *Open* the first time to bypass the Gatekeeper warning.

## Project Structure

```
bash_rpg.sh          ← main entry point
lib/
  colors.sh          ← ANSI color definitions
  ui.sh              ← UI helpers (headers, bars, dialogs)
  player.sh          ← player state management
  challenges.sh      ← Bash-command challenge database
  combat.sh          ← turn-based combat engine
  save_load.sh       ← save/load game state
levels/
  level_01.sh        ← Forest of Navigation
  level_02.sh        ← Cave of Files
  level_03.sh        ← Temple of Text
  level_04.sh        ← River of Pipes
  level_05.sh        ← Wizard's Tower
tests/
  run_tests.sh       ← test runner
  test_player.sh     ← player unit tests
  test_combat.sh     ← combat unit tests
  test_challenges.sh ← challenge database tests
```

## Running Tests

```bash
bash tests/run_tests.sh
```

## How to Play

1. **Start the game** and create your hero.
2. In each battle, choose **[1] Attack** to face a Bash challenge.
3. Type the correct Bash command or answer to deal damage.
4. Wrong answers miss your turn – the enemy still attacks!
5. Use **Health Potions** from your inventory to survive tough fights.
6. After each chapter, read the **command summaries** to reinforce learning.
7. Your progress is **auto-saved** – you can quit and continue later.

### Combat Tips

- Answers are **case-insensitive** – `ls`, `LS`, and `Ls` all work.
- You can type just the command name (e.g., `grep`) or the full usage.
- After each challenge, an **explanation** is shown – read it!
- If you die, you can restart from your last save with half HP.

## License

[MIT License](LICENSE)
