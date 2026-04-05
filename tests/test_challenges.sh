#!/usr/bin/env bash
# tests/test_challenges.sh – Unit tests for lib/challenges.sh

GAME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${GAME_DIR}/lib/colors.sh"
source "${GAME_DIR}/lib/ui.sh"
source "${GAME_DIR}/lib/player.sh"
source "${GAME_DIR}/lib/challenges.sh"

PASS=0
FAIL=0

assert_eq() {
    local desc="$1" expected="$2" actual="$3"
    if [[ "$expected" == "$actual" ]]; then
        printf "    %b✔%b %s\n" "${GREEN:-}" "${RESET:-}" "$desc"
        (( PASS++ ))
    else
        printf "    %b✘%b %s  (expected '%s', got '%s')\n" \
            "${RED:-}" "${RESET:-}" "$desc" "$expected" "$actual"
        (( FAIL++ ))
    fi
}

assert_true() {
    local desc="$1"
    if eval "$2"; then
        printf "    %b✔%b %s\n" "${GREEN:-}" "${RESET:-}" "$desc"
        (( PASS++ ))
    else
        printf "    %b✘%b %s\n" "${RED:-}" "${RESET:-}" "$desc"
        (( FAIL++ ))
    fi
}

echo
echo "  === Challenge Tests ==="

# ── challenges_check_answer ────────────────────────────────────────
assert_true "exact match"           'challenges_check_answer "ls" "ls"'
assert_true "case-insensitive"      'challenges_check_answer "LS" "ls"'
assert_true "leading whitespace"    'challenges_check_answer "  ls  " "ls"'
assert_true "sep-separated match"   'challenges_check_answer "pwd" "cd§pwd§ls"'
assert_true "second sep option"     'challenges_check_answer "-a" "-a§ls -a"'
assert_true "third sep option"      'challenges_check_answer "mkdir" "ls§cd§mkdir"'
assert_true "wrong answer fails"    '! challenges_check_answer "rm" "ls§cd§mkdir"'
assert_true "empty answer fails"    '! challenges_check_answer "" "ls"'

# ── challenges_get_random: navigation ─────────────────────────────
challenges_get_random "navigation" ""
assert_true "navigation question non-empty" '[[ -n "$CHALLENGE_QUESTION" ]]'
assert_true "navigation answer non-empty"   '[[ -n "$CHALLENGE_ANSWERS" ]]'
assert_true "navigation hint non-empty"     '[[ -n "$CHALLENGE_HINT" ]]'
assert_true "navigation explain non-empty"  '[[ -n "$CHALLENGE_EXPLAIN" ]]'
assert_true "CHALLENGE_IDX is numeric" '[[ "$CHALLENGE_IDX" =~ ^[0-9]+$ ]]'

# ── challenges_get_random: all categories ─────────────────────────
for cat in navigation files text pipes scripting processes; do
    challenges_get_random "$cat" ""
    assert_true "kategoria $cat zwraca pytanie" '[[ -n "$CHALLENGE_QUESTION" ]]'
done

# ── challenges_get_random: exclusion ──────────────────────────────
# Collect all indices for navigation to ensure randomness / exclusion works
declare -A seen_idxs
for i in $(seq 1 20); do
    challenges_get_random "navigation" ""
    seen_idxs[$CHALLENGE_IDX]=1
done
assert_true "multiple calls return varied indices" '[[ ${#seen_idxs[@]} -gt 1 ]]'

# ── verify correct answers for key navigation questions ───────────
assert_true "ls is correct for listing"    'challenges_check_answer "ls"    "ls"'
assert_true "pwd is correct for location"  'challenges_check_answer "pwd"   "pwd"'
assert_true "cd is correct for navigate"   'challenges_check_answer "cd"    "cd"'
assert_true "mkdir is correct for create"  'challenges_check_answer "mkdir" "mkdir"'
assert_true "rmdir is correct for remove"  'challenges_check_answer "rmdir" "rmdir"'

# ── verify correct answers for file operations ─────────────────────
assert_true "touch creates file"  'challenges_check_answer "touch" "touch"'
assert_true "cat reads file"      'challenges_check_answer "cat"   "cat"'
assert_true "cp copies file"      'challenges_check_answer "cp"    "cp"'
assert_true "mv moves file"       'challenges_check_answer "mv"    "mv"'
assert_true "rm removes file"     'challenges_check_answer "rm"    "rm"'

# ── verify correct answers for text processing ─────────────────────
assert_true "grep searches"    'challenges_check_answer "grep" "grep"'
assert_true "find locates"     'challenges_check_answer "find" "find"'
assert_true "head first lines" 'challenges_check_answer "head" "head"'
assert_true "tail last lines"  'challenges_check_answer "tail" "tail"'
assert_true "wc counts"        'challenges_check_answer "wc"   "wc"'
assert_true "sort orders"      'challenges_check_answer "sort" "sort"'

# ── verify pipe operators ──────────────────────────────────────────
assert_true "pipe symbol"         'challenges_check_answer "|"  "|§pipe"'
assert_true "redirect overwrite"  'challenges_check_answer ">"  ">"'
assert_true "redirect append"     'challenges_check_answer ">>" ">>"'

# ── verify scripting answers ───────────────────────────────────────
assert_true "'if' keyword"     'challenges_check_answer "if"    "if"'
assert_true "'fi' keyword"     'challenges_check_answer "fi"    "fi"'
assert_true "'for' keyword"    'challenges_check_answer "for"   "for"'
assert_true "'while' keyword"  'challenges_check_answer "while" "while"'


# ── verify process management answers ─────────────────────────────
assert_true "'ps' lists processes"   'challenges_check_answer "ps"    "ps"'
assert_true "'kill' kills process"   'challenges_check_answer "kill"  "kill"'
assert_true "'top' shows top"        'challenges_check_answer "top"   "top"'
assert_true "'bg' background"        'challenges_check_answer "bg"    "bg"'
assert_true "'fg' foreground"        'challenges_check_answer "fg"    "fg"'
assert_true "'jobs' shows jobs"      'challenges_check_answer "jobs"  "jobs"'
assert_true "'nohup' no hangup"      'challenges_check_answer "nohup" "nohup"'

# ── challenges_get_random: processes ──────────────────────────────
challenges_get_random "processes" ""
assert_true "processes question non-empty" '[[ -n "$CHALLENGE_QUESTION" ]]'
assert_true "processes answer non-empty"   '[[ -n "$CHALLENGE_ANSWERS" ]]'

echo
echo "  Challenge Tests: ${PASS} passed, ${FAIL} failed"
[[ $FAIL -eq 0 ]]
