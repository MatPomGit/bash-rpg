#!/usr/bin/env bash
# levels/level_04.sh – Rzeka Potoków
# Uczy: |, >, >>, <, 2>, tee, xargs, /dev/null

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_04_intro() {
    ui_clear
    ui_header "Rozdział 4 – Rzeka Potoków"
    ui_story "Docierasz do brzegów legendarnej Rzeki Potoków."
    ui_story "Dane płyną jak woda, przekierowywane przez tajemnicze symbole wyryte w kamieniu."
    ui_story "Przewoźnik pcha tratwę ze złączonych rur ku tobie."
    echo
    ui_dialog "Przewoźnik Przekierowanie" \
        "By przeprawić się przez Rzekę Potoków, musisz rozumieć przepływ danych. \
Symbol potoku '|' wysyła wyjście jednego polecenia do drugiego. \
Nawiasy '>' i '>>' przekierowują do plików. '<' pobiera z plików. \
'2>' przechwytuje błędy. A 'tee' rozdziela przepływ na dwa strumienie. \
Opanuj przekierowania, a opanujesz samą krew powłoki!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Trzy potwory rzeczne strzegą przeprawy."
    ui_story "Tylko mistrz potoków i przekierowań może przejść."
    echo
    press_enter
}

level_04_encounter1() {
    ui_story "Potokowy Smok wyrywa się z wody, owijając się wokół zepsutego rurociągu!"
    ui_story "Jego ogon to symbol potoku, a z pyska zieje niezłączonymi poleceniami."
    sleep 1

    enemy_set \
        "Potokowy Smok" \
        70 \
        14 \
        "pipes" \
        "Wężowy smok, którego moc pochodzi ze zepsutych rurociągów. Nie znosi połączonych poleceń." \
        "Potokowy Smok rozplątuje się i wślizguje z powrotem do rzeki, upokorzony." \
        75 \
        25 \
        ""

    combat_start
}

level_04_encounter2() {
    ui_story "Nurt przybiera! Wąż Przekierowania wynurza się, sycząc nazwami plików!"
    ui_story "Indyskryminacyjnie nadpisuje pliki swoim kłem '>'."
    sleep 1

    enemy_set \
        "Wąż Przekierowania" \
        90 \
        17 \
        "pipes" \
        "Przebiegły wąż nadpisujący ważne pliki kłem '>'. Boi się operatora '>>' nade wszystko." \
        "Wąż jest zmuszony dołączać zamiast nadpisywać i wycofuje się ze wstydem." \
        90 \
        30 \
        "Mikstura Zdrowia"

    combat_start
}

level_04_encounter3() {
    ui_story "Rzeka ciemnieje. Z głębin wynurza się Kałamarnica Strumieni!"
    ui_story "Osiem macek, każda to inny deskryptor pliku, smaga wodę."
    sleep 1

    enemy_set \
        "Kałamarnica Strumieni" \
        130 \
        22 \
        "pipes" \
        "Starożytna kałamarnica stderr i stdout. Plącze wszystkie twoje potoki i przekierowuje błędy do /dev/null. Przerażający przeciwnik." \
        "Deskryptory pliku kałamarnicy zostają wreszcie posortowane. Zanurza się z zadowolonym bulgotaniem, zostawiając Trójząb Potoków!" \
        130 \
        40 \
        "Trójząb Potoków"

    combat_start
}

level_04_midpoint() {
    ui_story "Przewoźnik Przekierowanie dobija do brzegu z wiosłem i zatrzymuje się przy tobie."
    echo
    ui_dialog "Przewoźnik Przekierowanie" \
        "Miej się na baczności! Za Kałamarnicą czeka coś gorszego. \
Pamiętaj o operatorach '&&' i '||' – łańcuchują polecenia logicznie. \
Subshell '()' izoluje środowisko. A heredoc '<<EOF' wpycha tekst \
prosto do polecenia. To są broń wyższego rzędu w walce z potokami!" \
        "${BOLD_CYAN}"
    press_enter
}

level_04_encounter4() {
    ui_story "Rzeka wzbiera. Z jej środka wyłania się Hydrora Przekierowań!"
    ui_story "Każda z siedmiu głów reprezentuje inny operator przekierowania."
    sleep 1

    enemy_set \
        "Hydra Przekierowań" \
        145 \
        24 \
        "pipes" \
        "Mityczny potwór z siedmioma głowami – każda to inny operator: |, >, >>, <, 2>, &&, ||. Odetnij jedną głowę, wyrosną dwie. Tylko kompletna wiedza o przekierowaniach może ją pokonać." \
        "Wszystkie głowy Hydry opadają jednocześnie, gdy demonstrujesz pełne mistrzostwo potoków. Rzeka rozlewa się ze złota i Kamień Potoków ląduje w twoich rękach!" \
        145 \
        45 \
        ""

    combat_start
}

level_04_complete() {
    ui_clear
    ui_header "Rzeka Potoków – Przeprawiona!"
    ui_story "Rzeka uspokaja się. Dane płyną płynnie przez idealnie połączone potoki."
    echo
    ui_dialog "Przewoźnik Przekierowanie" \
        "Zrobiłeś to! Rzeka jest oswojona. Z potokami i przekierowaniami \
możesz łączyć dowolną liczbę poleceń, filtrować i transformować strumienie danych, \
zapisywać wyjście do plików i wyciszać hałas z /dev/null. \
To są fundamentalne elementy składowe mistrzostwa skryptowania powłoki. \
Wieża Czarodzieja czeka na ciebie na drugim brzegu!" \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Opanowane Operatory ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %b|%b      – potok: wyślij stdout do stdin następnego polecenia\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b>%b      – przekieruj stdout do pliku (nadpisz)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b>>%b     – przekieruj stdout do pliku (dołącz)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b<%b      – przekieruj plik na stdin\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b2>%b     – przekieruj stderr do pliku\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b2>&1%b   – przekieruj stderr na stdout\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %btee%b    – podziel wyjście: wyświetl I zapisz\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bxargs%b  – zbuduj argumenty polecenia z linii stdin\n" "${COLOR_COMMAND}" "${RESET}"
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
        level_04_midpoint
        level_04_encounter3 || true
    fi
    if ! player_is_dead; then
        level_04_encounter4 || true
    fi
    if ! player_is_dead; then
        level_04_complete
    fi
}
