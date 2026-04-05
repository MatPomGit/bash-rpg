#!/usr/bin/env bash
# levels/level_03.sh – The Temple of Text
# Teaches: grep, find, head, tail, wc, sort, uniq, cut

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_03_intro() {
    ui_clear
    ui_header "Chapter 3 – The Temple of Text"
    ui_story "The Ancient Temple of Text rises before you, carved from pure obsidian."
    ui_story "Millions of lines of text flow across its walls like waterfalls."
    ui_story "A scholar in robes bows as you approach."
    echo
    ui_dialog "Scholar Regex" \
        "Ah, a brave soul seeks the wisdom of text processing! The temple guardians \
wield the power of words – they can hide patterns, scramble orders, and \
drown you in unorganized data. To defeat them, you must master 'grep' \
to search, 'find' to locate, 'head' and 'tail' to sample, 'wc' to count, \
'sort' to order, and 'uniq' to deduplicate. May your patterns be strong!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Three ancient guardians defend the Temple of Text."
    ui_story "Face them to unlock the Secrets of Pattern Matching."
    echo
    press_enter
}

level_03_encounter1() {
    ui_story "A Pattern Specter rises from the glowing text on the floor..."
    ui_story "It hides inside logs and mocks those who cannot find it."
    sleep 1

    enemy_set \
        "Pattern Specter" \
        60 \
        12 \
        "text" \
        "A ghost made entirely of regular expressions. It shifts its appearance to confuse pattern-matchers." \
        "The specter's pattern is broken. It dissolves into plain ASCII." \
        60 \
        20 \
        ""

    combat_start
}

level_03_encounter2() {
    ui_story "Stone doors grind open. A Search Demon charges forward!"
    ui_story "It has lost a file somewhere in the /usr hierarchy and is furious."
    sleep 1

    enemy_set \
        "Search Demon" \
        80 \
        16 \
        "text" \
        "A demon perpetually searching for a lost config file. Its confusion makes it violent." \
        "You help the demon find its config file with 'find'. It calms down and wanders away." \
        75 \
        25 \
        "Health Potion"

    combat_start
}

level_03_encounter3() {
    ui_story "The temple floor shakes. The Word Count Wyvern drops from the ceiling!"
    ui_story "Its scales are made of sorted lines and its breath smells of 'wc -l'."
    sleep 1

    enemy_set \
        "Word Count Wyvern" \
        110 \
        20 \
        "text" \
        "A fearsome dragon whose power grows with every line of text it consumes. Only those who can count, sort, and deduplicate can tame it." \
        "The Wyvern is pacified by your mastery of text tools. It bows and presents the Crystal of grep!" \
        110 \
        35 \
        "Crystal of grep"

    combat_start
}

level_03_complete() {
    ui_clear
    ui_header "Temple of Text – Cleared!"
    ui_story "The temple walls go still. Order has been restored to the text streams."
    echo
    ui_dialog "Scholar Regex" \
        "Magnificent! The temple is at peace. You now command the most powerful \
text tools in the terminal arsenal. 'grep' to find patterns, 'find' to \
locate files, 'head'/'tail' for quick sampling, 'wc' for counting, \
'sort' for ordering, and 'uniq' for deduplication. These tools, \
combined with pipes, will make you unstoppable!" \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Commands Mastered ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bgrep%b  – search for patterns in text\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfind%b  – locate files in the filesystem\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bhead%b  – display first N lines of a file\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %btail%b  – display last N lines of a file\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bwc%b    – count lines, words, characters\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bsort%b  – sort lines of text\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %buniq%b  – remove duplicate lines\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcut%b   – extract columns from text\n" "${COLOR_COMMAND}" "${RESET}"
    echo
    press_enter

    CURRENT_LEVEL=4
    save_game
}

run_level_03() {
    level_03_intro
    level_03_encounter1 || return 1
    if ! player_is_dead; then
        level_03_encounter2 || true
    fi
    if ! player_is_dead; then
        level_03_encounter3 || true
    fi
    if ! player_is_dead; then
        level_03_complete
    fi
}
