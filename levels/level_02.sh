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
    ui_story "Las Nawigacji jest za tobą. Twoje pierwsze zaklęcia płyną już w żyłach."
    ui_story "Lecz Wirus Chaosu nie śpi – jego macki sięgają głębiej niż gałęzie lasu."
    ui_story "Przed tobą, wyryta w skale, zieje ciemna szczelina: Jaskinia Plików."
    ui_story "To tu Wirus ukrywa skradzione dane, miesza pliki i niszczy archiwa."
    ui_story "Ściany jaskini wyłożone są kryształami w kształcie ikon plików."
    ui_story "Tajemniczy archiwista siedzi przy wejściu, polerując zwój."
    echo
    ui_dialog "Archiwista Pergamin" \
        "Witaj, nawigatorze! Jaskinia przed tobą rządzona jest przez stwory, które \
niszczą, ukrywają i usuwają pliki. By przeżyć, musisz opanować operacje \
na plikach – tworzenie z 'touch', czytanie z 'cat', kopiowanie z 'cp', \
przenoszenie z 'mv' i budzącą postrach 'rm', która niszczy bez litości. \
Uważaj – w odróżnieniu od świata powyżej, tutaj nie ma cofania!" \
        "${BOLD_WHITE}"
    press_enter

    ui_story "Strażnicy chronią Jaskinię Plików przed każdym, kto chce zaprowadzić porządek."
    ui_story "Pokonaj ich, by zdobyć Traktat Mistrzostwa Plików i ruszyć dalej."
    echo
    press_enter
}

level_02_spellbook() {
    ui_clear
    ui_header "📖 Księga Zaklęć – Pliki"
    ui_story "Archiwista Pergamin rozwija stary zwój i wskazuje na wyryte w nim runy."
    ui_story "\"Pliki to istota każdego systemu. Opanuj je, a nic nie zdoła cię zaskoczyć.\""
    echo
    ui_hr "─"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "touch"  "${RESET}" "Przywołanie"      "stwórz nowy, pusty plik"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "cat"    "${RESET}" "Czytanie Zwoju"   "wyświetl zawartość pliku"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "cp"     "${RESET}" "Duplikacja"       "skopiuj plik w nowe miejsce"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "mv"     "${RESET}" "Translokacja"     "przenieś lub zmień nazwę pliku"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "rm"     "${RESET}" "Unicestwienie"    "usuń plik – bezpowrotnie!"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "ln -s"  "${RESET}" "Więź Cienia"      "stwórz dowiązanie symboliczne"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "file"   "${RESET}" "Prawdziwe Oblicze" "ujawnij prawdziwy typ pliku"
    printf "  %b%-7s%b  ✦ %-18s  %s\n" "${COLOR_COMMAND}" "man"    "${RESET}" "Wyrocznia"        "pytaj wyrocznię o każde zaklęcie"
    ui_hr "─"
    echo
    ui_dialog "Archiwista Pergamin" \
        "Zapamiętaj: 'touch' przywołuje nowy plik z nicości. 'cat' pozwoli ci \
zajrzeć do jego wnętrza bez otwierania. 'cp' to duplikacja – oryginał zostaje. \
'mv' przenosi lub przemianowuje bez śladu. Ale 'rm' to Unicestwienie – \
raz użyte, nie ma odwołania! 'ln -s' tworzy cień pliku w innym miejscu. \
'file' zdradzi ci co tak naprawdę kryje się pod rozszerzeniem. \
A 'man' to wyrocznia – pyta ją, gdy nie znasz zaklęcia!" \
        "${BOLD_CYAN}"
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

level_02_midpoint() {
    ui_story "Archiwista Pergamin wyłania się zza stalaktytu, trzymając stary zwój."
    echo
    ui_dialog "Archiwista Pergamin" \
        "Uwaga, wędrowcze! Zanim zmierzysz się z Archiwalnym Elementalem, przypomnij sobie: \
'stat' zdradzi ci każdy sekret pliku – rozmiar, uprawnienia, daty. \
'diff' pokaże co zmieniło się między dwoma wersjami. \
'chmod +x' doda bit wykonywalności. Wiedza ta może uratować ci życie!" \
        "${BOLD_CYAN}"
    press_enter
}

level_02_encounter4() {
    ui_story "Z głębin jaskini wypełza coś czego się nie spodziewałeś – Golem Danych!"
    ui_story "Jego ciało skute jest z twardych dowiązań i metadanych plików systemu."
    sleep 1

    enemy_set \
        "Golem Danych" \
        115 \
        20 \
        "files" \
        "Masywny konstrukt z twardych dowiązań i metadanych. Każde jego uderzenie zmienia uprawnienia i atrybuty. Tylko mistrz plików może go pokonać." \
        "Golem kruszy się na kupę zwykłych plików. Wśród nich błyszczy Klucz Dostępu – rzadki łup ze skarbca jaskini!" \
        115 \
        35 \
        ""

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
    level_02_spellbook
    level_02_encounter1 || return 1
    if ! player_is_dead; then
        level_02_encounter2 || true
    fi
    if ! player_is_dead; then
        level_02_midpoint
        level_02_encounter3 || true
    fi
    if ! player_is_dead; then
        level_02_encounter4 || true
    fi
    if ! player_is_dead; then
        level_02_complete
    fi
}
