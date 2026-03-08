#!/bin/bash
# ========================================
# System Information Display for Linux
# Shows comprehensive system details
# ========================================

clear
echo "========================================"
echo "   SYSTEM INFORMATION REPORT (Linux)"
echo "========================================"
echo ""

echo "[Computer Name]"
echo "----------------------------------------"
hostname
echo ""

echo "[Operating System]"
echo "----------------------------------------"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "OS Name:    $NAME"
    echo "Version:    $VERSION"
    echo "Kernel:     $(uname -r)"
elif command -v lsb_release &>/dev/null; then
    lsb_release -a 2>/dev/null
else
    uname -a
fi
echo ""

echo "[Processor]"
echo "----------------------------------------"
CPU=$(grep -m1 "Model name\|model name\|Hardware\|^Model" /proc/cpuinfo 2>/dev/null | cut -d: -f2 | xargs)
[ -z "$CPU" ] && CPU=$(uname -m)
echo "CPU:   $CPU"
echo "Cores: $(nproc)"
echo ""

echo "[Memory]"
echo "----------------------------------------"
TOTAL=$(grep MemTotal /proc/meminfo | awk '{printf "%.1f GB", $2/1024/1024}')
echo "Total RAM: $TOTAL"
free -h | awk 'NR==1{print "               "$0} NR==2{print "Memory:        "$0} NR==3{print "Swap:          "$0}'
echo ""

echo "[Disk Drives]"
echo "----------------------------------------"
df -h | grep -E '^/dev/'
echo ""

echo "[System Uptime]"
echo "----------------------------------------"
uptime
echo ""

echo "[Hardware Model]"
echo "----------------------------------------"
if [ -f /proc/device-tree/model ]; then
    tr -d '\0' < /proc/device-tree/model && echo
elif command -v dmidecode &>/dev/null; then
    dmidecode -s system-product-name 2>/dev/null
else
    echo "$(uname -m) architecture"
fi
echo ""

echo "========================================"
echo "Report Complete"
echo "========================================"
read -p "Press Enter to continue..."
