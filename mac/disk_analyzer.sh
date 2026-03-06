#!/bin/bash
# ========================================
# Disk Space Analyzer for Mac
# Shows disk usage and large files
# ========================================

while true; do
    clear
    echo "========================================"
    echo "    DISK SPACE ANALYZER (Mac)"
    echo "========================================"
    echo ""
    echo "1. Show All Drives Space"
    echo "2. Find Large Files (over 100MB)"
    echo "3. Show Folder Sizes"
    echo "4. Exit"
    echo ""
    echo "========================================"
    read -p "Enter your choice (1-4): " CHOICE

    case $CHOICE in
        1)
            clear
            echo "Disk Space Information:"
            echo "----------------------------------------"
            df -h
            echo ""
            read -p "Press Enter to continue..."
            ;;
        2)
            clear
            echo "========================================"
            echo "Finding Large Files (over 100MB)"
            echo "========================================"
            echo ""
            read -p "Enter path to search (e.g., /Users/$USER): " SEARCH_PATH
            if [ -n "$SEARCH_PATH" ]; then
                echo ""
                echo "Searching for large files in $SEARCH_PATH..."
                echo "This may take a while..."
                echo "----------------------------------------"
                find "$SEARCH_PATH" -type f -size +100M -exec ls -lh {} \; 2>/dev/null | awk '{print $9, $5}' | head -20
            fi
            echo ""
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            echo "========================================"
            echo "Folder Sizes"
            echo "========================================"
            echo ""
            read -p "Enter folder path: " FOLDER_PATH
            if [ -n "$FOLDER_PATH" ] && [ -d "$FOLDER_PATH" ]; then
                echo ""
                echo "Calculating folder sizes in $FOLDER_PATH..."
                echo "----------------------------------------"
                du -sh "$FOLDER_PATH"/* 2>/dev/null | sort -hr | head -20
            else
                echo "Folder does not exist!"
            fi
            echo ""
            read -p "Press Enter to continue..."
            ;;
        4)
            exit 0
            ;;
    esac
done
