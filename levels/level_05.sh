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
    ui_story "Nareszcie przed tobą wyrasta Wieża Skryptowania Czarodzieja."
    ui_story "Błyskawice uderzają w jej iglicę, gdy zmienne skrzą się w powietrzu."
    ui_story "Wielki Czarodziej Bourne pojawia się w wybuchu fragmentów skryptów."
    echo
    ui_dialog "Wielki Czarodziej Bourne" \
        "A więc przybyłeś, by nauczyć się najwyższej sztuki – Skryptowania Bash! Zmienne, \
warunki, pętle i funkcje to zaklęcia, które transformują zwykłego \
wpisywacza poleceń w prawdziwego czarodzieja powłoki. Strażnicy mojej wieży \
testują tylko tych godnych tej wiedzy. Przeżyj ich, a zdobędziesz tytuł \
Wojownika Bash. Ponieś porażkę, a pozostaniesz zwykłym śmiertelnikiem na zawsze." \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Trzech strażników skryptowania stoi między tobą a tytułem Wojownika Bash."
    ui_story "To twój ostateczny test!"
    echo
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
