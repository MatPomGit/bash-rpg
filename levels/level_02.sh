#!/usr/bin/env bash
# levels/level_02.sh – Jaskinia Plików
# Uczy: touch, cat, cp, mv, rm, ln, file, man

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/colors.sh"
source "${SCRIPT_DIR}/../lib/ui.sh"
source "${SCRIPT_DIR}/../lib/player.sh"
source "${SCRIPT_DIR}/../lib/combat.sh"
source "${SCRIPT_DIR}/../lib/save_load.sh"

level_02_intro() {
    ui_clear
    ui_header "Rozdział 2 – Jaskinia Plików"
    ui_story "Za lasem leży wejście do Jaskini Plików."
    ui_story "Ściany jaskini wyłożone są kryształami w kształcie ikon plików."
    ui_story "Tajemniczy archiwista siedzi przy wejściu, polerując zwój."
    echo
    ui_dialog "Archiwista Pergamin" \
        "Witaj, nawigatorze! Jaskinia przed tobą rządzona jest przez stwory, które \
niszczą, ukrywają i usuwają pliki. By przeżyć, musisz opanować operacje \
na plikach – tworzenie z 'touch', czytanie z 'cat', kopiowanie z 'cp', \
przenoszenie z 'mv' i budząca postrach 'rm', która niszczy bez litości. \
Uważaj – w odróżnieniu od świata powyżej, tutaj nie ma cofania!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Trzech strażników chroni Jaskinię Plików."
    ui_story "Pokonaj ich, by zdobyć Traktat Mistrzostwa Plików."
    echo
    press_enter
}

level_02_encounter1() {
    ui_story "Plikowy Fantom dryfuje ku tobie, niosąc pusty plik..."
    ui_story "Ciągle szepcze 'jak STWORZYĆ plik?'"
    sleep 1

    enemy_set \
        "Plikowy Fantom" \
        50 \
        10 \
        "files" \
        "Półprzezroczysty duch dzierżący puste zwoje. Nie potrafi tworzyć plików i wrzeszczy na puste katalogi." \
        "Fantom w końcu materializuje plik i niknie, usatysfakcjonowany." \
        40 \
        15 \
        ""

    combat_start
}

level_02_encounter2() {
    ui_story "W głębi jaskini Zepsuty Demon blokuje drogę."
    ui_story "Pomieszał wszystkie nazwy plików i gorączkowo je przenosi."
    sleep 1

    enemy_set \
        "Zepsuty Demon" \
        70 \
        14 \
        "files" \
        "Demon zrodzony z nieudanego sprawdzania systemu plików. Przenosi pliki w losowe miejsca i rechocze maniakalnie." \
        "Demon jest zmuszony przywrócić porządek, kładąc każdy plik na właściwym miejscu." \
        60 \
        20 \
        "Mikstura zdrowia"

    combat_start
}

level_02_encounter3() {
    ui_story "Jaskinia drży. Archiwalny Elemental przebudza się ze swojego snu!"
    ui_story "Ta starożytna istota zbudowana jest w całości ze skompresowanych archiwów i zepsutych danych."
    sleep 1

    enemy_set \
        "Archiwalny Elemental" \
        100 \
        18 \
        "files" \
        "Majestatyczne stworzenie ze spakowanych archiwów i dowiązań symbolicznych. Strzeże Traktatu Mistrzostwa Plików brutalnymi atakami usuwania plików." \
        "Elemental rozsypuje się w stos dobrze zorganizowanych plików. Traktat Mistrzostwa Plików jest twój!" \
        100 \
        30 \
        "Traktat Plików"

    combat_start
}

level_02_complete() {
    ui_clear
    ui_header "Jaskinia Plików – Oczyszczona!"
    ui_story "Jaskinia skąpana jest teraz w ciepłej, zorganizowanej poświacie."
    echo
    ui_dialog "Archiwista Pergamin" \
        "Niezwykłe umiejętności! Oswoiłeś Jaskinię Plików. Zawsze pamiętaj \
o mocy, którą teraz dzierżysz: 'touch' by tworzyć, 'cat' by czytać, 'cp' by kopiować, \
'mv' by przenosić lub zmieniać nazwę, i 'rm' by usuwać. Używaj 'rm' mądrze – \
wielka moc rodzi wielką odpowiedzialność. W Bash nie ma kosza!" \
        "${BOLD_GREEN}"

    echo
    printf "  %b━━━ Opanowane Polecenia ━━━%b\n" "${BOLD_WHITE}" "${RESET}"
    printf "  %btouch%b  – utwórz plik / zaktualizuj datę\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcat%b    – wyświetl zawartość pliku\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bcp%b     – kopiuj pliki/katalogi\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bmv%b     – przenieś lub zmień nazwę pliku\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %brm%b     – usuń pliki (trwale!)\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bln -s%b  – utwórz dowiązanie symboliczne\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bfile%b   – określ typ pliku\n" "${COLOR_COMMAND}" "${RESET}"
    printf "  %bman%b    – czytaj podręcznik polecenia\n" "${COLOR_COMMAND}" "${RESET}"
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
