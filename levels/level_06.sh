#!/usr/bin/env bash
# levels/level_06.sh – Cytadela Procesów
# Uczy: ps, kill, top, bg, fg, jobs, nohup, pgrep

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_06_intro() {
    ui_clear
    ui_header "Rozdział 6 – Cytadela Procesów"
    ui_story "Na wzgórzu za Wieżą Czarodzieja stoi mroczna Cytadela Procesów."
    ui_story "Jej mury drżą od nieustannie działających procesów i nieskończonych pętli."
    ui_story "Przy bramie czeka postać w zbroi z tablicami PID-ów."
    echo
    ui_dialog "Strażnik Procesów Daemon" \
        "Wojowniku Bash! Twoja przygoda nie dobiegła jeszcze końca. Ta cytadela \
kryje ostateczny sekret terminala – zarządzanie procesami. Tutaj nauczysz się \
jak widzieć wszystkie uruchomione procesy, jak je zatrzymywać, jak przenosić \
między tłem i pierwszym planem. Opanuj te umiejętności, a będziesz prawdziwym \
władcą systemu. Ale najpierw musisz pokonać moich trzech strażników!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Trzy niebezpieczne istoty strzegą Cytadeli Procesów."
    ui_story "To jest twoje ostateczne wyzwanie, Wojowniku Bash!"
    echo
    press_enter
}

level_06_encounter1() {
    ui_story "Zombie Procesów wyłania się z mroku, ciągnąc za sobą łańcuch martwych procesów!"
    ui_story "Nie może umrzeć, bo nikt nie wywołał wait() na jego rodzicu."
    sleep 1

    enemy_set \
        "Zombie Procesów" \
        90 \
        18 \
        "processes" \
        "Martwy proces, który nie może zniknąć ze stołu procesów. Zapełnia tablicę procesów i spowalnia system. Boi się 'ps' i 'kill'." \
        "Zombie procesów w końcu zostaje zebrany przez init. Lista procesów jest czysta!" \
        110 \
        35 \
        "Mikstura zdrowia"

    combat_start
}

level_06_encounter2() {
    ui_story "Wchodzisz głębiej. Demon Sierot Procesów blokuje drogę!"
    ui_story "Jego dzieci-procesy działają bez kontroli, zjadając CPU i pamięć."
    sleep 1

    enemy_set \
        "Demon Sierot" \
        110 \
        21 \
        "processes" \
        "Demon, którego procesy potomne oderwały się od kontroli. Każdy z nich konsumuje zasoby systemowe bez żadnego nadzoru. Tylko nohup i jobs mogą go ujarzmić." \
        "Osierocone procesy zostają przejęte przez init i właściwie zakończone. Demon disparu!" \
        130 \
        40 \
        "Eliksir wiedzy"

    combat_start
}

level_06_encounter3() {
    ui_story "Szczyt cytadeli. Kolos Jądra przebudza się z wiecznego snu!"
    ui_story "Jego ciało zbudowane jest z wątków jądra, a każde uderzenie to SIGKILL."
    sleep 1

    enemy_set \
        "Kolos Jądra" \
        170 \
        28 \
        "processes" \
        "Strażnik samego jądra systemu. Operuje bezpośrednio na tablicy procesów i może unicestwić każdy proces jednym gestem. Tylko prawdziwy mistrz zarządzania procesami może go pokonać." \
        "Kolos Jądra pada, przekazując ci Klucz Administratora. Jesteś teraz pełnym władcą terminala!" \
        180 \
        60 \
        "Klucz Administratora"

    combat_start
}

level_06_midpoint() {
    ui_story "Daemon siada na kamieniu i wygładza swoją zbroję z tablic PID-ów."
    echo
    ui_dialog "Strażnik Procesów Daemon" \
        "Posłuchaj zanim zaatakujesz Kolosa! 'kill -9' to ostateczna broń – \
żaden proces jej nie przetrwa. 'pkill' uderza po nazwie zamiast PID-u. \
'wait' wstrzyma skrypt do chwili zakończenia dziecka. \
A 'nice' da ci kontrolę nad priorytetami. Wiedza ta jest twoją tarczą!" \
        "${BOLD_CYAN}"
    press_enter
}

level_06_encounter4() {
    ui_story "Za tronem Kolosa unosi się coś niepojętego – Duch Jądra Linuksa we własnej osobie!"
    ui_story "Jest zbudowany z milionów linii kodu źródłowego i zarządza każdym procesem w systemie."
    sleep 1

    enemy_set \
        "Duch Jądra Linuksa" \
        185 \
        30 \
        "processes" \
        "Ostateczny strażnik systemu – manifestacja samego jądra Linuksa. Każde jego spojrzenie wysyła sygnał. Każdy ruch to wywołanie systemowe. Jego moc jest absolutna. To najcięższy egzamin wojownika Bash." \
        "Duch Jądra skłania się nisko. 'System działa harmonijnie pod twoją opieką' – brzmi echo w cytadeli. Przekazuje ci Pierścień Root'a – symbol absolutnej władzy nad terminalem!" \
        185 \
        65 \
        ""

    combat_start
}

level_06_complete() {
    ui_clear
    ui_header "Cytadela Procesów – Zdobyta!"
    ui_story "Cytadela milknie. Wszystkie procesy działają harmonijnie pod twoją kontrolą."
    echo
    ui_dialog "Strażnik Procesów Daemon" \
        "NIESAMOWITE! Pokonałeś wszystkich strażników Cytadeli. Posiadasz teraz \
kompletną wiedzę o zarządzaniu procesami: 'ps' by widzieć, 'kill' by zatrzymywać, \
'top' by monitorować, 'bg'/'fg' by zarządzać tłem, 'jobs' by śledzić zadania, \
i 'nohup' by uodparniać procesy. Jesteś teraz absolutnym WŁADCĄ TERMINALA!" \
        "${BOLD_YELLOW}"

    echo
    printf "  %b━━━ Opanowane Zarządzanie Procesami ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bps%b      – wyświetl uruchomione procesy\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bkill%b    – zakończ proces (wyślij sygnał)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %btop%b     – monitor procesów w czasie rzeczywistym\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bbg%b      – wznów zadanie w tle\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfg%b      – przenieś zadanie na pierwszy plan\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bjobs%b    – wyświetl zadania bieżącej powłoki\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bnohup%b   – uruchom odpornie na rozłączenie\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bpgrep%b   – szukaj PID-u po nazwie procesu\n" "${COLOR_COMMAND}" "${RESET}"
    echo

    ui_hr "★"
    ui_center "${BOLD_YELLOW}🏆  Gratulacje, ${PLAYER_NAME}!  🏆${RESET}"
    ui_center "${BOLD_WHITE}Jesteś teraz certyfikowanym WOJOWNIKIEM BASH!${RESET}"
    ui_hr "★"
    echo
    press_enter

    CURRENT_LEVEL=7
    save_game
}

run_level_06() {
    level_06_intro
    level_06_encounter1 || return 1
    if ! player_is_dead; then
        level_06_encounter2 || true
    fi
    if ! player_is_dead; then
        level_06_midpoint
        level_06_encounter3 || true
    fi
    if ! player_is_dead; then
        level_06_encounter4 || true
    fi
    if ! player_is_dead; then
        level_06_complete
    fi
}
