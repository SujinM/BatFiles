#!/bin/bash
# ========================================
# Process Killer Utility for Mac
# Terminate processes by name or PID
# ========================================

while true; do
    clear
    echo "========================================"
    echo "     PROCESS KILLER UTILITY (Mac)"
    echo "========================================"
    echo ""
    echo "1. View Running Processes"
    echo "2. Kill Process by Name"
    echo "3. Kill Process by PID"
    echo "4. Exit"
    echo ""
    echo "========================================"
    read -p "Enter your choice (1-4): " CHOICE

    case $CHOICE in
        1)
            clear
            echo "Current Running Processes:"
            echo "----------------------------------------"
            ps aux | head -20
            echo ""
            read -p "Press Enter to continue..."
            ;;
        2)
            clear
            echo "========================================"
            echo "Kill Process by Name"
            echo "========================================"
            echo ""
            read -p "Enter process name: " PNAME
            if [ -n "$PNAME" ]; then
                echo ""
                echo "Attempting to kill: $PNAME"
                killall "$PNAME" 2>/dev/null
                if [ $? -eq 0 ]; then
                    echo "Process killed successfully!"
                else
                    echo "ERROR: Could not kill process!"
                fi
            fi
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            echo "========================================"
            echo "Kill Process by PID"
            echo "========================================"
            echo ""
            read -p "Enter Process ID: " PID
            if [ -n "$PID" ]; then
                echo ""
                echo "Attempting to kill PID: $PID"
                kill -9 "$PID" 2>/dev/null
                if [ $? -eq 0 ]; then
                    echo "Process killed successfully!"
                else
                    echo "ERROR: Could not kill process!"
                fi
            fi
            read -p "Press Enter to continue..."
            ;;
        4)
            exit 0
            ;;
    esac
done
