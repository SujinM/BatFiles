#!/bin/bash
# ========================================
# System Information Display for Mac
# Shows comprehensive system details
# ========================================

clear
echo "========================================"
echo "   SYSTEM INFORMATION REPORT (Mac)"
echo "========================================"
echo ""

echo "[Computer Name]"
echo "----------------------------------------"
hostname
echo ""

echo "[Operating System]"
echo "----------------------------------------"
sw_vers
echo ""

echo "[Processor]"
echo "----------------------------------------"
sysctl -n machdep.cpu.brand_string
echo "Cores: $(sysctl -n hw.ncpu)"
echo ""

echo "[Memory]"
echo "----------------------------------------"
echo "Total RAM: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}') GB"
vm_stat | head -5
echo ""

echo "[Disk Drives]"
echo "----------------------------------------"
df -h | grep -E '^/dev/'
echo ""

echo "[System Uptime]"
echo "----------------------------------------"
uptime
echo ""

echo "[Mac Model]"
echo "----------------------------------------"
system_profiler SPHardwareDataType | grep "Model"
echo ""

echo "========================================"
echo "Report Complete"
echo "========================================"
read -p "Press Enter to continue..."
