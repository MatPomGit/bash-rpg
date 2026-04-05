#!/usr/bin/env bash
# lib/combat.sh – Turn-based combat engine

# shellcheck source=lib/ui.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/colors.sh"
source "${SCRIPT_DIR}/ui.sh"
source "${SCRIPT_DIR}/player.sh"
source "${SCRIPT_DIR}/challenges.sh"

# ──────────────────────────────────────────────────────────────────────────────
# Enemy definition helpers
# ──────────────────────────────────────────────────────────────────────────────

# Global enemy state set before combat_start
ENEMY_NAME=""
ENEMY_HP=0
ENEMY_MAX_HP=0
ENEMY_ATTACK=0
ENEMY_CATEGORY=""
ENEMY_DESCRIPTION=""
ENEMY_VICTORY_MSG=""
ENEMY_XP_REWARD=0
ENEMY_GOLD_REWARD=0
ENEMY_ITEM_REWARD=""   # empty = no item

# Define an enemy (call before combat_start)
enemy_set() {
    ENEMY_NAME="$1"
    ENEMY_MAX_HP="$2"
    ENEMY_HP="$2"
    ENEMY_ATTACK="$3"
    ENEMY_CATEGORY="$4"      # challenge category
    ENEMY_DESCRIPTION="$5"
    ENEMY_VICTORY_MSG="$6"
    ENEMY_XP_REWARD="$7"
    ENEMY_GOLD_REWARD="$8"
    ENEMY_ITEM_REWARD="${9:-}"
}

# ──────────────────────────────────────────────────────────────────────────────
# Combat loop
# ──────────────────────────────────────────────────────────────────────────────

# Returns 0 if player wins, 1 if player dies/flees
combat_start() {
    local used_challenges=""
    local turn=1
    local fled=false

    ui_clear
    ui_combat_banner "$ENEMY_NAME"
    echo
    printf "  %b%s%b\n" "${COLOR_STORY}" "$ENEMY_DESCRIPTION" "${RESET}"
    echo
    press_enter

    while true; do
        # Draw status
        ui_clear
        ui_combat_banner "$ENEMY_NAME"
        ui_player_status
        echo
        ui_enemy_status "$ENEMY_NAME" "$ENEMY_HP" "$ENEMY_MAX_HP"
        echo
        ui_hr "─"
        printf "  %bTurn %d%b\n" "${DIM}" "$turn" "${RESET}"
        ui_hr "─"

        # Combat menu
        echo
        printf "  %b[1]%b Attack (answer a Bash challenge)\n" "${BOLD_CYAN}" "${RESET}"
        printf "  %b[2]%b Use item\n" "${BOLD_CYAN}" "${RESET}"
        printf "  %b[3]%b Show inventory\n" "${BOLD_CYAN}" "${RESET}"
        printf "  %b[4]%b Flee (lose 20 HP)\n" "${BOLD_CYAN}" "${RESET}"
        echo
        ui_prompt "Your choice: "
        local choice
        read -r choice

        case "$choice" in
            1)
                combat_player_attack "$used_challenges"
                local attack_result=$?
                # attack_result: 0=correct, 1=wrong, used CHALLENGE_IDX already updated
                used_challenges="$used_challenges $CHALLENGE_IDX"

                if [[ $attack_result -eq 0 ]]; then
                    # Player dealt damage
                    if [[ $ENEMY_HP -le 0 ]]; then
                        combat_victory
                        return 0
                    fi
                fi

                # Enemy counter-attacks
                combat_enemy_attack
                ;;
            2)
                combat_use_item
                # Enemy still attacks after item use
                combat_enemy_attack
                ;;
            3)
                player_show_inventory
                press_enter
                continue
                ;;
            4)
                printf "\n  %bYou flee! The enemy deals a parting blow...%b\n" "${COLOR_WARNING}" "${RESET}"
                player_damage $(( ENEMY_ATTACK * 2 ))
                fled=true
                ;;
            *)
                ui_error "Invalid choice."
                continue
                ;;
        esac

        # Check player death
        if player_is_dead; then
            combat_defeat
            return 1
        fi

        # Check flee
        if $fled; then
            return 1
        fi

        (( turn++ ))
    done
}

# ──────────────────────────────────────────────────────────────────────────────
# Attack: challenge-based
# ──────────────────────────────────────────────────────────────────────────────

combat_player_attack() {
    local used="$1"
    challenges_get_random "$ENEMY_CATEGORY" "$used"

    echo
    ui_hr "─"
    printf "  %b⚔  CHALLENGE:%b\n" "${BOLD_YELLOW}" "${RESET}"
    printf "  %b%s%b\n\n" "${BOLD_WHITE}" "$CHALLENGE_QUESTION" "${RESET}"
    ui_prompt "Your answer: "
    local answer
    read -r answer

    if challenges_check_answer "$answer" "$CHALLENGE_ANSWERS"; then
        local dmg=$(( PLAYER_ATTACK + RANDOM % 5 ))
        ENEMY_HP=$(( ENEMY_HP - dmg ))
        [[ $ENEMY_HP -lt 0 ]] && ENEMY_HP=0
        printf "\n  %b✔ Correct!%b  You strike for %b%d damage%b!\n" \
            "${COLOR_SUCCESS}" "${RESET}" "${BOLD_RED}" "$dmg" "${RESET}"
        printf "  %b%s%b\n" "${DIM}" "$CHALLENGE_EXPLAIN" "${RESET}"
        sleep 1
        return 0
    else
        printf "\n  %b✘ Wrong!%b  The correct answer was: %b%s%b\n" \
            "${COLOR_ERROR}" "${RESET}" "${COLOR_COMMAND}" \
            "$(echo "$CHALLENGE_ANSWERS" | cut -d"${SEP}" -f1)" "${RESET}"
        printf "  %b%s%b\n" "${DIM}" "$CHALLENGE_EXPLAIN" "${RESET}"
        printf "  %bYou miss this turn!%b\n" "${COLOR_WARNING}" "${RESET}"
        sleep 1
        return 1
    fi
}

# ──────────────────────────────────────────────────────────────────────────────
# Enemy attacks player
# ──────────────────────────────────────────────────────────────────────────────

combat_enemy_attack() {
    local dmg=$(( ENEMY_ATTACK + RANDOM % 5 ))
    printf "\n  %b%s attacks you!%b\n" "${COLOR_ENEMY}" "$ENEMY_NAME" "${RESET}"
    player_damage "$dmg"
    [[ "${BASH_RPG_TESTING:-}" == "1" ]] || sleep 0.5
}

# ──────────────────────────────────────────────────────────────────────────────
# Item use during combat
# ──────────────────────────────────────────────────────────────────────────────

combat_use_item() {
    if [[ ${#PLAYER_INVENTORY[@]} -eq 0 ]]; then
        ui_warning "Your inventory is empty!"
        return
    fi
    player_show_inventory
    ui_prompt "Use which item? "
    local item_name
    read -r item_name
    player_use_item "$item_name"
}

# ──────────────────────────────────────────────────────────────────────────────
# Outcome screens
# ──────────────────────────────────────────────────────────────────────────────

combat_victory() {
    echo
    ui_hr "═"
    ui_center "${COLOR_SUCCESS}  ★  VICTORY!  ★  ${RESET}"
    ui_hr "═"
    echo
    printf "  %b%s%b\n\n" "${COLOR_STORY}" "$ENEMY_VICTORY_MSG" "${RESET}"

    player_add_xp "$ENEMY_XP_REWARD"
    PLAYER_GOLD=$(( PLAYER_GOLD + ENEMY_GOLD_REWARD ))
    ui_gold_gain "$ENEMY_GOLD_REWARD"

    if [[ -n "$ENEMY_ITEM_REWARD" ]]; then
        player_add_item "$ENEMY_ITEM_REWARD"
    fi
    echo
    press_enter
}

combat_defeat() {
    echo
    ui_hr "═"
    ui_center "${COLOR_ERROR}  ✝  YOU HAVE FALLEN  ✝  ${RESET}"
    ui_hr "═"
    echo
    printf "  %bYour journey ends here... for now.%b\n" "${COLOR_STORY}" "${RESET}"
    printf "  %bBut a true Bash warrior never gives up!%b\n\n" "${COLOR_STORY}" "${RESET}"
    press_enter
}
