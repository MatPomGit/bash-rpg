#!/usr/bin/env bash
# levels/level_04.sh – The River of Pipes
# Teaches: |, >, >>, <, 2>, tee, xargs, /dev/null

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_04_intro() {
    ui_clear
    ui_header "Chapter 4 – The River of Pipes"
    ui_story "You arrive at the banks of the legendary River of Pipes."
    ui_story "Data flows like water, redirected by mysterious symbols carved into stone."
    ui_story "A ferryman poles a raft of connected pipes toward you."
    echo
    ui_dialog "Ferryman Redirect" \
        "To cross the River of Pipes, you must understand the flow of data. \
The pipe symbol '|' sends output from one command to another. \
The chevrons '>' and '>>' redirect to files. '<' pulls from files. \
'2>' captures errors. And 'tee' splits the flow in two. \
Master redirection and you master the very lifeblood of the shell!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Three river monsters guard the crossing."
    ui_story "Only a master of pipes and redirection may pass."
    echo
    press_enter
}

level_04_encounter1() {
    ui_story "A Pipe Drake erupts from the water, coiling around a broken pipeline!"
    ui_story "Its tail is a pipe symbol and it breathes unconnected commands."
    sleep 1

    enemy_set \
        "Pipe Drake" \
        70 \
        14 \
        "pipes" \
        "A serpentine dragon whose power comes from broken pipelines. It cannot stand connected commands." \
        "The Pipe Drake untangles itself and slithers back into the river, humbled." \
        75 \
        25 \
        ""

    combat_start
}

level_04_encounter2() {
    ui_story "The current surges! A Redirect Serpent surfaces, hissing file names!"
    ui_story "It overwrites files indiscriminately with its '>' fang."
    sleep 1

    enemy_set \
        "Redirect Serpent" \
        90 \
        17 \
        "pipes" \
        "A cunning serpent that overwrites important files with a flick of its '>' fang. It fears the '>>' operator above all." \
        "The serpent is forced to append rather than overwrite, and retreats in shame." \
        90 \
        30 \
        "Health Potion"

    combat_start
}

level_04_encounter3() {
    ui_story "The river goes dark. The Stream Kraken rises from the depths!"
    ui_story "Eight tentacles, each a different file descriptor, thrash the water."
    sleep 1

    enemy_set \
        "Stream Kraken" \
        130 \
        22 \
        "pipes" \
        "The ancient Kraken of stderr and stdout. It tangles all your pipes and redirects your errors to /dev/null. A fearsome foe." \
        "The Kraken's file descriptors are sorted at last. It sinks back with a satisfied gurgle, leaving the Trident of Pipes!" \
        130 \
        40 \
        "Trident of Pipes"

    combat_start
}

level_04_complete() {
    ui_clear
    ui_header "River of Pipes – Crossed!"
    ui_story "The river calms. Data flows smoothly through perfectly connected pipes."
    echo
    ui_dialog "Ferryman Redirect" \
        "You have done it! The river is tamed. With pipes and redirections, \
you can chain any number of commands, filter and transform data streams, \
save output to files, and silence noise with /dev/null. \
These are the fundamental building blocks of shell scripting mastery. \
The Wizard's Tower awaits you on the far shore!" \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Operators Mastered ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %b|%b      – pipe: send stdout to next command's stdin\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b>%b      – redirect stdout to file (overwrite)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b>>%b     – redirect stdout to file (append)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b<%b      – redirect file to stdin\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b2>%b     – redirect stderr to file\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b2>&1%b   – redirect stderr to stdout\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %btee%b    – split output: display AND save\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bxargs%b  – build command args from stdin lines\n" "${COLOR_COMMAND}" "${RESET}"
    echo
    press_enter

    CURRENT_LEVEL=5
    save_game
}

run_level_04() {
    level_04_intro
    level_04_encounter1 || return 1
    if ! player_is_dead; then
        level_04_encounter2 || true
    fi
    if ! player_is_dead; then
        level_04_encounter3 || true
    fi
    if ! player_is_dead; then
        level_04_complete
    fi
}
