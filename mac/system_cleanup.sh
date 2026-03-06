#!/bin/bash
# ========================================
# System Cleanup Utility for Mac
# Cleans temporary files and system cache
# ========================================

echo "========================================"
echo "     SYSTEM CLEANUP UTILITY (Mac)"
echo "========================================"
echo ""

echo "[1/5] Cleaning user cache..."
rm -rf ~/Library/Caches/* 2>/dev/null
echo "Done!"

echo "[2/5] Cleaning system logs..."
sudo rm -rf /private/var/log/* 2>/dev/null
echo "Done!"

echo "[3/5] Emptying Trash..."
rm -rf ~/.Trash/* 2>/dev/null
echo "Done!"

echo "[4/5] Cleaning download history..."
rm -f ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 2>/dev/null
echo "Done!"

echo "[5/5] Cleaning system temp files..."
sudo rm -rf /private/var/tmp/* 2>/dev/null
echo "Done!"

echo ""
echo "========================================"
echo "Cleanup Complete!"
echo "========================================"
read -p "Press Enter to continue..."
