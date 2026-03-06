#!/bin/bash
# ========================================
# Network Information Display for Mac
# Shows detailed network configuration
# ========================================

clear
echo "========================================"
echo "   NETWORK INFORMATION TOOL (Mac)"
echo "========================================"
echo ""

echo "[Network Interfaces]"
echo "----------------------------------------"
ifconfig | grep -A 3 "flags"
echo ""

echo "[Active Connections]"
echo "----------------------------------------"
netstat -an | grep ESTABLISHED | head -20
echo ""

echo "[DNS Configuration]"
echo "----------------------------------------"
scutil --dns | grep 'nameserver'
echo ""

echo "[WiFi Information]"
echo "----------------------------------------"
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I
echo ""

echo "[Public IP Address]"
echo "----------------------------------------"
curl -s https://api.ipify.org
echo ""
echo ""

echo "========================================"
read -p "Press any key to exit..."
