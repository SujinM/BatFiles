# System Utilities Scripts Collection

A comprehensive collection of useful system utility scripts for both **Windows** (batch files) and **Mac/Linux** (shell scripts). These scripts help with system administration, performance monitoring, file management, network diagnostics, and more.

![Platforms](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## Project Structure

```
├── windows/          # Windows batch files (.bat)
├── mac/             # Mac/Linux shell scripts (.sh)
└── README.md        # This file
```

##  Quick Start

### Windows
1. Navigate to the `windows` folder
2. Double-click any `.bat` file to run it
3. Some scripts require **Administrator privileges**

### Mac/Linux
1. Navigate to the `mac` folder
2. Make scripts executable: `chmod +x *.sh`
3. Run any script: `./script_name.sh`
4. Some scripts require **sudo privileges**

##  Features

### System Management
- **System Information** - Display comprehensive hardware and software details
- **System Cleanup** - Clean temporary files and system cache
- **Performance Monitor** - Real-time CPU, Memory, and Disk monitoring
- **Service Manager** - Start, stop, and manage system services (Windows)

### Network Tools
- **Network Information** - Display network configuration and connections
- **Port Scanner** - Check port usage and find processes (Windows)
- **WiFi Manager** - Manage WiFi connections and profiles (Windows)

### File Management
- **Folder Organizer** - Auto-organize files by extension
- **File Search** - Advanced file search with multiple criteria (Windows)
- **Quick Backup** - Create timestamped backups
- **Disk Analyzer** - Analyze disk space and find large files

### Development Tools
- **Git Quick Commit** - Fast git add, commit, and push workflow
- **Environment Manager** - View and export environment variables (Windows)
- **Python Environment Launcher** - Launch PowerShell with virtual env (Windows)

### System Utilities
- **Process Killer** - Terminate processes by name or PID
- **Registry Backup** - Backup important registry keys (Windows)
- **App Launcher** - Quick access to system applications (Windows)
- **URL Launcher** - Open multiple websites at once (Windows)

## Available Scripts

### Windows (18 scripts)
See [windows/README.md](windows/README.md) for detailed list

### Mac (9 scripts)
See [mac/README.md](mac/README.md) for detailed list

##  Important Notes

- **Backup your data** before running cleanup scripts
- Some scripts require **elevated privileges** (Administrator/sudo)
- Review and customize paths in scripts as needed
- Test scripts in a safe environment first

## 🛠️ Customization

All scripts are well-commented and easy to modify:
- Edit source/destination paths in backup scripts
- Customize file types in folder organizer
- Add/remove cleanup operations
- Modify menu options and features

##  Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

##  License

MIT License - Free to use and modify for personal and commercial purposes.

##  Platform-Specific Documentation

- [Windows Scripts Documentation](windows/README.md)
- [Mac Scripts Documentation](mac/README.md)

##  Tips

- Create shortcuts to frequently used scripts
- Add script directories to your PATH for easy access
- Review script contents before first run
- Keep scripts updated with your system changes

---

**Note**: Some features may vary between Windows and Mac versions due to platform differences. Check platform-specific README files for details.
