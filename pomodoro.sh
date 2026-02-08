#!/bin/bash

# Simple Pomodoro Timer CLI with Progress Bar and Colors
# Usage: ./pomodoro.sh [work_minutes] [break_minutes]
#
# INSTALLATION (Ubuntu):
#   1. sudo cp pomodoro.sh /usr/local/bin/pomodoro
#   2. sudo chmod +x /usr/local/bin/pomodoro
#   3. Type 'pomodoro' from anywhere to use!

WORK_MINUTES=${1:-25}
BREAK_MINUTES=${2:-5}

WORK_SECONDS=$((WORK_MINUTES * 60))
BREAK_SECONDS=$((BREAK_MINUTES * 60))

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

format_time() {
    local seconds=$1
    local mins=$((seconds / 60))
    local secs=$((seconds % 60))
    printf "%02d:%02d" $mins $secs
}

progress_bar() {
    local current=$1
    local total=$2
    local width=20
    local filled=$(( (current * width) / total ))
    local empty=$((width - filled))
    
    printf "["
    for ((i=0; i<filled; i++)); do
        printf "="
    done
    for ((i=0; i<empty; i++)); do
        printf " "
    done
    printf "]"
}

countdown() {
    local duration=$1
    local label=$2
    local color=$3
    local remaining=$duration
    local elapsed=0
    
    while [ $remaining -gt 0 ]; do
        local percent=$(( (elapsed * 100) / duration ))
        printf "\r${color}${BOLD}%s${NC} %s ${CYAN}%s${NC} ${YELLOW}(%d%%)${NC}" \
            "$label" "$(progress_bar $elapsed $duration)" "$(format_time $remaining)" "$percent"
        sleep 1
        remaining=$((remaining - 1))
        elapsed=$((elapsed + 1))
    done
    printf "\r${color}${BOLD}%s${NC} %s ${CYAN}00:00${NC} ${YELLOW}(100%%)${NC}\n" \
        "$label" "$(progress_bar $duration $duration)"
}

play_sound() {
    if command -v paplay >/dev/null 2>&1; then
        echo -e '\a'
    elif command -v powershell >/dev/null 2>&1; then
        powershell -c "[console]::beep(800, 500)" 2>/dev/null || echo -e '\a'
    else
        echo -e '\a'
    fi
}

clear_screen() {
    printf "\033[2J\033[H"
}

# Clear screen and show header
clear_screen
echo -e "${CYAN}==================================${NC}"
echo -e "${BOLD}       POMODORO TIMER${NC}"
echo -e "${CYAN}==================================${NC}"
echo -e "${GREEN}Work:${NC} ${WORK_MINUTES} min ${BLUE}|${NC} ${YELLOW}Break:${NC} ${BREAK_MINUTES} min"
echo -e "${CYAN}==================================${NC}"
echo -e "Press ${RED}Ctrl+C${NC} to stop"
echo ""

session=1
trap 'echo -e "\n\n${RED}Timer stopped!${NC}"; exit 0' INT

while true; do
    echo -e "${BOLD}--- Session #$session ---${NC}"
    
    # Work session
    countdown $WORK_SECONDS "  Work  " "$GREEN"
    play_sound
    echo -e "  ${GREEN}Work session complete!${NC} Take a break."
    echo ""
    
    # Break session
    countdown $BREAK_SECONDS "  Break " "$YELLOW"
    play_sound
    echo -e "  ${YELLOW}Break over!${NC} Ready to work?"
    echo ""
    
    session=$((session + 1))
done
