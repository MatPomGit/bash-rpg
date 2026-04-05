#!/usr/bin/env bash
# lib/save_load.sh – Save and load game state

SAVE_DIR="${HOME}/.bash_rpg"
SAVE_FILE="${SAVE_DIR}/save.dat"

save_game() {
    mkdir -p "$SAVE_DIR"
    cat > "$SAVE_FILE" <<EOF
PLAYER_NAME=${PLAYER_NAME}
PLAYER_LEVEL=${PLAYER_LEVEL}
PLAYER_XP=${PLAYER_XP}
PLAYER_XP_NEXT=${PLAYER_XP_NEXT}
PLAYER_HP=${PLAYER_HP}
PLAYER_MAX_HP=${PLAYER_MAX_HP}
PLAYER_GOLD=${PLAYER_GOLD}
PLAYER_ATTACK=${PLAYER_ATTACK}
PLAYER_DEFENSE=${PLAYER_DEFENSE}
CURRENT_LEVEL=${CURRENT_LEVEL}
PLAYER_INVENTORY=${PLAYER_INVENTORY[*]:-}
EOF
    printf "  %b✔ Game saved.%b\n" "${COLOR_SUCCESS:-}" "${RESET:-}"
}

load_game() {
    [[ -f "$SAVE_FILE" ]] || return 1

    local line key value
    while IFS='=' read -r key value; do
        [[ "$key" =~ ^# ]] && continue
        [[ -z "$key" ]] && continue
        case "$key" in
            PLAYER_NAME)      PLAYER_NAME="$value" ;;
            PLAYER_LEVEL)     PLAYER_LEVEL="$value" ;;
            PLAYER_XP)        PLAYER_XP="$value" ;;
            PLAYER_XP_NEXT)   PLAYER_XP_NEXT="$value" ;;
            PLAYER_HP)        PLAYER_HP="$value" ;;
            PLAYER_MAX_HP)    PLAYER_MAX_HP="$value" ;;
            PLAYER_GOLD)      PLAYER_GOLD="$value" ;;
            PLAYER_ATTACK)    PLAYER_ATTACK="$value" ;;
            PLAYER_DEFENSE)   PLAYER_DEFENSE="$value" ;;
            CURRENT_LEVEL)    CURRENT_LEVEL="$value" ;;
            PLAYER_INVENTORY)
                PLAYER_INVENTORY=()
                if [[ -n "$value" ]]; then
                    read -r -a PLAYER_INVENTORY <<< "$value"
                fi
                ;;
        esac
    done < "$SAVE_FILE"
    return 0
}

has_save() {
    [[ -f "$SAVE_FILE" ]]
}

delete_save() {
    rm -f "$SAVE_FILE"
    printf "  %b✔ Save deleted.%b\n" "${COLOR_SUCCESS:-}" "${RESET:-}"
}
