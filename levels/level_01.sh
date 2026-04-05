#!/usr/bin/env bash
# levels/level_01.sh – The Forest of Navigation
# Teaches: ls, pwd, cd, mkdir, rmdir

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_01_intro() {
    ui_clear
    ui_header "Chapter 1 – The Forest of Navigation"
    ui_story "You stand at the edge of the Enchanted Forest of Bash."
    ui_story "Ancient trees tower above you, their bark carved with cryptic symbols."
    ui_story "A wise old hermit blocks the path."
    echo
    ui_dialog "Hermit Graybeard" \
        "Halt, traveller! This forest holds many dangers for those who do not know \
the ways of the terminal. The creatures here guard the secrets of NAVIGATION – \
the art of moving through directories, listing their contents, and building \
new paths. Learn well, and the forest shall yield to your will." \
        "${BOLD_WHITE}"
    press_enter

    ui_story "You must defeat three guardians to cross the Forest of Navigation."
    ui_story "Each battle tests your knowledge of Bash navigation commands."
    echo
    press_enter
}

level_01_encounter1() {
    ui_story "A Lost Goblin stumbles out of the undergrowth..."
    ui_story "Its pockets are full of crumpled directory listings it cannot read."
    sleep 1

    enemy_set \
        "Lost Goblin" \
        40 \
        8 \
        "navigation" \
        "A bewildered goblin clutching a broken compass. It confuses 'ls' with 'cd' constantly." \
        "The goblin collapses in confusion, dropping a crumpled map." \
        30 \
        10 \
        "Health Potion"

    combat_start
}

level_01_encounter2() {
    ui_story "You hear heavy footsteps... a Confused Troll lumbers onto the path."
    ui_story "It keeps typing 'whereami' and screaming when nothing happens."
    sleep 1

    enemy_set \
        "Confused Troll" \
        60 \
        12 \
        "navigation" \
        "A massive troll frantically banging on a stone keyboard. It knows directories exist but has no idea how to navigate them." \
        "The troll finally understands 'pwd' and wanders off peacefully." \
        50 \
        15 \
        ""

    combat_start
}

level_01_encounter3() {
    ui_story "The trees darken. A Navigation Wraith materialises from the shadows..."
    ui_story "Its form is made of tangled file paths and lost symlinks."
    sleep 1

    enemy_set \
        "Navigation Wraith" \
        80 \
        15 \
        "navigation" \
        "An ancient spirit twisted from forgotten file paths. It feeds on the confusion of those who cannot navigate the terminal." \
        "The Wraith dissolves into wisps of light as you recite the navigation commands. The path through the forest is clear!" \
        80 \
        25 \
        "Compass of pwd"

    combat_start
}

level_01_complete() {
    ui_clear
    ui_header "Forest of Navigation – Cleared!"
    ui_story "Sunlight floods the clearing as the last guardian falls."
    echo
    ui_dialog "Hermit Graybeard" \
        "Remarkable! You have mastered the art of navigation. Remember: \
'ls' to see, 'pwd' to know where you are, 'cd' to move, \
and 'mkdir'/'rmdir' to shape the world around you. These skills \
will serve you in every corner of the terminal." \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Commands Mastered ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bls%b    – list directory contents\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bpwd%b   – print working directory\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcd%b    – change directory\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bmkdir%b – make a new directory\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %brmdir%b – remove an empty directory\n" "${COLOR_COMMAND}" "${RESET}"
    echo
    press_enter

    CURRENT_LEVEL=2
    save_game
}

run_level_01() {
    level_01_intro
    level_01_encounter1 || return 1
    if ! player_is_dead; then
        level_01_encounter2 || true
    fi
    if ! player_is_dead; then
        level_01_encounter3 || true
    fi
    if ! player_is_dead; then
        level_01_complete
    fi
}
