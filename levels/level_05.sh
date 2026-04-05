#!/usr/bin/env bash
# levels/level_05.sh – The Wizard's Tower
# Teaches: variables, if, for, while, functions, $?, shebang

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_05_intro() {
    ui_clear
    ui_header "Chapter 5 – The Wizard's Tower"
    ui_story "At last, the Wizard's Tower of Scripting looms before you."
    ui_story "Lightning strikes its spire as variables crackle in the air."
    ui_story "The Grand Wizard Bourne appears in a burst of script fragments."
    echo
    ui_dialog "Grand Wizard Bourne" \
        "So you have come to learn the highest art – Bash Scripting! Variables, \
conditions, loops, and functions are the spells that transform a mere \
command-typer into a true shell wizard. My tower's guardians test only \
those worthy of this knowledge. Survive them, and you shall earn the \
title of Bash Warrior. Fail, and you shall remain a mere mortal forever." \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Three scripting guardians stand between you and the title of Bash Warrior."
    ui_story "This is your ultimate test!"
    echo
    press_enter
}

level_05_encounter1() {
    ui_story "A Variable Vampire swoops down from the rafters!"
    ui_story "It drains the values from variables, leaving only empty strings."
    sleep 1

    enemy_set \
        "Variable Vampire" \
        80 \
        16 \
        "scripting" \
        "A pale creature that sucks the values out of variables. It cannot stand proper variable assignment and expansion." \
        "The vampire's coffin of empty variables is smashed. Variables flow freely once more!" \
        100 \
        30 \
        ""

    combat_start
}

level_05_encounter2() {
    ui_story "The staircase spirals upward. A Loop Lich blocks the next floor!"
    ui_story "It is trapped in an infinite loop and trying to drag you in."
    sleep 1

    enemy_set \
        "Loop Lich" \
        100 \
        19 \
        "scripting" \
        "An undead mage trapped in an infinite loop. It has been running the same code for centuries and wants company." \
        "You break the lich's infinite loop with a well-placed 'break' statement. It finally rests." \
        120 \
        35 \
        "Health Potion"

    combat_start
}

level_05_encounter3() {
    ui_story "The tower top. The Condition Construct awakens – a golem of pure if/else!"
    ui_story "Its body is made of boolean logic and its eyes burn with comparison operators."
    sleep 1

    enemy_set \
        "Condition Construct" \
        150 \
        25 \
        "scripting" \
        "A fearsome automaton built from conditional statements. Every attack is a branching decision tree. Only a scripting master can untangle its logic." \
        "The Construct's final condition evaluates to TRUE: you are worthy. It bows and presents the Staff of Scripting!" \
        160 \
        50 \
        "Staff of Scripting"

    combat_start
}

level_05_complete() {
    ui_clear
    ui_header "The Wizard's Tower – Conquered!"
    ui_story "The tower glows with golden light. You have reached the pinnacle!"
    echo
    ui_dialog "Grand Wizard Bourne" \
        "INCREDIBLE! You have defeated all my guardians and proven your worth. \
You now possess the knowledge of variables, conditions, loops, and \
functions – the four pillars of Bash scripting. With these powers \
combined with your navigation, file, text, and pipe mastery, \
you are truly a BASH WARRIOR! The kingdom of the terminal is safe!" \
        "${BOLD_YELLOW}"

    echo
    printf "  %b━━━ Scripting Mastered ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bvar=value%b  – assign a variable (no spaces!)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b\$var%b       – expand a variable\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bif/fi%b      – conditional branching\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfor/done%b   – iterate over a list\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bwhile/done%b – loop while condition is true\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfunc() {}%b  – define a function\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b\$?%b         – exit status of last command\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bread%b       – read user input\n" "${COLOR_COMMAND}" "${RESET}"
    echo

    ui_hr "★"
    ui_center "${BOLD_YELLOW}🏆  Congratulations, ${PLAYER_NAME}!  🏆${RESET}"
    ui_center "${BOLD_WHITE}You are now a certified BASH WARRIOR!${RESET}"
    ui_hr "★"
    echo
    press_enter

    CURRENT_LEVEL=6
    save_game
}

run_level_05() {
    level_05_intro
    level_05_encounter1 || return 1
    if ! player_is_dead; then
        level_05_encounter2 || true
    fi
    if ! player_is_dead; then
        level_05_encounter3 || true
    fi
    if ! player_is_dead; then
        level_05_complete
    fi
}
