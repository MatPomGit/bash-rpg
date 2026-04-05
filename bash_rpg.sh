#!/usr/bin/env bash
# bash_rpg.sh – Main entry point for Bash RPG: The Terminal Chronicles
# Run: bash bash_rpg.sh

set -euo pipefail

GAME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all libraries
source "${GAME_DIR}/lib/colors.sh"
source "${GAME_DIR}/lib/ui.sh"
source "${GAME_DIR}/lib/player.sh"
source "${GAME_DIR}/lib/challenges.sh"
source "${GAME_DIR}/lib/combat.sh"
source "${GAME_DIR}/lib/save_load.sh"

# Source all levels
source "${GAME_DIR}/levels/level_01.sh"
source "${GAME_DIR}/levels/level_02.sh"
source "${GAME_DIR}/levels/level_03.sh"
source "${GAME_DIR}/levels/level_04.sh"
source "${GAME_DIR}/levels/level_05.sh"

# ──────────────────────────────────────────────────────────────────────────────
# New game
# ──────────────────────────────────────────────────────────────────────────────

new_game() {
    ui_clear
    ui_header "New Game"
    ui_story "Welcome, brave adventurer!"
    ui_story "The Land of Bash calls for a hero who can master the terminal."
    echo
    ui_prompt "Enter your hero's name: "
    local name
    read -r name
    [[ -z "$name" ]] && name="Hero"
    player_create "$name"
    echo
    printf "  %bWelcome, %s!%b Your adventure begins now.\n\n" "${COLOR_SUCCESS}" "$name" "${RESET}"
    sleep 1

    # Prologue
    ui_clear
    ui_header "Prologue"
    ui_story "Long ago, the Kingdom of Terminal thrived under the rule of Master Bourne."
    ui_story "The five pillars of the realm – Navigation, Files, Text, Pipes, and Scripting –"
    ui_story "kept order and prosperity throughout the land."
    echo
    ui_story "But a great darkness has fallen. Creatures of confusion and chaos have"
    ui_story "overrun the land, corrupting directories, scrambling files, and breaking"
    ui_story "pipelines everywhere."
    echo
    ui_story "You are the Chosen One – destined to master the ancient arts of Bash"
    ui_story "and restore harmony to the terminal kingdom."
    echo
    ui_story "Your journey begins at the edge of the Enchanted Forest..."
    echo
    press_enter

    start_adventure
}

# ──────────────────────────────────────────────────────────────────────────────
# Continue game
# ──────────────────────────────────────────────────────────────────────────────

continue_game() {
    if load_game; then
        printf "\n  %bWelcome back, %s! (Level %d)%b\n\n" \
            "${COLOR_SUCCESS}" "$PLAYER_NAME" "$PLAYER_LEVEL" "${RESET}"
        sleep 1
        start_adventure
    else
        ui_error "No save file found."
        press_enter
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Main adventure loop – routes player to the correct level
# ──────────────────────────────────────────────────────────────────────────────

start_adventure() {
    while true; do
        if player_is_dead; then
            game_over_menu
            return
        fi

        case "$CURRENT_LEVEL" in
            1) run_level_01 ;;
            2) run_level_02 ;;
            3) run_level_03 ;;
            4) run_level_04 ;;
            5) run_level_05 ;;
            6|*)
                # Game complete
                game_complete
                return
                ;;
        esac

        # Between levels: check player status
        if player_is_dead; then
            game_over_menu
            return
        fi

        ui_player_status
        press_enter
    done
}

# ──────────────────────────────────────────────────────────────────────────────
# Menus
# ──────────────────────────────────────────────────────────────────────────────

main_menu() {
    while true; do
        ui_title_screen
        local options=("New Game" "Continue" "How to Play" "Quit")
        if has_save; then
            options[1]="Continue  [save found]"
        fi

        ui_menu "Main Menu" "${options[@]}"
        ui_prompt "Choice: "
        local choice
        read -r choice

        case "$choice" in
            1) new_game; return ;;
            2) continue_game ;;
            3) show_help ;;
            4|q|Q|quit|exit) farewell; exit 0 ;;
            *) ui_error "Please enter 1-4." ;;
        esac
    done
}

game_over_menu() {
    ui_clear
    ui_hr "═"
    ui_center "${COLOR_ERROR}  G A M E   O V E R  ${RESET}"
    ui_hr "═"
    echo
    ui_story "You have fallen in battle..."
    ui_story "But every defeat is a lesson. Rise again and master the terminal!"
    echo

    ui_menu "What will you do?" "Restart from save" "New Game" "Return to Main Menu"
    ui_prompt "Choice: "
    local choice
    read -r choice

    case "$choice" in
        1)
            if load_game; then
                PLAYER_HP=$(( PLAYER_MAX_HP / 2 ))  # Start with half HP after revival
                start_adventure
            else
                new_game
            fi
            ;;
        2) new_game ;;
        3|*) main_menu ;;
    esac
}

game_complete() {
    ui_clear
    ui_hr "═"
    ui_center "${BOLD_YELLOW}  ★  BASH WARRIOR  ★  ${RESET}"
    ui_center "${BOLD_WHITE}  The Terminal Chronicles  ${RESET}"
    ui_hr "═"
    echo
    ui_story "You have completed all five chapters of the Bash RPG!"
    ui_story ""
    ui_story "By defeating the guardians of Navigation, Files, Text, Pipes, and Scripting,"
    ui_story "you have restored peace to the Kingdom of Terminal."
    echo
    player_show_stats
    echo
    ui_story "The skills you learned on this journey are REAL Bash commands."
    ui_story "Try them in your own terminal and see the power you now hold!"
    echo
    press_enter
    main_menu
}

show_help() {
    ui_clear
    ui_header "How to Play"
    ui_story "Bash RPG is an educational RPG that teaches you Bash terminal commands."
    echo
    printf "  %bCOMBAT%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  During battle, you answer Bash command questions to attack enemies.\n"
    printf "  Correct answers deal damage; wrong answers mean you miss a turn.\n"
    printf "  The enemy attacks every turn regardless.\n"
    echo
    printf "  %bCOMMANDS TAUGHT%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  Chapter 1 – Navigation : ls, pwd, cd, mkdir, rmdir\n"
    printf "  Chapter 2 – Files      : touch, cat, cp, mv, rm, ln, file\n"
    printf "  Chapter 3 – Text       : grep, find, head, tail, wc, sort, uniq, cut\n"
    printf "  Chapter 4 – Pipes      : |  >  >>  <  2>  tee  xargs\n"
    printf "  Chapter 5 – Scripting  : variables, if, for, while, functions\n"
    echo
    printf "  %bITEMS%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  Health Potion         – restore 50 HP\n"
    printf "  Elixir of Knowledge   – skip a challenge (reveals answer)\n"
    echo
    printf "  %bTIPS%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  • Type just the command name (e.g. 'ls') or the full answer.\n"
    printf "  • Answers are case-insensitive.\n"
    printf "  • Read the explanations after battles – they are educational!\n"
    printf "  • Save automatically after each chapter.\n"
    echo
    press_enter
}

farewell() {
    ui_clear
    echo
    ui_center "${BOLD_CYAN}Thank you for playing Bash RPG: The Terminal Chronicles!${RESET}"
    echo
    ui_center "${DIM}Remember: the real treasure was the Bash commands we learned along the way.${RESET}"
    echo
}

# ──────────────────────────────────────────────────────────────────────────────
# Entry point
# ──────────────────────────────────────────────────────────────────────────────

# Verify bash version >= 4 (needed for nameref / associative arrays)
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
    echo "Error: Bash 4.0 or higher is required to play Bash RPG." >&2
    echo "Your version: ${BASH_VERSION}" >&2
    exit 1
fi

main_menu
