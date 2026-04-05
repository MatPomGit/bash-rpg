#!/usr/bin/env bash
# levels/level_05.sh – Wieża Czarodzieja
# Uczy: zmienne, if, for, while, funkcje, $?, shebang

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_05_intro() {
    ui_clear
    ui_header "Rozdział 5 – Wieża Czarodzieja"
    ui_story "Cztery wielkie próby za tobą. Twoja moc jest imponująca – lecz nie wystarczająca."
    ui_story "Wirus Chaosu ewoluuje. Ucieka od pojedynczych poleceń, kryje się w czasie."
    ui_story "By go pokonać raz na zawsze, potrzebujesz Najwyższej Sztuki – Skryptowania."
    ui_story "Nareszcie przed tobą wyrasta Wieża Skryptowania Czarodzieja."
    ui_story "Błyskawice uderzają w jej iglicę, gdy zmienne skrzą się w powietrzu."
    ui_story "Wielki Czarodziej Bourne pojawia się w wybuchu fragmentów skryptów."
    echo
    ui_dialog "Wielki Czarodziej Bourne" \
        "A więc przybyłeś, by nauczyć się najwyższej sztuki – Skryptowania Bash! \
Zmienne to pojemniki na moc, warunki to rozwidlenia losu, pętle to \
nieskończone inkantacje, a funkcje wiążą wiedzę w wielokrotne zaklęcia. \
Razem tworzą skrypty – autonomiczne programy, które działają bez twojego udziału. \
To właśnie tym narzędziem pokonasz Wirusa Chaosu. Przeżyj moich strażników, \
a zdobędziesz tytuł Wojownika Bash!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Trzech strażników skryptowania stoi między tobą a tytułem Wojownika Bash."
    ui_story "To twój przedostatni test!"
    echo
    press_enter
}

level_05_spellbook() {
    ui_clear
    ui_header "📖 Księga Zaklęć – Skryptowanie"
    ui_story "Czarodziej Bourne otwiera ogromny tom oprawiony w piorunochron."
    ui_story "\"Skryptowanie to magia wyższego rzędu. Zaklęcia, które same się wykonują.\""
    echo
    ui_hr "─"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" 'var=wartość' "${RESET}" "Runa Wiązania"   "zapisz wartość w zmiennej"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" '$var'        "${RESET}" "Runa Wyzwolenia" "odczytaj wartość ze zmiennej"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "if/fi"       "${RESET}" "Rozwidlenie Losu" "wykonaj kod warunkowo"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "for/done"    "${RESET}" "Pętla Iteracji"  "powtórz dla każdego elementu"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "while/done"  "${RESET}" "Wieczna Warta"   "pętla dopóki warunek prawdziwy"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "func() {}"   "${RESET}" "Pieczęć Wiedzy"  "stwórz wielokrotnego użytku zaklęcie"
    printf "  %b%-12s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" '$?'          "${RESET}" "Wyrocznianik"    "odczytaj wynik ostatniego polecenia"
    ui_hr "─"
    echo
    ui_dialog "Wielki Czarodziej Bourne" \
        "Zmienna to runa wiążąca – 'var=wartość' zapisuje, '\$var' odczytuje. \
Pamiętaj: żadnych spacji wokół znaku '='! 'if/fi' to moment decyzji – \
ścieżka rozwidla się w zależności od warunku. 'for' to inkantacja iteracji \
po każdym elemencie. 'while' trwa dopóki warunek jest prawdziwy. \
Funkcja 'func() {}' wiąże całe zaklęcia w jedno słowo, które potem \
wywołujesz wielokrotnie. A '\$?' to wyrocznianik – powie ci, czy ostatnie \
polecenie się udało (0) czy nie (cokolwiek innego). To są cztery filary skryptowania!" \
        "${BOLD_CYAN}"
    press_enter
}

level_05_encounter1() {
    ui_story "Z krokwi spada Wampir Zmiennych!"
    ui_story "Wysysa wartości ze zmiennych, zostawiając tylko puste ciągi."
    sleep 1

    enemy_set \
        "Wampir Zmiennych" \
        80 \
        16 \
        "scripting" \
        "Blada istota wysysająca wartości ze zmiennych. Nie znosi prawidłowego przypisywania i rozwijania zmiennych." \
        "Trumna pustych zmiennych wampira zostaje rozbita. Zmienne znów płyną swobodnie!" \
        100 \
        30 \
        ""

    combat_start
}

level_05_encounter2() {
    ui_story "Klatka schodowa wije się w górę. Lich Pętli blokuje następne piętro!"
    ui_story "Jest uwięziony w nieskończonej pętli i próbuje wciągnąć cię do środka."
    sleep 1

    enemy_set \
        "Lich Pętli" \
        100 \
        19 \
        "scripting" \
        "Nieumarły mag uwięziony w nieskończonej pętli. Wykonuje ten sam kod od stuleci i szuka towarzystwa." \
        "Przerywasz nieskończoną pętlę licha dobrze umieszczoną instrukcją 'break'. W końcu odpoczywa." \
        120 \
        35 \
        "Mikstura Zdrowia"

    combat_start
}

level_05_encounter3() {
    ui_story "Szczyt wieży. Konstrukt Warunków budzi się – golem z czystego if/else!"
    ui_story "Jego ciało zbudowane jest z logiki boolowskiej, a oczy płoną operatorami porównania."
    sleep 1

    enemy_set \
        "Konstrukt Warunków" \
        150 \
        25 \
        "scripting" \
        "Przerażający automat zbudowany z instrukcji warunkowych. Każdy atak to rozgałęziające się drzewo decyzyjne. Tylko mistrz skryptowania może rozplątać jego logikę." \
        "Ostatni warunek Konstruktu ewaluuje do TRUE: jesteś godny. Kłania się i prezentuje Laskę Skryptów!" \
        160 \
        50 \
        "Laska Skryptów"

    combat_start
}

level_05_midpoint() {
    ui_story "Wielki Czarodziej Bourne pojawia się w powiriu kodu na chwilę odpoczynku."
    echo
    ui_dialog "Wielki Czarodziej Bourne" \
        "Dobra robota do tej pory! Ale Konstrukt Warunków to dopiero prolog. \
Za nim ukrywają się jeszcze silniejsi przeciwnicy. Przypomnij sobie: \
'\$1', '\$@' i '\$#' to klucze do argumentów skryptów. \
'case' jest elegantszy od długich if-elif. \
A tablice 'arr=()' to struktury danych, które otwierają nowe możliwości!" \
        "${BOLD_CYAN}"
    press_enter
}

level_05_encounter4() {
    ui_story "Spod Laski Skryptów wyłania się cień... Arcymag Kodu się przebudza!"
    ui_story "Napisał pierwsze skrypty powłoki. Pamięta czasy przed bash, kiedy był tylko sh."
    sleep 1

    enemy_set \
        "Arcymag Kodu" \
        165 \
        27 \
        "scripting" \
        "Legendarny czarodziej, który napisał pierwszy skrypt powłoki. Jego moc pochodzi z dekad doświadczenia w skryptowaniu. Zna każdą zmienną specjalną, każdy operator i każdą pułapkę." \
        "Arcymag kiwa głową w milczeniu. Potem przemawia: 'Masz duszę skryptowacza. Wyjdź i twórz!' Wręcza ci Rodowód Bourne'a – dowód twojego mistrzostwa." \
        165 \
        55 \
        ""

    combat_start
}

level_05_complete() {
    ui_clear
    ui_header "Wieża Czarodzieja – Zdobyta!"
    ui_story "Wieża jaśnieje złotym światłem. Osiągnąłeś szczyt!"
    echo
    ui_dialog "Wielki Czarodziej Bourne" \
        "NIESAMOWITE! Pokonałeś wszystkich moich strażników i dowiodłeś swojej wartości. \
Posiadasz teraz wiedzę zmiennych, warunków, pętli i \
funkcji – cztery filary skryptowania Bash. Z tymi mocami \
połączonymi z twoim mistrzostwem nawigacji, plików, tekstu i potoków, \
jesteś prawdziwym WOJOWNIKIEM BASH! Ale jeszcze jedna próba czeka..." \
        "${BOLD_YELLOW}"

    echo
    printf "  %b━━━ Opanowane Skrypty ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bvar=wartość%b  – przypisz zmienną (bez spacji!)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b\$var%b         – rozwiń zmienną\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bif/fi%b        – warunkowe rozgałęzienie\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfor/done%b     – iteruj po liście\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bwhile/done%b   – pętla gdy warunek prawdziwy\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfunc() {}%b    – zdefiniuj funkcję\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %b\$?%b           – kod wyjścia ostatniego polecenia\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bread%b         – wczytaj wejście użytkownika\n" "${COLOR_COMMAND}" "${RESET}"
    echo
    press_enter

    CURRENT_LEVEL=6
    save_game
}

run_level_05() {
    level_05_intro
    level_05_spellbook
    level_05_encounter1 || return 1
    if ! player_is_dead; then
        level_05_encounter2 || true
    fi
    if ! player_is_dead; then
        level_05_midpoint
        level_05_encounter3 || true
    fi
    if ! player_is_dead; then
        level_05_encounter4 || true
    fi
    if ! player_is_dead; then
        level_05_complete
    fi
}
