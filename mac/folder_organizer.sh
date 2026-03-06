#!/bin/bash
# ========================================
# Folder Organizer for Mac
# Organizes files by extension into folders
# ========================================

clear
echo "========================================"
echo "     FOLDER ORGANIZER (Mac)"
echo "========================================"
echo ""

TARGET=$(pwd)

echo "Target Folder: $TARGET"
echo ""
echo "This will organize files by extension."
read -p "Press Enter to continue or Ctrl+C to cancel..."

echo ""
echo "Organizing files..."
echo ""

# Create folders for common file types
mkdir -p "$TARGET/Images"
mkdir -p "$TARGET/Documents"
mkdir -p "$TARGET/Videos"
mkdir -p "$TARGET/Music"
mkdir -p "$TARGET/Archives"
mkdir -p "$TARGET/Executables"
mkdir -p "$TARGET/Others"

# Move image files
echo "Moving image files..."
mv "$TARGET"/*.{jpg,jpeg,png,gif,bmp,svg} "$TARGET/Images/" 2>/dev/null

# Move document files
echo "Moving document files..."
mv "$TARGET"/*.{pdf,doc,docx,txt,xls,xlsx,ppt,pptx,pages,numbers,key} "$TARGET/Documents/" 2>/dev/null

# Move video files
echo "Moving video files..."
mv "$TARGET"/*.{mp4,avi,mkv,mov,wmv} "$TARGET/Videos/" 2>/dev/null

# Move music files
echo "Moving music files..."
mv "$TARGET"/*.{mp3,wav,flac,m4a,aac} "$TARGET/Music/" 2>/dev/null

# Move archive files
echo "Moving archive files..."
mv "$TARGET"/*.{zip,rar,7z,tar,gz,dmg} "$TARGET/Archives/" 2>/dev/null

# Move executable files
echo "Moving executable files..."
mv "$TARGET"/*.{app,pkg,dmg} "$TARGET/Executables/" 2>/dev/null

echo ""
echo "========================================"
echo "Organization Complete!"
echo "========================================"
read -p "Press Enter to continue..."
