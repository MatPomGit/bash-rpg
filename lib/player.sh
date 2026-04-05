#!/usr/bin/env bash
# lib/player.sh – Player state management

# shellcheck source=lib/ui.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/colors.sh"
source "${SCRIPT_DIR}/ui.sh"

# ──────────────────────────────────────────────────────────────────────────────
# Player state (global variables)
# ──────────────────────────────────────────────────────────────────────────────
PLAYER_NAME=""
PLAYER_LEVEL=1
PLAYER_XP=0
PLAYER_XP_NEXT=100
PLAYER_HP=100
PLAYER_MAX_HP=100
PLAYER_GOLD=0
PLAYER_ATTACK=10
PLAYER_DEFENSE=5
declare -a PLAYER_INVENTORY=()
CURRENT_LEVEL=1

# XP thresholds per level (index = level)
XP_TABLE=(0 100 250 450 700 1000 1400 1900 2500 3200 4000)
MAX_HP_TABLE=(0 100 120 145 175 210 250 300 360 430 500)

# ──────────────────────────────────────────────────────────────────────────────
# Initialization
# ──────────────────────────────────────────────────────────────────────────────

player_create() {
    local name="$1"
    PLAYER_NAME="$name"
    PLAYER_LEVEL=1
    PLAYER_XP=0
    PLAYER_XP_NEXT=${XP_TABLE[2]}   # 250 XP to reach level 2
    PLAYER_HP=100
    PLAYER_MAX_HP=100
    PLAYER_GOLD=0
    PLAYER_ATTACK=10
    PLAYER_DEFENSE=5
    PLAYER_INVENTORY=()
    CURRENT_LEVEL=1
}

# ──────────────────────────────────────────────────────────────────────────────
# Experience & Leveling
# ──────────────────────────────────────────────────────────────────────────────

player_add_xp() {
    local amount="$1"
    PLAYER_XP=$(( PLAYER_XP + amount ))
    ui_xp_gain "$amount"

    # Check for level up(s)
    local max_level=$(( ${#XP_TABLE[@]} - 1 ))
    while [[ $PLAYER_LEVEL -lt $max_level && $PLAYER_XP -ge $PLAYER_XP_NEXT ]]; do
        player_level_up
    done
}

player_level_up() {
    (( PLAYER_LEVEL++ ))
    PLAYER_MAX_HP=${MAX_HP_TABLE[$PLAYER_LEVEL]}
    PLAYER_HP=$PLAYER_MAX_HP    # full heal on level up
    PLAYER_XP_NEXT=${XP_TABLE[$(( PLAYER_LEVEL + 1 ))]}
    (( PLAYER_ATTACK += 3 ))
    (( PLAYER_DEFENSE += 2 ))

    ui_level_up "$PLAYER_LEVEL"
    printf "  %b Maks. PŻ: %d   Atak: %d   Obrona: %d%b\n" \
        "${BOLD_WHITE}" "$PLAYER_MAX_HP" "$PLAYER_ATTACK" "$PLAYER_DEFENSE" "${RESET}"
    press_enter
}

# ──────────────────────────────────────────────────────────────────────────────
# HP management
# ──────────────────────────────────────────────────────────────────────────────

player_heal() {
    local amount="$1"
    PLAYER_HP=$(( PLAYER_HP + amount ))
    [[ $PLAYER_HP -gt $PLAYER_MAX_HP ]] && PLAYER_HP=$PLAYER_MAX_HP
    printf "  %b❤  Uleczono %d PŻ  (PŻ: %d/%d)%b\n" "${COLOR_HP_HIGH}" "$amount" \
        "$PLAYER_HP" "$PLAYER_MAX_HP" "${RESET}"
}

player_damage() {
    local amount="$1"
    local effective=$(( amount - PLAYER_DEFENSE ))
    [[ $effective -lt 1 ]] && effective=1
    PLAYER_HP=$(( PLAYER_HP - effective ))
    [[ $PLAYER_HP -lt 0 ]] && PLAYER_HP=0
    printf "  %b💔 Otrzymałeś %d obrażeń  (PŻ: %d/%d)%b\n" "${COLOR_HP_LOW}" "$effective" \
        "$PLAYER_HP" "$PLAYER_MAX_HP" "${RESET}"
}

player_is_dead() {
    [[ $PLAYER_HP -le 0 ]]
}

# ──────────────────────────────────────────────────────────────────────────────
# Inventory
# ──────────────────────────────────────────────────────────────────────────────

player_add_item() {
    local item="$1"
    PLAYER_INVENTORY+=("$item")
    printf "  %b✦ Zdobyto: %s%b\n" "${COLOR_ITEM}" "$item" "${RESET}"
}

player_has_item() {
    local item="$1"
    local i
    for i in "${PLAYER_INVENTORY[@]}"; do
        [[ "$i" == "$item" ]] && return 0
    done
    return 1
}

player_remove_item() {
    local item="$1"
    local new_inv=()
    local removed=false
    local i
    for i in "${PLAYER_INVENTORY[@]}"; do
        if [[ "$i" == "$item" && "$removed" == "false" ]]; then
            removed=true
        else
            new_inv+=("$i")
        fi
    done
    PLAYER_INVENTORY=("${new_inv[@]}")
    [[ "$removed" == "true" ]]
}

player_use_item() {
    local item="$1"
    case "$item" in
        "Mikstura Zdrowia")
            if player_has_item "Mikstura Zdrowia"; then
                player_remove_item "Mikstura Zdrowia"
                player_heal 50
                return 0
            else
                ui_error "Nie masz Mikstury Zdrowia!"
                return 1
            fi
            ;;
        "Eliksir Wiedzy")
            if player_has_item "Eliksir Wiedzy"; then
                player_remove_item "Eliksir Wiedzy"
                printf "  %b✨ Czujesz przypływ wiedzy!%b\n" "${COLOR_ITEM}" "${RESET}"
                return 0
            else
                ui_error "Nie masz Eliksiru Wiedzy!"
                return 1
            fi
            ;;
        *)
            ui_error "Nieznany przedmiot: $item"
            return 1
            ;;
    esac
}

player_show_inventory() {
    echo
    printf "  %b=== Ekwipunek ===%b\n" "${BOLD_WHITE}" "${RESET}"
    if [[ ${#PLAYER_INVENTORY[@]} -eq 0 ]]; then
        printf "  %bPusty%b\n" "${DIM}" "${RESET}"
    else
        local counts=()
        local seen=()
        local item
        for item in "${PLAYER_INVENTORY[@]}"; do
            local found=false
            local j
            for j in "${!seen[@]}"; do
                if [[ "${seen[$j]}" == "$item" ]]; then
                    (( counts[$j]++ ))
                    found=true
                    break
                fi
            done
            if [[ "$found" == "false" ]]; then
                seen+=("$item")
                counts+=(1)
            fi
        done
        for j in "${!seen[@]}"; do
            printf "  %b%-25s%b x%d\n" "${COLOR_ITEM}" "${seen[$j]}" "${RESET}" "${counts[$j]}"
        done
    fi
    printf "  %bZłoto: %d%b\n" "${COLOR_GOLD}" "$PLAYER_GOLD" "${RESET}"
    echo
}

# ──────────────────────────────────────────────────────────────────────────────
# Display full stats
# ──────────────────────────────────────────────────────────────────────────────

player_show_stats() {
    echo
    ui_hr "─"
    printf "  %b%-12s%b %s\n" "${BOLD_WHITE}" "Imię:"    "${RESET}" "$PLAYER_NAME"
    printf "  %b%-12s%b %d\n" "${BOLD_WHITE}" "Poziom:"  "${RESET}" "$PLAYER_LEVEL"
    printf "  %b%-12s%b %d / %d\n" "${BOLD_WHITE}" "PŻ:"     "${RESET}" "$PLAYER_HP" "$PLAYER_MAX_HP"
    printf "  %b%-12s%b %d / %d\n" "${BOLD_WHITE}" "PD:"     "${RESET}" "$PLAYER_XP" "$PLAYER_XP_NEXT"
    printf "  %b%-12s%b %d\n" "${BOLD_WHITE}" "Atak:"    "${RESET}" "$PLAYER_ATTACK"
    printf "  %b%-12s%b %d\n" "${BOLD_WHITE}" "Obrona:"  "${RESET}" "$PLAYER_DEFENSE"
    printf "  %b%-12s%b %d\n" "${BOLD_WHITE}" "Złoto:"   "${RESET}" "$PLAYER_GOLD"
    printf "  %b%-12s%b %d\n" "${BOLD_WHITE}" "Obszar:"  "${RESET}" "$CURRENT_LEVEL"
    ui_hr "─"
    player_show_inventory
}
