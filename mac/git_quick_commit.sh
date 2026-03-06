#!/bin/bash
# ========================================
# Git Quick Commit Tool for Mac
# Quickly stage, commit and push changes
# ========================================

clear
echo "========================================"
echo "     GIT QUICK COMMIT TOOL (Mac)"
echo "========================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "ERROR: Git is not installed!"
    read -p "Press Enter to exit..."
    exit 1
fi

# Check if current directory is a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "ERROR: Current directory is not a Git repository!"
    read -p "Press Enter to exit..."
    exit 1
fi

echo "Current Git Status:"
echo "----------------------------------------"
git status -s
echo ""

echo "----------------------------------------"
read -p "Enter commit message: " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    echo "ERROR: Commit message cannot be empty!"
    read -p "Press Enter to exit..."
    exit 1
fi

echo ""
echo "[1/3] Staging all changes..."
git add -A

echo "[2/3] Committing changes..."
git commit -m "$COMMIT_MSG"

echo "[3/3] Pushing to remote..."
git push

echo ""
echo "========================================"
echo "Git operations completed!"
echo "========================================"
read -p "Press Enter to continue..."
