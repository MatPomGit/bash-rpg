#!/usr/bin/env bash
# lib/save_load.sh – Save and load game state

SAVE_DIR="${HOME}/.bash_rpg"
SAVE_FILE="${SAVE_DIR}/save.dat"

save_game() {
    mkdir -p "$SAVE_DIR"

    {
        printf 'PLAYER_NAME=%s\n' "${PLAYER_NAME}"
        printf 'PLAYER_LEVEL=%s\n' "${PLAYER_LEVEL}"
        printf 'PLAYER_XP=%s\n' "${PLAYER_XP}"
        printf 'PLAYER_XP_NEXT=%s\n' "${PLAYER_XP_NEXT}"
        printf 'PLAYER_HP=%s\n' "${PLAYER_HP}"
        printf 'PLAYER_MAX_HP=%s\n' "${PLAYER_MAX_HP}"
        printf 'PLAYER_GOLD=%s\n' "${PLAYER_GOLD}"
        printf 'PLAYER_ATTACK=%s\n' "${PLAYER_ATTACK}"
        printf 'PLAYER_DEFENSE=%s\n' "${PLAYER_DEFENSE}"
        printf 'PLAYER_TALENT_POINTS=%s\n' "${PLAYER_TALENT_POINTS}"
        printf 'TALENT_OFFENSE_LEVEL=%s\n' "${TALENT_OFFENSE_LEVEL}"
        printf 'TALENT_DEFENSE_LEVEL=%s\n' "${TALENT_DEFENSE_LEVEL}"
        printf 'TALENT_KNOWLEDGE_LEVEL=%s\n' "${TALENT_KNOWLEDGE_LEVEL}"
        printf 'TALENT_KNOWLEDGE_HINTS=%s\n' "${TALENT_KNOWLEDGE_HINTS}"
        printf 'CURRENT_LEVEL=%s\n' "${CURRENT_LEVEL}"

        # Nowy, bezpieczny format ekwipunku (wspiera nazwy wielowyrazowe).
        printf 'PLAYER_INVENTORY_COUNT=%d\n' "${#PLAYER_INVENTORY[@]}"
        local idx
        for idx in "${!PLAYER_INVENTORY[@]}"; do
            printf 'PLAYER_INVENTORY_ITEM_%d=%q\n' "$idx" "${PLAYER_INVENTORY[$idx]}"
        done

        # Legacy fallback zostawiamy dla zgodności ze starszym odczytem.
        printf 'PLAYER_INVENTORY=%s\n' "${PLAYER_INVENTORY[*]:-}"
    } > "$SAVE_FILE"

    printf "  %b✔ Game saved.%b\n" "${COLOR_SUCCESS:-}" "${RESET:-}"
}

load_game() {
    [[ -f "$SAVE_FILE" ]] || return 1

    local key value
    local inventory_count=""
    local found_new_inventory_format=false
    PLAYER_INVENTORY=()

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
            PLAYER_TALENT_POINTS) PLAYER_TALENT_POINTS="$value" ;;
            TALENT_OFFENSE_LEVEL) TALENT_OFFENSE_LEVEL="$value" ;;
            TALENT_DEFENSE_LEVEL) TALENT_DEFENSE_LEVEL="$value" ;;
            TALENT_KNOWLEDGE_LEVEL) TALENT_KNOWLEDGE_LEVEL="$value" ;;
            TALENT_KNOWLEDGE_HINTS) TALENT_KNOWLEDGE_HINTS="$value" ;;
            CURRENT_LEVEL)    CURRENT_LEVEL="$value" ;;
            PLAYER_INVENTORY_COUNT)
                inventory_count="$value"
                found_new_inventory_format=true
                ;;
            PLAYER_INVENTORY_ITEM_*)
                # Odtwarzamy element przez eval tylko z zapisanego %q.
                local idx="${key#PLAYER_INVENTORY_ITEM_}"
                local decoded_item=""
                eval "decoded_item=${value}"
                PLAYER_INVENTORY[$idx]="$decoded_item"
                found_new_inventory_format=true
                ;;
            PLAYER_INVENTORY)
                # Fallback dla starych zapisów bez nowego formatu.
                if [[ "$found_new_inventory_format" == "false" && -n "$value" ]]; then
                    read -r -a PLAYER_INVENTORY <<< "$value"
                fi
                ;;
        esac
    done < "$SAVE_FILE"

    # Sanitization: uzupełniamy luki po indeksach, jeśli plik był edytowany ręcznie.
    if [[ "$found_new_inventory_format" == "true" && -n "$inventory_count" ]]; then
        local normalized=()
        local i
        for (( i=0; i<inventory_count; i++ )); do
            if [[ -n "${PLAYER_INVENTORY[$i]:-}" ]]; then
                normalized+=("${PLAYER_INVENTORY[$i]}")
            fi
        done
        PLAYER_INVENTORY=("${normalized[@]}")
    fi

    return 0
}

has_save() {
    [[ -f "$SAVE_FILE" ]]
}

delete_save() {
    rm -f "$SAVE_FILE"
    printf "  %b✔ Save deleted.%b\n" "${COLOR_SUCCESS:-}" "${RESET:-}"
}
