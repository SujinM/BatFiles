#!/bin/bash
# ========================================
# Port Scanner
# Check which ports are in use and by which process
# ========================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

show_menu() {
    clear
    echo -e "${CYAN}========================================"
    echo -e "           PORT SCANNER"
    echo -e "========================================${RESET}"
    echo ""
    echo "1. Show All Listening Ports"
    echo "2. Check Specific Port"
    echo "3. Show All Ports by Process"
    echo "4. Find Process Using Port"
    echo "5. Show Common Ports Status"
    echo "6. Scan Port Range"
    echo "7. Exit"
    echo ""
    echo -e "${CYAN}========================================${RESET}"
    echo -n "Enter your choice (1-7): "
}

show_all_listening() {
    clear
    echo -e "${BOLD}All Listening Ports:${RESET}"
    echo "----------------------------------------"
    sudo lsof -iTCP -sTCP:LISTEN -n -P 2>/dev/null | awk 'NR==1 || /LISTEN/' | column -t
    echo ""
    read -p "Press Enter to return to menu..."
}

check_specific_port() {
    clear
    echo -e "${CYAN}========================================"
    echo "       Check Specific Port"
    echo -e "========================================${RESET}"
    echo ""
    read -p "Enter port number: " PORT
    [[ -z "$PORT" ]] && return

    if ! [[ "$PORT" =~ ^[0-9]+$ ]] || (( PORT < 1 || PORT > 65535 )); then
        echo -e "${RED}Invalid port number. Must be between 1 and 65535.${RESET}"
        read -p "Press Enter to return to menu..."
        return
    fi

    echo ""
    echo -e "Checking port ${YELLOW}${PORT}${RESET}..."
    echo "----------------------------------------"
    RESULT=$(sudo lsof -iTCP:"$PORT" -iTCP:"$PORT" -n -P 2>/dev/null)
    UDP_RESULT=$(sudo lsof -iUDP:"$PORT" -n -P 2>/dev/null)

    if [[ -n "$RESULT" ]]; then
        echo -e "${GREEN}TCP connections on port $PORT:${RESET}"
        echo "$RESULT" | column -t
    else
        echo -e "${YELLOW}No TCP connections found on port $PORT.${RESET}"
    fi

    echo ""
    if [[ -n "$UDP_RESULT" ]]; then
        echo -e "${GREEN}UDP on port $PORT:${RESET}"
        echo "$UDP_RESULT" | column -t
    fi

    echo ""
    read -p "Press Enter to return to menu..."
}

show_by_process() {
    clear
    echo -e "${BOLD}All Open Ports by Process:${RESET}"
    echo "----------------------------------------"
    sudo lsof -i -n -P 2>/dev/null | grep -E 'LISTEN|ESTABLISHED' | \
        awk '{print $1, $2, $8, $9}' | column -t
    echo ""
    read -p "Press Enter to return to menu..."
}

find_process_on_port() {
    clear
    echo -e "${CYAN}========================================"
    echo "     Find Process Using Port"
    echo -e "========================================${RESET}"
    echo ""
    read -p "Enter port number: " PORT
    [[ -z "$PORT" ]] && return

    if ! [[ "$PORT" =~ ^[0-9]+$ ]] || (( PORT < 1 || PORT > 65535 )); then
        echo -e "${RED}Invalid port number. Must be between 1 and 65535.${RESET}"
        read -p "Press Enter to return to menu..."
        return
    fi

    echo ""
    echo -e "Finding process on port ${YELLOW}${PORT}${RESET}..."
    echo "----------------------------------------"
    RESULT=$(sudo lsof -i :"$PORT" -n -P 2>/dev/null)
    if [[ -n "$RESULT" ]]; then
        echo "$RESULT" | column -t
        echo ""
        # Show process details
        PID=$(sudo lsof -ti :"$PORT" 2>/dev/null | head -1)
        if [[ -n "$PID" ]]; then
            echo -e "${GREEN}Process details (PID: $PID):${RESET}"
            ps -p "$PID" -o pid,user,comm,args 2>/dev/null
        fi
    else
        echo -e "${YELLOW}No process found using port $PORT.${RESET}"
    fi
    echo ""
    read -p "Press Enter to return to menu..."
}

check_port_status() {
    local port=$1
    local label=$2
    local result
    result=$(sudo lsof -iTCP:"$port" -sTCP:LISTEN -n -P 2>/dev/null | grep -v COMMAND)
    if [[ -n "$result" ]]; then
        local proc
        proc=$(echo "$result" | awk '{print $1}' | head -1)
        echo -e "  Port ${YELLOW}${port}${RESET} ${label}: ${GREEN}IN USE${RESET} by $proc"
    else
        echo -e "  Port ${YELLOW}${port}${RESET} ${label}: ${RED}not in use${RESET}"
    fi
}

show_common_ports() {
    clear
    echo -e "${BOLD}Common Ports Status:${RESET}"
    echo "----------------------------------------"
    check_port_status 22    "(SSH)"
    check_port_status 80    "(HTTP)"
    check_port_status 443   "(HTTPS)"
    check_port_status 3000  "(Dev Server)"
    check_port_status 3306  "(MySQL)"
    check_port_status 5000  "(Flask / Dev)"
    check_port_status 5432  "(PostgreSQL)"
    check_port_status 6379  "(Redis)"
    check_port_status 8080  "(Alt HTTP)"
    check_port_status 8443  "(Alt HTTPS)"
    check_port_status 27017 "(MongoDB)"
    echo ""
    read -p "Press Enter to return to menu..."
}

scan_port_range() {
    clear
    echo -e "${CYAN}========================================"
    echo "         Scan Port Range"
    echo -e "========================================${RESET}"
    echo ""
    read -p "Enter start port: " START
    read -p "Enter end port:   " END

    if ! [[ "$START" =~ ^[0-9]+$ && "$END" =~ ^[0-9]+$ ]] || \
       (( START < 1 || END > 65535 || START > END )); then
        echo -e "${RED}Invalid range. Ports must be 1–65535 and start <= end.${RESET}"
        read -p "Press Enter to return to menu..."
        return
    fi

    if (( END - START > 1000 )); then
        read -p "Scanning ${END-START+1} ports may take a while. Continue? (y/n): " CONFIRM
        [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]] && return
    fi

    read -p "Enter target host (default: localhost): " HOST
    HOST="${HOST:-localhost}"

    echo ""
    echo -e "Scanning ${YELLOW}${HOST}${RESET} ports ${YELLOW}${START}${RESET}–${YELLOW}${END}${RESET}..."
    echo "----------------------------------------"

    OPEN_PORTS=()
    for (( port=START; port<=END; port++ )); do
        if (command -v nc &>/dev/null); then
            if nc -z -G1 -w1 "$HOST" "$port" 2>/dev/null; then
                echo -e "  ${GREEN}Port $port OPEN${RESET}"
                OPEN_PORTS+=("$port")
            fi
        else
            # Fallback using /dev/tcp (works on bash)
            (echo >/dev/tcp/"$HOST"/"$port") 2>/dev/null && {
                echo -e "  ${GREEN}Port $port OPEN${RESET}"
                OPEN_PORTS+=("$port")
            }
        fi
    done

    echo ""
    if (( ${#OPEN_PORTS[@]} == 0 )); then
        echo -e "${YELLOW}No open ports found in range $START–$END on $HOST.${RESET}"
    else
        echo -e "${GREEN}Found ${#OPEN_PORTS[@]} open port(s): ${OPEN_PORTS[*]}${RESET}"
    fi
    echo ""
    read -p "Press Enter to return to menu..."
}

# ── Main loop ──────────────────────────────────────────────
while true; do
    show_menu
    read -r CHOICE
    case "$CHOICE" in
        1) show_all_listening ;;
        2) check_specific_port ;;
        3) show_by_process ;;
        4) find_process_on_port ;;
        5) show_common_ports ;;
        6) scan_port_range ;;
        7) echo "Goodbye!"; exit 0 ;;
        *) echo -e "${RED}Invalid choice. Please enter 1–7.${RESET}"; sleep 1 ;;
    esac
done
