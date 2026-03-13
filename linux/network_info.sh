#!/bin/bash
# ========================================
# Network Information Display for Linux
# Shows network interfaces, IPs, and connections
# ========================================

clear
echo "========================================"
echo "   NETWORK INFORMATION REPORT (Linux)"
echo "========================================"
echo ""

echo "[Network Interfaces]"
echo "----------------------------------------"
if command -v ip &>/dev/null; then
    ip -brief addr show | awk '{printf "%-15s %-10s %s\n", $1, $2, $3}'
else
    ifconfig | grep -E '^[a-z]|inet ' | sed 's/^[[:space:]]*/  /'
fi
echo ""

echo "[Default Gateway]"
echo "----------------------------------------"
if command -v ip &>/dev/null; then
    ip route | grep default
else
    route -n | grep '^0\.0\.0\.0' | head -1
fi
echo ""

echo "[DNS Servers]"
echo "----------------------------------------"
if [ -f /etc/resolv.conf ]; then
    grep "^nameserver" /etc/resolv.conf | awk '{print $2}'
elif command -v systemd-resolve &>/dev/null; then
    systemd-resolve --status | grep "DNS Servers" -A 2 | grep -oP '\d+\.\d+\.\d+\.\d+'
elif command -v resolvectl &>/dev/null; then
    resolvectl status | grep "DNS Servers" -A 2 | grep -oP '\d+\.\d+\.\d+\.\d+'
fi
echo ""

echo "[Public IP Address]"
echo "----------------------------------------"
if command -v curl &>/dev/null; then
    PUBLIC_IP=$(curl -s ifconfig.me 2>/dev/null || curl -s icanhazip.com 2>/dev/null || echo "Unable to fetch")
    echo "$PUBLIC_IP"
elif command -v wget &>/dev/null; then
    PUBLIC_IP=$(wget -qO- ifconfig.me 2>/dev/null || wget -qO- icanhazip.com 2>/dev/null || echo "Unable to fetch")
    echo "$PUBLIC_IP"
else
    echo "curl or wget not available"
fi
echo ""

echo "[Active Network Connections]"
echo "----------------------------------------"
if command -v ss &>/dev/null; then
    echo "Established TCP connections:"
    ss -tunap 2>/dev/null | grep ESTAB | head -10 || ss -tun | grep ESTAB | head -10
else
    netstat -tunap 2>/dev/null | grep ESTABLISHED | head -10 || netstat -tun | grep ESTABLISHED | head -10
fi
echo ""

echo "[Listening Ports]"
echo "----------------------------------------"
if command -v ss &>/dev/null; then
    echo "TCP Listening ports:"
    ss -tlnp 2>/dev/null | head -10 || ss -tln | head -10
else
    netstat -tlnp 2>/dev/null | head -10 || netstat -tln | head -10
fi
echo ""

echo "[WiFi Information]"
echo "----------------------------------------"
if command -v nmcli &>/dev/null; then
    WIFI_INFO=$(nmcli -t -f GENERAL.CONNECTION,GENERAL.STATE,IP4.ADDRESS device show 2>/dev/null | grep -A 2 "wlan\|wlp")
    if [ -n "$WIFI_INFO" ]; then
        echo "Connected WiFi:"
        nmcli -f NAME,TYPE,DEVICE connection show --active 2>/dev/null | grep wifi || echo "Not connected to WiFi"
        
        echo ""
        echo "WiFi Signal Strength:"
        nmcli -f IN-USE,SIGNAL,SSID device wifi list 2>/dev/null | head -5
    else
        echo "No WiFi connection detected"
    fi
elif command -v iwconfig &>/dev/null; then
    iwconfig 2>/dev/null | grep -v "no wireless" | head -20
else
    echo "WiFi tools not available (install NetworkManager or wireless-tools)"
fi
echo ""

echo "[Network Statistics]"
echo "----------------------------------------"
if [ -f /proc/net/dev ]; then
    echo "Interface statistics (RX/TX bytes):"
    cat /proc/net/dev | grep -v "lo:" | grep ":" | awk '{printf "%-12s RX: %-15s TX: %s\n", $1, $2, $10}'
fi
echo ""

echo "[Firewall Status]"
echo "----------------------------------------"
if command -v ufw &>/dev/null; then
    echo "UFW Status:"
    sudo ufw status 2>/dev/null || ufw status 2>/dev/null || echo "Run with sudo to see UFW status"
elif command -v firewall-cmd &>/dev/null; then
    echo "Firewalld Status:"
    sudo firewall-cmd --state 2>/dev/null || firewall-cmd --state 2>/dev/null || echo "Run with sudo to see firewall status"
elif command -v iptables &>/dev/null; then
    echo "iptables Rules Count:"
    sudo iptables -L -n 2>/dev/null | grep -c "^Chain" || echo "Run with sudo to see iptables"
else
    echo "No common firewall tool detected"
fi
echo ""

echo "========================================"
echo "Press any key to exit..."
read -n 1 -s
