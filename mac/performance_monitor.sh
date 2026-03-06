#!/bin/bash
# ========================================
# Performance Monitor for Mac
# Monitor CPU, Memory, and Disk usage
# ========================================

while true; do
    clear
    echo "========================================"
    echo "    PERFORMANCE MONITOR (Mac)"
    echo "========================================"
    echo ""
    echo "1. Quick System Overview"
    echo "2. CPU Information"
    echo "3. Memory Usage"
    echo "4. Disk Usage"
    echo "5. Top Processes by CPU"
    echo "6. Top Processes by Memory"
    echo "7. Continuous Monitoring (5 sec refresh)"
    echo "8. Exit"
    echo ""
    echo "========================================"
    read -p "Enter your choice (1-8): " CHOICE

    case $CHOICE in
        1)
            clear
            echo "System Performance Overview:"
            echo "========================================"
            echo ""
            echo "[CPU Usage]"
            top -l 1 | grep "CPU usage"
            echo ""
            echo "[Memory Usage]"
            vm_stat | head -5
            echo ""
            echo "[Disk Usage]"
            df -h | grep -E '^/dev/'
            echo ""
            read -p "Press Enter to continue..."
            ;;
        2)
            clear
            echo "CPU Information:"
            echo "========================================"
            sysctl -n machdep.cpu.brand_string
            echo "Cores: $(sysctl -n hw.ncpu)"
            echo "Physical Cores: $(sysctl -n hw.physicalcpu)"
            echo ""
            echo "Current Usage:"
            top -l 2 | grep "CPU usage" | tail -1
            echo ""
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            echo "Memory Usage:"
            echo "========================================"
            echo "Total RAM: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}') GB"
            echo ""
            vm_stat
            echo ""
            read -p "Press Enter to continue..."
            ;;
        4)
            clear
            echo "Disk Usage:"
            echo "========================================"
            df -h
            echo ""
            read -p "Press Enter to continue..."
            ;;
        5)
            clear
            echo "Top 10 Processes by CPU Usage:"
            echo "========================================"
            ps aux | sort -nrk 3,3 | head -11
            echo ""
            read -p "Press Enter to continue..."
            ;;
        6)
            clear
            echo "Top 10 Processes by Memory Usage:"
            echo "========================================"
            ps aux | sort -nrk 4,4 | head -11
            echo ""
            read -p "Press Enter to continue..."
            ;;
        7)
            while true; do
                clear
                echo "========================================"
                echo "Continuous Performance Monitoring"
                echo "Press Ctrl+C to stop"
                echo "========================================"
                echo ""
                CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}')
                MEM=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
                DISK=$(df -h / | tail -1 | awk '{print $5}')
                echo "Time: $(date '+%H:%M:%S')"
                echo ""
                echo "CPU Usage: $CPU"
                echo "Disk / Usage: $DISK"
                echo ""
                sleep 5
            done
            ;;
        8)
            exit 0
            ;;
    esac
done
