#!/usr/bin/env bash
# levels/level_02.sh – The Cave of Files
# Teaches: touch, cat, cp, mv, rm, ln, file, man

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_02_intro() {
    ui_clear
    ui_header "Chapter 2 – The Cave of Files"
    ui_story "Beyond the forest lies the entrance to the Cave of Files."
    ui_story "The cave walls are lined with crystals shaped like file icons."
    ui_story "A mysterious archivist sits by the entrance, polishing a scroll."
    echo
    ui_dialog "Archivist Vellum" \
        "Welcome, navigator! The cave ahead is ruled by creatures that corrupt, \
hide, and destroy files. To survive, you must master file operations – \
creating files with 'touch', reading with 'cat', copying with 'cp', \
moving with 'mv', and the feared 'rm' which destroys without mercy. \
Tread carefully – unlike the surface world, there is no undo here!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Three guardians protect the Cave of Files."
    ui_story "Defeat them to claim the Tome of File Mastery."
    echo
    press_enter
}

level_02_encounter1() {
    ui_story "A File Phantom drifts towards you, carrying a blank file..."
    ui_story "It keeps whispering 'how do you CREATE a file?'"
    sleep 1

    enemy_set \
        "File Phantom" \
        50 \
        10 \
        "files" \
        "A translucent spirit holding blank scrolls. It cannot create files and screams at empty directories." \
        "The phantom finally manifests a file and fades away, satisfied." \
        40 \
        15 \
        ""

    combat_start
}

level_02_encounter2() {
    ui_story "Deep in the cave, a Corrupted Daemon blocks the path."
    ui_story "It has scrambled all the filenames and is frantically moving them around."
    sleep 1

    enemy_set \
        "Corrupted Daemon" \
        70 \
        14 \
        "files" \
        "A daemon born from a failed file system check. It moves files to random locations and laughs maniacally." \
        "The daemon is forced to restore order, placing every file in its rightful place." \
        60 \
        20 \
        "Health Potion"

    combat_start
}

level_02_encounter3() {
    ui_story "The cave shakes. The Archive Elemental awakens from its slumber!"
    ui_story "This ancient being is made entirely from compressed archives and corrupted data."
    sleep 1

    enemy_set \
        "Archive Elemental" \
        100 \
        18 \
        "files" \
        "A towering creature of packed archives and symbolic links. It guards the Tome of File Mastery with brutal file-deletion attacks." \
        "The Elemental crumbles into a pile of well-organised files. The Tome of File Mastery is yours!" \
        100 \
        30 \
        "Tome of File Mastery"

    combat_start
}

level_02_complete() {
    ui_clear
    ui_header "Cave of Files – Cleared!"
    ui_story "The cave is now bathed in a warm, organised glow."
    echo
    ui_dialog "Archivist Vellum" \
        "Extraordinary skill! You have tamed the Cave of Files. Always remember \
the power you now hold: 'touch' to create, 'cat' to read, 'cp' to copy, \
'mv' to move or rename, and 'rm' to remove. Use 'rm' wisely – \
with great power comes great responsibility. There is no trash can in Bash!" \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Commands Mastered ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %btouch%b  – create file / update timestamp\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcat%b    – display file contents\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcp%b     – copy files/directories\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bmv%b     – move or rename files\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %brm%b     – remove files (permanent!)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bln -s%b  – create symbolic link\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfile%b   – identify file type\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bman%b    – read command manual\n" "${COLOR_COMMAND}" "${RESET}"
    echo
    press_enter

    CURRENT_LEVEL=3
    save_game
}

run_level_02() {
    level_02_intro
    level_02_encounter1 || return 1
    if ! player_is_dead; then
        level_02_encounter2 || true
    fi
    if ! player_is_dead; then
        level_02_encounter3 || true
    fi
    if ! player_is_dead; then
        level_02_complete
    fi
}
