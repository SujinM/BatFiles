#!/bin/bash
# ========================================
# Quick Backup Utility for Mac
# Backs up specified folder with timestamp
# ========================================

clear
echo "========================================"
echo "     QUICK BACKUP UTILITY (Mac)"
echo "========================================"
echo ""

# Set source folder (change this to your needs)
SOURCE="$HOME/Documents"

# Set backup destination
BACKUP_ROOT="$HOME/Backups"

# Create timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup folder
BACKUP_DEST="$BACKUP_ROOT/Backup_$TIMESTAMP"

echo "Source: $SOURCE"
echo "Destination: $BACKUP_DEST"
echo ""

if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source folder does not exist!"
    read -p "Press Enter to exit..."
    exit 1
fi

echo "Creating backup folder..."
mkdir -p "$BACKUP_DEST"

echo "Copying files..."
cp -R "$SOURCE"/* "$BACKUP_DEST"

echo ""
echo "========================================"
echo "Backup completed successfully!"
echo "Location: $BACKUP_DEST"
echo "========================================"
read -p "Press Enter to continue..."
