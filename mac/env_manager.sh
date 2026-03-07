#!/bin/bash
# ========================================
# Environment Variables Manager for macOS
# View and manage environment variables
# ========================================

# Colors for terminal output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display menu
show_menu() {
    clear
    echo -e "${CYAN}========================================"
    echo "   ENVIRONMENT VARIABLES MANAGER"
    echo "======================================${NC}"
    echo ""
    echo "1. Show All Environment Variables"
    echo "2. Show Shell Variables"
    echo "3. Show Exported Variables"
    echo "4. Show Specific Variable"
    echo "5. Show PATH Variable (Formatted)"
    echo "6. Export Variables to File"
    echo "7. Search Variables by Name"
    echo "8. Show Common System Variables"
    echo "9. Exit"
    echo ""
    echo "========================================"
    read -p "Enter your choice (1-9): " choice
    echo ""
}

# Function to show all environment variables
show_all() {
    clear
    echo -e "${GREEN}All Environment Variables:${NC}"
    echo "----------------------------------------"
    printenv | sort
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show shell variables
show_shell() {
    clear
    echo -e "${GREEN}Shell Variables (including environment):${NC}"
    echo "----------------------------------------"
    set | sort
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show exported variables
show_exported() {
    clear
    echo -e "${GREEN}Exported Environment Variables:${NC}"
    echo "----------------------------------------"
    export -p | sort
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show specific variable
show_specific() {
    clear
    echo "========================================"
    echo "Show Specific Variable"
    echo "========================================"
    echo ""
    read -p "Enter variable name: " varname
    
    if [ -z "$varname" ]; then
        return
    fi
    
    echo ""
    echo -e "${GREEN}Value of $varname:${NC}"
    echo "----------------------------------------"
    
    # Check if variable exists
    if [ -z "${!varname}" ]; then
        echo -e "${YELLOW}Variable '$varname' is not set or is empty${NC}"
    else
        echo "${!varname}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show PATH variable formatted
show_path() {
    clear
    echo -e "${GREEN}PATH Variable (formatted):${NC}"
    echo "----------------------------------------"
    echo "Current PATH entries:"
    echo ""
    
    IFS=':' read -ra PATHS <<< "$PATH"
    for i in "${!PATHS[@]}"; do
        printf "%2d. %s\n" $((i+1)) "${PATHS[$i]}"
    done
    
    echo ""
    echo "----------------------------------------"
    echo "Total PATH entries: ${#PATHS[@]}"
    echo ""
    read -p "Press Enter to continue..."
}

# Function to export variables to file
export_to_file() {
    clear
    echo "========================================"
    echo "Export Variables to File"
    echo "========================================"
    echo ""
    
    export_file="$HOME/Desktop/environment_variables.txt"
    
    echo "Exporting environment variables to:"
    echo "$export_file"
    echo ""
    
    {
        echo "========================================="
        echo "ENVIRONMENT VARIABLES EXPORT"
        echo "Date: $(date)"
        echo "System: $(uname -a)"
        echo "========================================="
        echo ""
        echo "--- ENVIRONMENT VARIABLES ---"
        echo ""
        printenv | sort
        echo ""
        echo "--- PATH (formatted) ---"
        echo ""
        IFS=':' read -ra PATHS <<< "$PATH"
        for path in "${PATHS[@]}"; do
            echo "$path"
        done
    } > "$export_file"
    
    echo -e "${GREEN}Export complete!${NC}"
    echo "Location: $export_file"
    echo ""
    read -p "Press Enter to continue..."
}

# Function to search variables by name
search_variables() {
    clear
    echo "========================================"
    echo "Search Variables by Name"
    echo "========================================"
    echo ""
    read -p "Enter search term: " search_term
    
    if [ -z "$search_term" ]; then
        return
    fi
    
    echo ""
    echo -e "${GREEN}Variables matching '$search_term':${NC}"
    echo "----------------------------------------"
    
    printenv | grep -i "$search_term" | sort
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show common system variables
show_common() {
    clear
    echo -e "${GREEN}Common System Variables:${NC}"
    echo "----------------------------------------"
    echo ""
    
    vars=("HOME" "USER" "SHELL" "PATH" "PWD" "LANG" "TERM" "EDITOR" "TMPDIR" "LOGNAME")
    
    for var in "${vars[@]}"; do
        if [ ! -z "${!var}" ]; then
            printf "${CYAN}%-12s${NC}: %s\n" "$var" "${!var}"
        fi
    done
    
    echo ""
    echo "----------------------------------------"
    echo -e "${CYAN}macOS Specific:${NC}"
    echo ""
    
    if [ ! -z "$HOMEBREW_PREFIX" ]; then
        echo "HOMEBREW_PREFIX: $HOMEBREW_PREFIX"
    fi
    if [ ! -z "$JAVA_HOME" ]; then
        echo "JAVA_HOME: $JAVA_HOME"
    fi
    if [ ! -z "$PYTHONPATH" ]; then
        echo "PYTHONPATH: $PYTHONPATH"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Main loop
while true; do
    show_menu
    
    case $choice in
        1)
            show_all
            ;;
        2)
            show_shell
            ;;
        3)
            show_exported
            ;;
        4)
            show_specific
            ;;
        5)
            show_path
            ;;
        6)
            export_to_file
            ;;
        7)
            search_variables
            ;;
        8)
            show_common
            ;;
        9)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${YELLOW}Invalid option. Please try again.${NC}"
            sleep 1
            ;;
    esac
done
