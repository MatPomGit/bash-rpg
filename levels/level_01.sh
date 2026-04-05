#!/usr/bin/env bash
# levels/level_01.sh – Las Nawigacji
# Uczy: ls, pwd, cd, mkdir, rmdir

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_01_intro() {
    ui_clear
    ui_header "Rozdział 1 – Las Nawigacji"
    ui_story "Stoisz na skraju Zaczarowanego Lasu Bash."
    ui_story "Stare drzewa wznoszą się ku niebu, ich kora pokryta tajemniczymi symbolami."
    ui_story "Stary pustelnik blokuje ścieżkę."
    echo
    ui_dialog "Pustelnik Siwobrodek" \
        "Stój, wędrowcze! Ten las kryje wiele niebezpieczeństw dla tych, którzy \
nie znają praw terminala. Stwory tutaj strzegą sekretów NAWIGACJI – \
sztuki poruszania się po katalogach, listowania ich zawartości \
i tworzenia nowych ścieżek. Ucz się dobrze, a las ustąpi twojej woli." \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Musisz pokonać trzech strażników, by przekroczyć Las Nawigacji."
    ui_story "Każda walka sprawdza twoją znajomość poleceń nawigacyjnych Bash."
    echo
    press_enter
}

level_01_encounter1() {
    ui_story "Zagubiony Goblin wyłania się z zarośli..."
    ui_story "Jego kieszenie pełne są pomięty wydruków katalogów, których nie potrafi czytać."
    sleep 1

    enemy_set \
        "Zagubiony Goblin" \
        40 \
        8 \
        "navigation" \
        "Zdezorientowany goblin ściskający zepsuty kompas. Ciągle myli 'ls' z 'cd'." \
        "Goblin pada ze zdezorientowania, upuszczając pomięty plan." \
        30 \
        10 \
        "Mikstura zdrowia"

    combat_start
}

level_01_encounter2() {
    ui_story "Słyszysz ciężkie kroki... na ścieżkę wychodzi Zdezorientowany Troll."
    ui_story "Ciągle wpisuje 'gdziejestem' i ryczy, gdy nic się nie dzieje."
    sleep 1

    enemy_set \
        "Zdezorientowany Troll" \
        60 \
        12 \
        "navigation" \
        "Ogromny troll wściekle walący w kamienny klawiaturę. Wie, że katalogi istnieją, ale nie ma pojęcia jak nimi nawigować." \
        "Troll w końcu rozumie 'pwd' i spokojnie odchodzi." \
        50 \
        15 \
        ""

    combat_start
}

level_01_encounter3() {
    ui_story "Drzewa ciemnieją. Widmo Nawigacji materializuje się z cieni..."
    ui_story "Jego postać utkana jest z zagmatwanych ścieżek i zgubionych dowiązań."
    sleep 1

    enemy_set \
        "Widmo Nawigacji" \
        80 \
        15 \
        "navigation" \
        "Starożytny duch skręcony z zapomnianych ścieżek. Żywi się dezorientacją tych, którzy nie umieją nawigować w terminalu." \
        "Widmo rozprasza się w smugi światła, gdy recytujesz polecenia nawigacyjne. Droga przez las jest wolna!" \
        80 \
        25 \
        "Kompas pwd"

    combat_start
}

level_01_complete() {
    ui_clear
    ui_header "Las Nawigacji – Pokonany!"
    ui_story "Słońce zalewa polanę gdy ostatni strażnik pada."
    echo
    ui_dialog "Pustelnik Siwobrodek" \
        "Niezwykłe! Opanowałeś sztukę nawigacji. Pamiętaj: \
'ls' by zobaczyć, 'pwd' by wiedzieć gdzie jesteś, 'cd' by się poruszać, \
i 'mkdir'/'rmdir' by kształtować świat wokół siebie. Te umiejętności \
będą ci służyć w każdym zakątku terminala." \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Opanowane Polecenia ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bls%b    – wyświetl zawartość katalogu\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bpwd%b   – wypisz bieżący katalog roboczy\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcd%b    – zmień katalog\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bmkdir%b – utwórz nowy katalog\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %brmdir%b – usuń pusty katalog\n" "${COLOR_COMMAND}" "${RESET}"
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
