#!/usr/bin/env bash
# lib/challenges.sh – Baza wyzwań z poleceniami Bash
#
# Każde wyzwanie to rekord w indeksowanych równoległych tablicach. Pola:
#   CHALLENGE_QUESTION   – pytanie zadawane graczowi
#   CHALLENGE_ANSWERS    – lista akceptowanych odpowiedzi oddzielona §
#   CHALLENGE_HINT       – podpowiedź po błędnej odpowiedzi
#   CHALLENGE_EXPLAIN    – wyjaśnienie po walce
#   CHALLENGE_CATEGORY   – navigation|files|text|pipes|scripting|processes
#
# UWAGA: odpowiedzi są oddzielone § (U+00A7 znak sekcji) aby uniknąć
# konfliktów z metaznakami powłoki jak | które mogą być poprawnymi odpowiedziami.

SEP="§"   # separator odpowiedzi – nie pojawia się w żadnym poleceniu bash

# ──────────────────────────────────────────────────────────────────────────────
# Kategoria: NAWIGACJA  (ls, pwd, cd, mkdir, rmdir)
# ──────────────────────────────────────────────────────────────────────────────
NAV_QUESTIONS=(
    "Jakie polecenie wyświetla zawartość katalogu?"
    "Jakie polecenie wypisuje bieżący katalog roboczy?"
    "Jakie polecenie zmienia bieżący katalog?"
    "Jakie polecenie tworzy nowy katalog?"
    "Jakie polecenie usuwa PUSTY katalog?"
    "Jaka flaga pokazuje ukryte pliki w poleceniu 'ls'?"
    "Jaka flaga wyświetla szczegółową listę w poleceniu 'ls'?"
    "Jak przejść o jeden poziom wyżej za pomocą 'cd'?"
    "Co robi polecenie 'ls -la'?"
    "Jaki skrót przenosi do katalogu domowego z 'cd'?"
)
NAV_ANSWERS=(
    "ls"
    "pwd"
    "cd"
    "mkdir"
    "rmdir"
    "-a§ls -a§ls -la§-la"
    "-l§ls -l§ls -la§-la"
    "cd ..§.."
    "lists all files with details including hidden§shows all files with permissions§wyświetla wszystkie pliki ze szczegółami"
    "cd ~§cd§~"
)
NAV_HINTS=(
    "Pochodzi od słowa 'list' (lista)."
    "Skrót od 'print working directory' (wydrukuj katalog roboczy)."
    "Skrót od 'change directory' (zmień katalog)."
    "Skrót od 'make directory' (utwórz katalog)."
    "Skrót od 'remove directory' (usuń katalog) – działa tylko na pustych!"
    "Ukryte pliki zaczynają się od kropki (.). Flaga to jedna litera."
    "Flaga dająca 'długi' (long) format listingu."
    "Dwie kropki (..) zawsze oznaczają katalog nadrzędny."
    "Łączy -l (długi) z -a (wszystkie/ukryte)."
    "Tylda (~) to alias katalogu domowego."
)
NAV_EXPLAINS=(
    "'ls' wyświetla zawartość katalogu. Użyj 'ls -la' by zobaczyć wszystkie szczegóły łącznie z ukrytymi."
    "'pwd' pokazuje dokładną lokalizację w hierarchii systemu plików."
    "'cd <ścieżka>' zmienia bieżący katalog powłoki."
    "'mkdir <nazwa>' tworzy katalog. Użyj '-p' by tworzyć zagnieżdżone katalogi naraz."
    "'rmdir' usuwa tylko puste katalogi. Użyj 'rm -r' dla niepustych."
    "'ls -a' pokazuje WSZYSTKIE pliki, łącznie z ukrytymi zaczynającymi się od kropki (np. .bashrc)."
    "'ls -l' pokazuje uprawnienia, właściciela, rozmiar i datę modyfikacji każdego pliku."
    "'cd ..' przechodzi do katalogu nadrzędnego o jeden poziom wyżej."
    "'ls -la' łączy format długi (-l) z pokazaniem wszystkich (-a) – bardzo powszechnie używane!"
    "'cd' lub 'cd ~' zabierają do katalogu domowego (/home/nazwa)."
)

# ──────────────────────────────────────────────────────────────────────────────
# Kategoria: PLIKI  (touch, cat, cp, mv, rm, ln, file)
# ──────────────────────────────────────────────────────────────────────────────
FILE_QUESTIONS=(
    "Jakie polecenie tworzy pusty plik (lub aktualizuje jego znacznik czasu)?"
    "Jakie polecenie wyświetla zawartość pliku?"
    "Jakie polecenie kopiuje plik?"
    "Jakie polecenie przenosi lub zmienia nazwę pliku?"
    "Jakie polecenie usuwa plik?"
    "Jaka flaga pozwala 'rm' usunąć katalog ze wszystką zawartością rekurencyjnie?"
    "Jakie polecenie pokazuje typ pliku?"
    "Jak wyświetlić instrukcję polecenia, np. dla 'ls'?"
    "Jakie polecenie tworzy dowiązanie symboliczne (miękkie)?"
    "Jaka opcja 'cp' zachowuje atrybuty pliku (rekurencyjnie) przy kopiowaniu katalogów?"
)
FILE_ANSWERS=(
    "touch"
    "cat"
    "cp"
    "mv"
    "rm"
    "-r§-rf§rm -r§rm -rf§-r -f"
    "file"
    "man ls"
    "ln -s"
    "-r§cp -r§-a§cp -a"
)
FILE_HINTS=(
    "'Dotyka' plik – tworząc go, jeśli nie istnieje."
    "Concatenate – działa też dla jednego pliku by go wypisać."
    "Copy – pierwszy argument to źródło, drugi to cel."
    "Move – używane też do zmiany nazwy."
    "Remove – ostrożnie, nie ma kosza!"
    "Flaga oznaczająca 'rekurencyjnie' (recursive)."
    "To polecenie sprawdza typ pliku, nie jego nazwę."
    "Każde polecenie ma stronę podręcznika – użyj 'man'."
    "Dowiązanie z flagą 'symboliczne' (-s)."
    "Pomyśl o 'rekurencyjnie' lub 'archiwum'."
)
FILE_EXPLAINS=(
    "'touch plik.txt' tworzy plik.txt jeśli nie istnieje lub aktualizuje jego datę."
    "'cat plik.txt' wypisuje cały plik na terminal. 'less' jest lepszy dla dużych plików."
    "'cp źródło cel' kopiuje plik. 'cp -r katalog1 katalog2' kopiuje katalogi rekurencyjnie."
    "'mv stare nowe' zmienia nazwę lub przenosi plik. W przeciwieństwie do 'cp', oryginał jest usuwany."
    "'rm plik' usuwa trwale. Zawsze sprawdź dwa razy – nie ma cofania!"
    "'rm -r katalog' usuwa katalog i całą zawartość. '-rf' pomija monity o potwierdzenie."
    "'file zdjęcie.jpg' odkrywa czy to naprawdę JPEG, PNG, tekst, skrypt itp."
    "'man <polecenie>' otwiera wbudowany podręcznik. Naciśnij 'q' by wyjść."
    "'ln -s cel nazwa_dowiązania' tworzy skrót wskazujący na cel."
    "'cp -r src dst' kopiuje katalogi rekurencyjnie. '-a' zachowuje też metadane."
)

# ──────────────────────────────────────────────────────────────────────────────
# Kategoria: TEKST  (grep, find, head, tail, wc, sort, uniq, cut)
# ──────────────────────────────────────────────────────────────────────────────
TEXT_QUESTIONS=(
    "Jakie polecenie wyszukuje wzorzec w plikach?"
    "Jakie polecenie wyszukuje pliki w systemie plików po nazwie, typie itp.?"
    "Jakie polecenie pokazuje PIERWSZE linie pliku?"
    "Jakie polecenie pokazuje OSTATNIE linie pliku?"
    "Jakie polecenie liczy linie, słowa i znaki w pliku?"
    "Jakie polecenie sortuje linie tekstu alfabetycznie?"
    "Jakie polecenie usuwa zduplikowane kolejne linie?"
    "Jakie polecenie wycina określone kolumny z tekstu oddzielonego?"
    "Jaka flaga sprawia że 'grep' ignoruje wielkość liter?"
    "Jaka flaga sprawia że 'grep' przeszukuje katalogi rekurencyjnie?"
)
TEXT_ANSWERS=(
    "grep"
    "find"
    "head"
    "tail"
    "wc"
    "sort"
    "uniq"
    "cut"
    "-i§grep -i§-i flag"
    "-r§-R§grep -r§grep -R"
)
TEXT_HINTS=(
    "Global Regular Expression Print – szuka wzorców."
    "Przeszukuje system plików – nie zawartość, lecz same pliki."
    "Pomyśl 'głowa pliku' – pierwsze N linii."
    "Pomyśl 'ogon pliku' – ostatnie N linii."
    "Word Count – liczy też linie i bajty."
    "Alfabetyczne porządkowanie linii."
    "Unique – zwija kolejne zduplikowane linie."
    "Wytnij kolumny używając separatora i numeru pola."
    "Flaga ignorująca różnice w wielkości liter."
    "Flaga schodząca do podkatalogów."
)
TEXT_EXPLAINS=(
    "'grep wzorzec plik' szuka wszystkich linii pasujących do wzorca. Obsługuje wyrażenia regularne."
    "'find /ścieżka -name \"*.sh\"' lokalizuje wszystkie pliki .sh pod daną ścieżką."
    "'head -n 20 plik' pokazuje pierwsze 20 linii. Domyślnie 10."
    "'tail -n 20 plik' pokazuje ostatnie 20 linii. 'tail -f' śledzi wyjście na żywo."
    "'wc -l plik' liczy linie; '-w' słowa; '-c' bajty."
    "'sort plik' sortuje alfabetycznie. '-n' numerycznie, '-r' odwrotnie."
    "'uniq' usuwa KOLEJNE zduplikowane linie. Połącz z 'sort' najpierw."
    "'cut -d: -f1 /etc/passwd' wyodrębnia pierwsze pole oddzielone dwukropkami."
    "'grep -i wzorzec plik' dopasowuje niezależnie od wielkości liter."
    "'grep -r wzorzec /katalog' przeszukuje wszystkie pliki w katalogu rekurencyjnie."
)

# ──────────────────────────────────────────────────────────────────────────────
# Kategoria: POTOKI  (|, >, >>, <, 2>, tee, xargs)
# ──────────────────────────────────────────────────────────────────────────────
PIPE_QUESTIONS=(
    "Jaki symbol wysyła wyjście jednego polecenia jako wejście do innego?"
    "Jaki symbol przekierowuje stdout do pliku, NADPISUJĄC go?"
    "Jaki symbol przekierowuje stdout do pliku, DOŁĄCZAJĄC do niego?"
    "Jaki symbol przekierowuje plik jako stdin do polecenia?"
    "Jaki symbol przekierowuje stderr (błędy) do pliku?"
    "Jakie polecenie jednocześnie wyświetla I zapisuje wyjście do pliku?"
    "Jak przekierować zarówno stdout jak i stderr do tego samego pliku?"
    "Co reprezentuje '/dev/null'?"
    "Jakie polecenie zamienia linie stdin w argumenty innego polecenia?"
    "Co oznacza '2>&1'?"
)
PIPE_ANSWERS=(
    "|§pipe"
    ">§greater than"
    ">>§double greater than"
    "<§less than"
    "2>"
    "tee"
    "2>&1§>&§> file 2>&1"
    "the null device§a black hole§a device that discards all input§/dev/null discards§urządzenie null§czarna dziura"
    "xargs"
    "redirects stderr to stdout§merges stderr into stdout§sends stderr to stdout§przekierowuje stderr na stdout"
)
PIPE_HINTS=(
    "Wygląda jak rura na klawiaturze – pionowa kreska."
    "Jeden znak 'większy-niż'."
    "Dwa znaki 'większy-niż'."
    "Znak 'mniejszy-niż' – wejście płynie z lewej."
    "Deskryptor pliku 2 to stderr."
    "Jak 'T' w hydraulice – rozdziela przepływ."
    "Deskryptor pliku 2 do deskryptora pliku 1."
    "Jak czarna dziura – dane zapisane do niej znikają."
    "Execute arguments – dobrze pasuje do 'find'."
    "2 (stderr) trafia tam, gdzie jest &1 (stdout)."
)
PIPE_EXPLAINS=(
    "'ls | grep .sh' przekazuje wynik ls do grep, filtrując pliki .sh."
    "'echo hi > plik.txt' tworzy lub nadpisuje plik.txt słowem 'hi'."
    "'echo hi >> plik.txt' dołącza 'hi' do plik.txt bez usuwania zawartości."
    "'sort < niesortowany.txt' czyta niesortowany.txt jako wejście dla polecenia sort."
    "'polecenie 2> błędy.log' zapisuje komunikaty błędów do błędy.log."
    "'ls | tee wynik.txt' wypisuje na terminal I zapisuje do wynik.txt jednocześnie."
    "'polecenie > plik 2>&1' wysyła zarówno stdout jak i stderr do pliku."
    "'/dev/null' odrzuca wszystko co jest do niego zapisywane – przydatne do wyciszania wyjścia."
    "'find . -name \"*.log\" | xargs rm' usuwa wszystkie znalezione pliki .log."
    "'2>&1' łączy stderr ze stdout tak by trafiały do tego samego miejsca."
)

# ──────────────────────────────────────────────────────────────────────────────
# Kategoria: SKRYPTY  (zmienne, warunki, pętle, funkcje)
# ──────────────────────────────────────────────────────────────────────────────
SCRIPT_QUESTIONS=(
    "Jak przypisać wartość 'hello' do zmiennej o nazwie 'msg'?"
    "Jak odczytać (rozwinąć) wartość zmiennej 'msg'?"
    "Jakie słowo kluczowe rozpoczyna instrukcję if w bash?"
    "Jakie słowo kluczowe kończy instrukcję if w bash?"
    "Jakie słowo kluczowe rozpoczyna pętlę for w bash?"
    "Jakie słowo kluczowe rozpoczyna pętlę while w bash?"
    "Jakie polecenie wczytuje linię wejścia użytkownika do zmiennej 'name'?"
    "Jaka specjalna zmienna przechowuje kod wyjścia ostatniego polecenia?"
    "Jak zdefiniować funkcję bash o nazwie 'greet'?"
    "Od jakiej linii shebang powinien zaczynać się skrypt bash?"
)
SCRIPT_ANSWERS=(
    "msg=hello§msg='hello'§msg=\"hello\""
    "\$msg§\${msg}"
    "if"
    "fi"
    "for"
    "while"
    "read name§read -r name"
    "\$?§the dollar question mark"
    "greet() {§function greet {§function greet() {"
    "#!/usr/bin/env bash§#!/bin/bash"
)
SCRIPT_HINTS=(
    "Bez spacji wokół znaku = !"
    "Poprzedź nazwę zmiennej znakiem dolara."
    "Zaczyna się od 'if', kończy na 'fi'."
    "Odwrotność słowa 'if'."
    "Pętle zaczynają się od 'for' i kończą na 'done'."
    "Pętle zaczynają się od 'while' i kończą na 'done'."
    "Wbudowane polecenie 'read' wczytuje linię ze stdin."
    "Znak dolara po którym następuje znak zapytania."
    "Nazwa funkcji po której następuje () i nawiasy klamrowe."
    "Pierwsza linia mówiąca systemowi operacyjnemu który interpreter użyć."
)
SCRIPT_EXPLAINS=(
    "'msg=hello' – bez spacji! Bash jest surowy: 'msg = hello' to błąd składni."
    "'\$msg' lub '\${msg}' rozwija zmienną. Nawiasy klamrowe potrzebne np. w '\${msg}owy'."
    "'if [ warunek ]; then ... elif ...; else ...; fi' to pełna struktura."
    "'fi' zamyka blok if – to słowo 'if' napisane wspak!"
    "'for i in 1 2 3; do echo \$i; done' iteruje po liście."
    "'while [ warunek ]; do ...; done' zapętla się gdy warunek jest prawdziwy."
    "'read -r name' wczytuje linię, przechowując ją w \$name. '-r' zapobiega escapowaniu znaków."
    "'\$?' wynosi 0 przy sukcesie, niezerowe przy błędzie. Sprawdzaj po ważnych poleceniach."
    "'greet() { echo hello; }' definiuje wielokrotnie używaną funkcję."
    "'#!/usr/bin/env bash' jest przenośny; '#!/bin/bash' używa stałej ścieżki."
)

# ──────────────────────────────────────────────────────────────────────────────
# Kategoria: PROCESY  (ps, kill, top, bg, fg, jobs, nohup, pgrep)
# ──────────────────────────────────────────────────────────────────────────────
PROC_QUESTIONS=(
    "Jakie polecenie wyświetla listę aktualnie uruchomionych procesów?"
    "Jakie polecenie kończy (zabija) proces o podanym PID?"
    "Jakie polecenie wyświetla dynamiczne informacje o procesach?"
    "Jakie polecenie wznawia zadanie zawieszone w tle powłoki?"
    "Jakie polecenie przenosi zadanie z tła na pierwszy plan?"
    "Jakie polecenie wyświetla zadania działające w tle bieżącej powłoki?"
    "Jak uruchomić polecenie odporne na sygnał SIGHUP (rozłączenie)?"
    "Jaka flaga polecenia 'ps' pokazuje wszystkie procesy wszystkich użytkowników?"
    "Jakie polecenie wyszukuje PID procesu po jego nazwie?"
    "Jaki numer sygnału wysyła 'kill' domyślnie?"
)
PROC_ANSWERS=(
    "ps"
    "kill"
    "top"
    "bg"
    "fg"
    "jobs"
    "nohup"
    "aux§-aux§ps aux"
    "pgrep"
    "15§SIGTERM§kill -15"
)
PROC_HINTS=(
    "Skrót od 'process status' (status procesów)."
    "Wysyła sygnał do procesu o podanym identyfikatorze."
    "Aktualizuje się na bieżąco – wyświetla top (górę) procesów."
    "Skrót od 'background' (tło)."
    "Skrót od 'foreground' (pierwszy plan)."
    "Wyświetla zadania (jobs) bieżącej powłoki."
    "No Hang Up – ignoruje sygnał rozłączenia."
    "Pokazuje wszystkich użytkowników (a), format użytkownika (u), wszystkie (x)."
    "Process grep – szuka PID-u po nazwie procesu."
    "Domyślny sygnał to SIGTERM (grzeczne zakończenie)."
)
PROC_EXPLAINS=(
    "'ps aux' pokazuje wszystkie uruchomione procesy z detalami użytkownika."
    "'kill PID' wysyła SIGTERM. 'kill -9 PID' wymusza natychmiastowe zakończenie (SIGKILL)."
    "'top' to interaktywny monitor procesów. Naciśnij 'q' by wyjść. 'htop' to ulepszona wersja."
    "'bg %1' wznawia zadanie nr 1 w tle. Użyj po zawieszeniu Ctrl+Z."
    "'fg %1' przenosi zadanie nr 1 z tła na pierwszy plan terminala."
    "'jobs' wyświetla zadania tła bieżącej powłoki wraz z ich numerami."
    "'nohup polecenie &' uruchamia polecenie odporne na wylogowanie, kontynuuje po zamknięciu terminala."
    "'ps aux': a=wszyscy użytkownicy, u=format użytkownika, x=procesy bez terminala."
    "'pgrep bash' znajdzie PID wszystkich procesów bash. 'pgrep -l' pokazuje też nazwy."
    "Sygnał 15 (SIGTERM) prosi grzecznie o zakończenie. Sygnał 9 (SIGKILL) wymusza natychmiastowe."
)

# ──────────────────────────────────────────────────────────────────────────────
# Accessor functions
# ──────────────────────────────────────────────────────────────────────────────

# challenges_get_random <category> <exclude_indices_space_separated>
# Sets globals: CHALLENGE_QUESTION, CHALLENGE_ANSWERS, CHALLENGE_HINT, CHALLENGE_EXPLAIN
# Also sets: CHALLENGE_IDX (the index chosen)
CHALLENGE_IDX=0
CHALLENGE_QUESTION=""
CHALLENGE_ANSWERS=""
CHALLENGE_HINT=""
CHALLENGE_EXPLAIN=""

challenges_get_random() {
    local category="$1"
    local -a exclude=($2)   # already-used indices

    local -n q_arr a_arr h_arr e_arr
    case "$category" in
        navigation) q_arr=NAV_QUESTIONS;    a_arr=NAV_ANSWERS;    h_arr=NAV_HINTS;    e_arr=NAV_EXPLAINS;;
        files)      q_arr=FILE_QUESTIONS;   a_arr=FILE_ANSWERS;   h_arr=FILE_HINTS;   e_arr=FILE_EXPLAINS;;
        text)       q_arr=TEXT_QUESTIONS;   a_arr=TEXT_ANSWERS;   h_arr=TEXT_HINTS;   e_arr=TEXT_EXPLAINS;;
        pipes)      q_arr=PIPE_QUESTIONS;   a_arr=PIPE_ANSWERS;   h_arr=PIPE_HINTS;   e_arr=PIPE_EXPLAINS;;
        scripting)  q_arr=SCRIPT_QUESTIONS; a_arr=SCRIPT_ANSWERS; h_arr=SCRIPT_HINTS; e_arr=SCRIPT_EXPLAINS;;
        processes)  q_arr=PROC_QUESTIONS;   a_arr=PROC_ANSWERS;   h_arr=PROC_HINTS;   e_arr=PROC_EXPLAINS;;
        *)  return 1;;
    esac

    local total=${#q_arr[@]}
    local candidates=()
    local i
    for (( i=0; i<total; i++ )); do
        local skip=false
        local ex
        for ex in "${exclude[@]}"; do
            [[ "$ex" == "$i" ]] && skip=true && break
        done
        $skip || candidates+=("$i")
    done

    [[ ${#candidates[@]} -eq 0 ]] && candidates=($(seq 0 $(( total - 1 ))))

    CHALLENGE_IDX=${candidates[$(( RANDOM % ${#candidates[@]} ))]}
    CHALLENGE_QUESTION="${q_arr[$CHALLENGE_IDX]}"
    CHALLENGE_ANSWERS="${a_arr[$CHALLENGE_IDX]}"
    CHALLENGE_HINT="${h_arr[$CHALLENGE_IDX]}"
    CHALLENGE_EXPLAIN="${e_arr[$CHALLENGE_IDX]}"
}

# challenges_check_answer <given_answer> <accepted_sep_separated>
# Returns 0 if correct, 1 if wrong
# Answers in <accepted> are separated by § (section sign, U+00A7)
challenges_check_answer() {
    local given; given=$(echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    local accepted="$2"

    # Direct exact match first (handles cases where separator char could appear in answers)
    local accepted_clean; accepted_clean=$(echo "$accepted" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    [[ "$given" == "$accepted_clean" ]] && return 0

    # Split on § and check each option
    local option
    while IFS= read -r option; do
        local opt_clean; opt_clean=$(echo "$option" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        [[ -n "$opt_clean" ]] || continue
        [[ "$given" == "$opt_clean" ]] && return 0
    done < <(echo "$accepted" | tr "${SEP}" '\n')
    return 1
}
