#!/usr/bin/env bash
# levels/level_03.sh – Świątynia Tekstu
# Uczy: grep, find, head, tail, wc, sort, uniq, cut

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_03_intro() {
    ui_clear
    ui_header "Rozdział 3 – Świątynia Tekstu"
    ui_story "Jaskinia Plików jest oczyszczona, a ty czujesz rosnącą moc w dłoniach."
    ui_story "Jednak Wirus Chaosu zdążył ukryć swoje tajne plany głębiej – w strumieniach tekstu."
    ui_story "Miliony linii danych spływają po ścianach, zaszyfrowane i pomieszane."
    ui_story "Przed tobą wznosi się starożytna Świątynia Tekstu, wykuta z czystego obsydianu."
    ui_story "Miliony linii tekstu spływają po jej ścianach jak wodospady."
    ui_story "Uczony w szatach kłania się, gdy się zbliżasz."
    echo
    ui_dialog "Uczony Regex" \
        "Ach, dzielna dusza szuka mądrości przetwarzania tekstu! Wirus Chaosu \
ukrył swoje rozkazy wśród setek tysięcy linii danych. By je znaleźć, \
musisz opanować Sztukę Wzorców – szukanie z 'grep', lokalizowanie z 'find', \
próbkowanie z 'head' i 'tail', liczenie z 'wc', porządkowanie z 'sort' \
i deduplikację z 'uniq'. Oby twoje wzorce były silne!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Starożytni strażnicy bronią Świątyni Tekstu przed tymi, co szukają prawdy."
    ui_story "Zmierz się z nimi, by odblokować Sekrety Dopasowywania Wzorców."
    echo
    press_enter
}

level_03_spellbook() {
    ui_clear
    ui_header "📖 Księga Zaklęć – Tekst"
    ui_story "Uczony Regex siada i rozkłada przed tobą zwój pełen symboli i wzorców."
    ui_story "\"Tekst to język wszechświata terminala. Naucz się go czytać i pisać.\""
    echo
    ui_hr "─"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "grep"  "${RESET}" "Oko Wzorców"       "szukaj wzorców w tekście"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "find"  "${RESET}" "Tropiciel"         "lokalizuj pliki w systemie"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "head"  "${RESET}" "Pierwsze Spojrzenie" "wyświetl pierwsze N linii"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "tail"  "${RESET}" "Ostatnie Słowo"    "wyświetl ostatnie N linii"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "wc"    "${RESET}" "Runa Liczenia"     "licz linie, słowa i znaki"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "sort"  "${RESET}" "Zaklęcie Porządku" "posortuj linie tekstu"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "uniq"  "${RESET}" "Pieczęć Jedyności" "usuń zduplikowane linie"
    printf "  %b%-7s%b  ✦ %-20s  %s\n" "${COLOR_COMMAND}" "cut"   "${RESET}" "Ostrze Precyzji"   "wytnij kolumny z tekstu"
    ui_hr "─"
    echo
    ui_dialog "Uczony Regex" \
        "'grep' – Oko Wzorców – wypatrzy każde słowo w oceanie danych. Przekaż \
mu wzorzec, a on znajdzie każdą linię, w której on się pojawia. \
'find' jako Tropiciel przeszuka cały system plików w twoim imieniu. \
'head' i 'tail' dają ci szybki wgląd w początek i koniec pliku. \
'wc' zlicza – linie, słowa, bajty. 'sort' zaprowadza porządek \
w chaosie. 'uniq' wymiata duplikaty. 'cut' pozwala wyciągnąć \
dokładnie tę kolumnę danych, której szukasz. Razem są niepowstrzymane!" \
        "${BOLD_CYAN}"
    press_enter
}

level_03_encounter1() {
    ui_story "Z rozświetlonego tekstu na podłodze wyłania się Wzorcowe Widmo..."
    ui_story "Ukrywa się w logach i kpi z tych, którzy nie mogą go znaleźć."
    sleep 1

    enemy_set \
        "Wzorcowe Widmo" \
        60 \
        12 \
        "text" \
        "Duch zbudowany w całości z wyrażeń regularnych. Zmienia swój wygląd, by dezorientować szukających wzorców." \
        "Wzorzec widma zostaje rozbity. Rozpływa się w czystym ASCII." \
        60 \
        20 \
        ""

    combat_start
}

level_03_encounter2() {
    ui_story "Kamienne drzwi skrzypią. Do przodu pędzi Demon Wyszukiwania!"
    ui_story "Zgubił gdzieś plik w hierarchii /usr i jest wściekły."
    sleep 1

    enemy_set \
        "Demon Wyszukiwania" \
        80 \
        16 \
        "text" \
        "Demon nieustannie szukający zagubionego pliku konfiguracyjnego. Jego frustracja czyni go gwałtownym." \
        "Pomagasz demonowi znaleźć jego plik konfiguracyjny za pomocą 'find'. Spokojnieje i odchodzi." \
        75 \
        25 \
        "Mikstura zdrowia"

    combat_start
}

level_03_encounter3() {
    ui_story "Podłoga świątyni drży. Z sufitu spada Wiwerna Słów!"
    ui_story "Jej łuski zbudowane są z posortowanych linii, a oddech śmierdzi 'wc -l'."
    sleep 1

    enemy_set \
        "Wiwerna Słów" \
        110 \
        20 \
        "text" \
        "Przerażający smok, którego moc rośnie z każdą pochłoniętą linią tekstu. Tylko ci, którzy potrafią liczyć, sortować i deduplikować, mogą go ujarzmić." \
        "Wiwerna zostaje uśmierzona przez twoje mistrzostwo narzędzi tekstowych. Kłania się i prezentuje Kryształ grep!" \
        110 \
        35 \
        "Kryształ grep"

    combat_start
}

level_03_midpoint() {
    ui_story "Uczony Regex siada obok ciebie, rozkładając zwój pełen wzorców."
    echo
    ui_dialog "Uczony Regex" \
        "Słuchaj uważnie! Gdy staniesz przed Wiwerną, pamiętaj o mocy 'sed' – \
edytora strumieniowego, który transformuje tekst w locie. 'awk' zaś potrafi \
przetwarzać dane kolumnami. A 'tr' zamieni litery wielkie na małe jednym \
ruchem. To połączenie jest potężniejsze niż jakakolwiek broń!" \
        "${BOLD_CYAN}"
    press_enter
}

level_03_encounter4() {
    ui_story "Za ołtarzem świątyni budzi się coś starszego od samego grep'a..."
    ui_story "Wyrocznia Wzorców otwiera tysiąc oczu – każde widzi inny wzorzec regularny."
    sleep 1

    enemy_set \
        "Wyrocznia Wzorców" \
        125 \
        22 \
        "text" \
        "Pradawna wyrocznia utkana z wyrażeń regularnych i transformacji tekstu. Widzi wszystkie wzorce i potrafi je wszystkie zastosować jednocześnie. Tylko mistrz przetwarzania tekstu może ją pokonać." \
        "Wyrocznia zamyka swoje oczy z szacunkiem. 'Przewiduję wielką przyszłość dla ciebie w krainie terminala' – mówi, zostawiając Zwój Mądrości Tekstu." \
        125 \
        40 \
        ""

    combat_start
}

level_03_complete() {
    ui_clear
    ui_header "Świątynia Tekstu – Wyzwolona!"
    ui_story "Ściany świątyni nieruchomieją. Porządek przywrócono strumieniom tekstu."
    echo
    ui_dialog "Uczony Regex" \
        "Wspaniałe! Świątynia jest spokojna. Władasz teraz najpotężniejszymi \
narzędziami tekstowymi w arsenale terminala. 'grep' do wzorców, 'find' do \
lokalizowania plików, 'head'/'tail' do szybkiego próbkowania, 'wc' do liczenia, \
'sort' do porządkowania i 'uniq' do deduplikacji. Te narzędzia, \
połączone z potokami, uczynią cię niepokonanym!" \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Opanowane Polecenia ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %bgrep%b  – szukaj wzorców w tekście\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfind%b  – lokalizuj pliki w systemie plików\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bhead%b  – wyświetl pierwsze N linii pliku\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %btail%b  – wyświetl ostatnie N linii pliku\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bwc%b    – licz linie, słowa, znaki\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bsort%b  – sortuj linie tekstu\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %buniq%b  – usuń zduplikowane linie\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcut%b   – wyodrębniaj kolumny z tekstu\n" "${COLOR_COMMAND}" "${RESET}"
    echo
    press_enter

    CURRENT_LEVEL=4
    save_game
}

run_level_03() {
    level_03_intro
    level_03_spellbook
    level_03_encounter1 || return 1
    if ! player_is_dead; then
        level_03_encounter2 || true
    fi
    if ! player_is_dead; then
        level_03_midpoint
        level_03_encounter3 || true
    fi
    if ! player_is_dead; then
        level_03_encounter4 || true
    fi
    if ! player_is_dead; then
        level_03_complete
    fi
}
