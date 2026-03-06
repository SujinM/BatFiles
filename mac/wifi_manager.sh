#!/bin/bash
# ========================================
# WiFi Manager for Mac
# Manage WiFi connections and profiles
# ========================================

while true; do
    clear
    echo "========================================"
    echo "        WIFI MANAGER (Mac)"
    echo "========================================"
    echo ""
    echo "1. Show Available WiFi Networks"
    echo "2. Show Current WiFi Information"
    echo "3. Show Saved WiFi Networks"
    echo "4. Connect to WiFi Network"
    echo "5. Disconnect from WiFi"
    echo "6. Turn WiFi On"
    echo "7. Turn WiFi Off"
    echo "8. Show WiFi Password (Keychain)"
    echo "9. Forget WiFi Network"
    echo "10. Exit"
    echo ""
    echo "========================================"
    read -p "Enter your choice (1-10): " CHOICE

    case $CHOICE in
        1)
            clear
            echo "Available WiFi Networks:"
            echo "----------------------------------------"
            /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s
            echo ""
            read -p "Press Enter to continue..."
            ;;
        2)
            clear
            echo "Current WiFi Information:"
            echo "----------------------------------------"
            /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I
            echo ""
            echo "IP Address:"
            ipconfig getifaddr en0 2>/dev/null || echo "Not connected to WiFi"
            echo ""
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            echo "Saved WiFi Networks:"
            echo "----------------------------------------"
            networksetup -listpreferredwirelessnetworks en0
            echo ""
            read -p "Press Enter to continue..."
            ;;
        4)
            clear
            echo "========================================"
            echo "Connect to WiFi Network"
            echo "========================================"
            echo ""
            read -p "Enter WiFi network name (SSID): " SSID
            if [ -n "$SSID" ]; then
                echo ""
                read -s -p "Enter password (leave empty if no password): " PASSWORD
                echo ""
                echo ""
                if [ -n "$PASSWORD" ]; then
                    echo "Connecting to $SSID..."
                    networksetup -setairportnetwork en0 "$SSID" "$PASSWORD"
                else
                    echo "Connecting to $SSID (no password)..."
                    networksetup -setairportnetwork en0 "$SSID"
                fi
                
                if [ $? -eq 0 ]; then
                    echo "Successfully connected!"
                else
                    echo "Failed to connect. Check SSID and password."
                fi
            fi
            echo ""
            read -p "Press Enter to continue..."
            ;;
        5)
            clear
            echo "Disconnecting from WiFi..."
            sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z
            echo "Disconnected!"
            echo ""
            read -p "Press Enter to continue..."
            ;;
        6)
            clear
            echo "Turning WiFi On..."
            networksetup -setairportpower en0 on
            echo "WiFi is now ON"
            echo ""
            read -p "Press Enter to continue..."
            ;;
        7)
            clear
            echo "Turning WiFi Off..."
            networksetup -setairportpower en0 off
            echo "WiFi is now OFF"
            echo ""
            read -p "Press Enter to continue..."
            ;;
        8)
            clear
            echo "========================================"
            echo "Show WiFi Password"
            echo "========================================"
            echo ""
            read -p "Enter WiFi network name: " SSID
            if [ -n "$SSID" ]; then
                echo ""
                echo "Password for $SSID:"
                echo "----------------------------------------"
                echo "This will prompt for your Mac password..."
                security find-generic-password -ga "$SSID" 2>&1 | grep "password:"
                echo ""
                echo "Note: You need administrator access"
            fi
            echo ""
            read -p "Press Enter to continue..."
            ;;
        9)
            clear
            echo "========================================"
            echo "Forget WiFi Network"
            echo "========================================"
            echo ""
            echo "Saved networks:"
            networksetup -listpreferredwirelessnetworks en0 | tail -n +2
            echo ""
            read -p "Enter WiFi network name to forget: " SSID
            if [ -n "$SSID" ]; then
                echo ""
                echo "Removing $SSID from saved networks..."
                sudo networksetup -removepreferredwirelessnetwork en0 "$SSID"
                if [ $? -eq 0 ]; then
                    echo "Successfully removed $SSID"
                else
                    echo "Failed to remove network. May need sudo access."
                fi
            fi
            echo ""
            read -p "Press Enter to continue..."
            ;;
        10)
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            sleep 1
            ;;
    esac
done
