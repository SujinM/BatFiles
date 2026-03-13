# Linux Shell Scripts

A collection of useful shell scripts for Linux systems. These scripts help with system administration, performance monitoring, network diagnostics, and more.

## Getting Started

### Make Scripts Executable
```bash
cd linux
chmod +x *.sh
```

### Run a Script
```bash
./script_name.sh
```

## Available Scripts

### 1. **system_info.sh**
- Displays comprehensive system information
- Shows CPU, RAM, and disk details
- Displays OS name, version, and kernel info
- Shows hostname and processor cores
- Works across different Linux distributions

### 2. **network_info.sh**
- Displays all network interfaces with IP addresses
- Shows default gateway and routing information
- Lists DNS servers configuration
- Fetches public IP address
- Shows active network connections
- Displays listening ports and services
- WiFi connection status and signal strength
- Network statistics (RX/TX bytes)
- Firewall status (UFW, firewalld, or iptables)
- Works with both modern (ip, ss) and legacy (ifconfig, netstat) commands

## Usage Examples

### Check System Information
```bash
./system_info.sh
```

### View Network Details
```bash
./network_info.sh
```

## Requirements

### Basic Requirements
- Bash shell (pre-installed on most Linux distributions)
- Read access for system information scripts
- Internet connection for public IP lookup

### Optional Tools for Enhanced Functionality
- **NetworkManager** (`nmcli`) - For WiFi management
- **iproute2** (`ip`, `ss`) - Modern network tools
- **curl** or **wget** - For public IP detection
- **net-tools** (`ifconfig`, `netstat`) - Legacy network tools (fallback)
- **sudo** access - For firewall status checks

### Installing Optional Tools

#### Debian/Ubuntu
```bash
sudo apt-get install iproute2 net-tools network-manager curl
```

#### RHEL/CentOS/Fedora
```bash
sudo dnf install iproute net-tools NetworkManager curl
```

#### Arch Linux
```bash
sudo pacman -S iproute2 net-tools networkmanager curl
```

## Features

### System Management
- ✅ Cross-distribution compatibility
- ✅ No dependencies for basic functionality
- ✅ Graceful fallbacks for missing tools
- ✅ Clear, formatted output

### Network Diagnostics
- ✅ Multiple detection methods
- ✅ Support for both modern and legacy tools
- ✅ WiFi signal strength monitoring
- ✅ Firewall status across different systems
- ✅ Active connections and port monitoring

## Important Notes

- Scripts use modern Linux tools when available
- Automatic fallback to legacy commands for compatibility
- Some features require **sudo privileges** (firewall status)
- Works across major Linux distributions
- Test scripts in a safe environment first

## Compatibility

Tested and compatible with:
- Ubuntu / Debian
- RHEL / CentOS / Fedora
- Arch Linux
- Linux Mint
- Pop!_OS
- Other major distributions

## Tips

- Run network_info.sh with sudo to see firewall details
- Some network info requires active internet connection
- WiFi features require NetworkManager (`nmcli`) or wireless-tools
- Scripts adapt to available tools automatically

## Contributing

Feel free to contribute additional scripts for:
- System maintenance and cleanup
- Performance monitoring
- File management
- Development tools
- Backup utilities

##  License

MIT License - Free to use and modify for personal and commercial purposes.
