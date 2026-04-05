#!/usr/bin/env bash
# lib/challenges.sh – Bash-command challenge database
#
# Each challenge is a record stored in indexed parallel arrays.  Fields:
#   CHALLENGE_QUESTION   – what the player is asked
#   CHALLENGE_ANSWERS    – §-separated list of accepted answers (case-insensitive)
#   CHALLENGE_HINT       – hint shown after a wrong answer
#   CHALLENGE_EXPLAIN    – explanation shown after the battle
#   CHALLENGE_CATEGORY   – navigation|files|text|pipes|scripting
#
# NOTE: answers are separated by § (U+00A7 section sign) to avoid conflicts
# with shell metacharacters like | which can themselves be valid answers.

SEP="§"   # answer separator – does not appear in any bash command/symbol

# ──────────────────────────────────────────────────────────────────────────────
# Category: NAVIGATION  (ls, pwd, cd, mkdir, rmdir)
# ──────────────────────────────────────────────────────────────────────────────
NAV_QUESTIONS=(
    "What command lists the contents of a directory?"
    "What command prints your current working directory?"
    "What command changes your current directory?"
    "What command creates a new directory?"
    "What command removes an EMPTY directory?"
    "What flag shows hidden files with 'ls'?"
    "What flag makes 'ls' show a long, detailed listing?"
    "How do you go up one directory level with 'cd'?"
    "What does 'ls -la' do?"
    "What shortcut takes you to your home directory with 'cd'?"
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
    "lists all files with details including hidden§shows all files with permissions"
    "cd ~§cd§~"
)
NAV_HINTS=(
    "It stands for 'list'."
    "Stands for 'print working directory'."
    "Stands for 'change directory'."
    "Stands for 'make directory'."
    "Stands for 'remove directory' – only works on empty dirs!"
    "Hidden files start with a dot (.).  The flag is a single letter."
    "The flag that gives a 'long' format listing."
    "Two dots (..) always refer to the parent directory."
    "Combine -l (long) with -a (all/hidden)."
    "Tilde (~) is your home directory alias."
)
NAV_EXPLAINS=(
    "'ls' lists directory contents. Use 'ls -la' to see all details including hidden files."
    "'pwd' shows your exact location in the filesystem hierarchy."
    "'cd <path>' changes your shell's current directory."
    "'mkdir <name>' creates a directory. Use '-p' to create nested dirs at once."
    "'rmdir' only removes empty directories. Use 'rm -r' for non-empty ones."
    "'ls -a' shows ALL files, including hidden ones that start with a dot (e.g., .bashrc)."
    "'ls -l' shows permissions, owner, size, and modification time of each file."
    "'cd ..' navigates to the parent directory one level up."
    "'ls -la' combines long format (-l) with show-all (-a) – very commonly used!"
    "'cd' or 'cd ~' both take you to your home directory (/home/username)."
)

# ──────────────────────────────────────────────────────────────────────────────
# Category: FILES  (touch, cat, cp, mv, rm, ln, file)
# ──────────────────────────────────────────────────────────────────────────────
FILE_QUESTIONS=(
    "What command creates an empty file (or updates its timestamp)?"
    "What command displays the contents of a file?"
    "What command copies a file?"
    "What command moves or renames a file?"
    "What command deletes a file?"
    "What flag lets 'rm' remove a directory and all its contents recursively?"
    "What command shows the type of a file?"
    "How do you display the manual for a command, e.g., for 'ls'?"
    "What command creates a symbolic (soft) link?"
    "What option of 'cp' preserves file attributes (recursive) when copying dirs?"
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
    "It 'touches' the file – creating it if absent."
    "Concatenate – even works with a single file to just print it."
    "Copy – first arg is source, second is destination."
    "Move – also used for renaming."
    "Remove – be careful, there's no trash can!"
    "The flag stands for 'recursive'."
    "This command inspects the file type, not its name."
    "Every command has a manual page – use 'man'."
    "Link with the 'symbolic' (-s) flag."
    "Think 'recursive' or 'archive'."
)
FILE_EXPLAINS=(
    "'touch file.txt' creates file.txt if it doesn't exist, or updates its timestamps."
    "'cat file.txt' prints the entire file to the terminal. 'less' is better for large files."
    "'cp source dest' copies a file. 'cp -r dir1 dir2' copies directories recursively."
    "'mv old new' renames or moves a file. Unlike 'cp', the original is removed."
    "'rm file' deletes permanently. Always double-check – there is no undo!"
    "'rm -r dir' removes dir and all contents. '-rf' skips confirmation prompts."
    "'file photo.jpg' reveals whether it's really a JPEG, PNG, text, script, etc."
    "'man <command>' opens the built-in manual. Press 'q' to quit."
    "'ln -s target link_name' creates a shortcut that points to the target."
    "'cp -r src dst' copies directories recursively. '-a' also preserves metadata."
)

# ──────────────────────────────────────────────────────────────────────────────
# Category: TEXT  (grep, find, head, tail, wc, sort, uniq, cut)
# ──────────────────────────────────────────────────────────────────────────────
TEXT_QUESTIONS=(
    "What command searches for a pattern inside files?"
    "What command finds files in the filesystem by name, type, etc.?"
    "What command shows the FIRST lines of a file?"
    "What command shows the LAST lines of a file?"
    "What command counts lines, words, and characters in a file?"
    "What command sorts lines of text alphabetically?"
    "What command removes duplicate adjacent lines?"
    "What command cuts out specific columns from delimited text?"
    "What flag makes 'grep' case-insensitive?"
    "What flag makes 'grep' search recursively through directories?"
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
    "Global Regular Expression Print – searches for patterns."
    "Searches the filesystem – not the content, but the files themselves."
    "Think 'head of the file' – first N lines."
    "Think 'tail of the file' – last N lines."
    "Word Count – also counts lines and bytes."
    "Alphabetical ordering of lines."
    "Unique – collapses consecutive duplicate lines."
    "Cut columns using a delimiter and field number."
    "The flag that ignores case differences."
    "The flag that descends into subdirectories."
)
TEXT_EXPLAINS=(
    "'grep pattern file' finds all lines matching the pattern. Supports regex."
    "'find /path -name \"*.sh\"' locates all .sh files under /path."
    "'head -n 20 file' shows the first 20 lines. Default is 10."
    "'tail -n 20 file' shows the last 20 lines. 'tail -f' follows live output."
    "'wc -l file' counts lines; '-w' counts words; '-c' counts bytes."
    "'sort file' sorts alphabetically. '-n' for numeric, '-r' for reverse."
    "'uniq' removes duplicate ADJACENT lines. Combine with 'sort' first."
    "'cut -d: -f1 /etc/passwd' extracts first field separated by colons."
    "'grep -i pattern file' matches regardless of letter case."
    "'grep -r pattern /dir' searches all files inside /dir recursively."
)

# ──────────────────────────────────────────────────────────────────────────────
# Category: PIPES  (|, >, >>, <, 2>, tee, xargs)
# ──────────────────────────────────────────────────────────────────────────────
PIPE_QUESTIONS=(
    "What symbol sends the output of one command as input to another?"
    "What symbol redirects stdout to a file, OVERWRITING it?"
    "What symbol redirects stdout to a file, APPENDING to it?"
    "What symbol redirects a file as stdin to a command?"
    "What symbol redirects stderr (error output) to a file?"
    "What command both displays AND saves output to a file simultaneously?"
    "How do you redirect both stdout and stderr to the same file?"
    "What does '/dev/null' represent?"
    "What command turns lines of stdin into arguments for another command?"
    "What does '2>&1' mean?"
)
PIPE_ANSWERS=(
    "|§pipe"
    ">§greater than"
    ">>§double greater than"
    "<§less than"
    "2>"
    "tee"
    "2>&1§>&§> file 2>&1"
    "the null device§a black hole§a device that discards all input§/dev/null discards"
    "xargs"
    "redirects stderr to stdout§merges stderr into stdout§sends stderr to stdout"
)
PIPE_HINTS=(
    "It looks like a pipe on the keyboard – the vertical bar character."
    "A single 'greater-than' sign."
    "Two 'greater-than' signs."
    "A 'less-than' sign – input flows left."
    "File descriptor 2 is stderr."
    "Like 'tee' in plumbing – splits the flow."
    "File descriptor 2 to file descriptor 1."
    "Like a black hole – data written to it disappears."
    "Execute arguments – pairs well with 'find'."
    "2 (stderr) goes to wherever &1 (stdout) is going."
)
PIPE_EXPLAINS=(
    "'ls | grep .sh' pipes ls output into grep, filtering .sh files."
    "'echo hi > file.txt' creates or overwrites file.txt with 'hi'."
    "'echo hi >> file.txt' appends 'hi' to file.txt without erasing existing content."
    "'sort < unsorted.txt' reads unsorted.txt as input for the sort command."
    "'cmd 2> errors.log' saves error messages to errors.log."
    "'ls | tee output.txt' prints to terminal AND writes to output.txt at once."
    "'cmd > file 2>&1' sends both stdout and stderr into file."
    "'/dev/null' discards everything written to it – useful for silencing output."
    "'find . -name \"*.log\" | xargs rm' deletes all .log files found."
    "'2>&1' merges stderr into stdout so they go to the same destination."
)

# ──────────────────────────────────────────────────────────────────────────────
# Category: SCRIPTING  (variables, conditions, loops, functions)
# ──────────────────────────────────────────────────────────────────────────────
SCRIPT_QUESTIONS=(
    "How do you assign the value 'hello' to a variable called 'msg'?"
    "How do you read (expand) the value of a variable 'msg'?"
    "What keyword starts an if-statement in bash?"
    "What keyword ends an if-statement in bash?"
    "What keyword starts a for loop in bash?"
    "What keyword starts a while loop in bash?"
    "What command reads a line of user input into a variable 'name'?"
    "What special variable holds the exit status of the last command?"
    "How do you define a bash function called 'greet'?"
    "What shebang line should a bash script start with?"
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
    "No spaces around the = sign!"
    "Prefix the variable name with a dollar sign."
    "Starts with 'if', ends with 'fi'."
    "The reverse of 'if'."
    "Loops start with 'for' and end with 'done'."
    "Loops start with 'while' and end with 'done'."
    "The 'read' builtin reads a line of stdin."
    "Dollar sign followed by a question mark."
    "The function name followed by () and curly braces."
    "The first line telling the OS which interpreter to use."
)
SCRIPT_EXPLAINS=(
    "'msg=hello' – no spaces! Bash is strict: 'msg = hello' is a syntax error."
    "'\$msg' or '\${msg}' expands the variable. Braces are needed in '\${msg}ful'."
    "'if [ condition ]; then ... elif ...; else ...; fi' is the full structure."
    "'fi' closes the if-block – it's 'if' spelled backwards!"
    "'for i in 1 2 3; do echo \$i; done' iterates over a list."
    "'while [ condition ]; do ...; done' loops while condition is true."
    "'read -r name' reads a line, storing it in \$name. '-r' prevents backslash escapes."
    "'\$?' is 0 on success, non-zero on error. Always check after critical commands."
    "'greet() { echo hello; }' defines a reusable function."
    "'#!/usr/bin/env bash' is portable; '#!/bin/bash' uses the fixed path."
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
