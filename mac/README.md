# Mac/Linux Shell Scripts

A collection of useful shell scripts for Mac and Linux systems. These scripts help with system administration, performance monitoring, file management, and more.

## Getting Started

### Make Scripts Executable
```bash
cd mac
chmod +x *.sh
```

### Run a Script
```bash
./script_name.sh
```

## Available Scripts

### 1. **system_cleanup.sh**
- Cleans user cache and temporary files
- Removes system logs
- Empties Trash
- Cleans download history
- **Run with sudo** for full access

### 2. **network_info.sh**
- Displays network interfaces
- Shows active connections
- Displays DNS configuration
- Shows WiFi information
- Shows public IP address

### 3. **quick_backup.sh**
- Creates timestamped backups
- Backs up Documents folder by default
- Organizes backups automatically
- **Edit SOURCE variable** to customize

### 4. **system_info.sh**
- Displays comprehensive system information
- Shows CPU, RAM, disk details
- Displays Mac model and OS version
- Shows system uptime

### 5. **git_quick_commit.sh**
- Quick Git workflow automation
- Stages all changes, commits, and pushes
- Interactive commit message input
- **Run from within a Git repository**

### 6. **kill_process.sh**
- Terminate processes by name or PID
- View running processes
- Interactive menu-driven interface

### 7. **folder_organizer.sh**
- Organizes files by extension
- Creates folders: Images, Documents, Videos, Music, Archives
- **Run in the folder you want to organize**

### 8. **disk_analyzer.sh**
- Shows disk space for all drives
- Find large files (over 100MB)
- Calculate folder sizes
- Interactive menu system

### 9. **performance_monitor.sh**
- Real-time CPU, Memory, and Disk monitoring
- View top processes by CPU or Memory
- Continuous monitoring mode
- System performance overview

### 10. **wifi_manager.sh**
- Manage WiFi connections and networks
- View available and saved WiFi networks
- Connect/disconnect from networks
- Show WiFi passwords from Keychain
- Turn WiFi on/off
- Forget saved networks

### 11. **port_scanner.sh**
- Show all listening TCP ports with process names
- Check if a specific port is in use (TCP & UDP)
- View all open ports grouped by process
- Find which process is using a given port
- Show status of common ports (HTTP, SSH, MySQL, PostgreSQL, Redis, MongoDB, etc.)
- Scan a custom port range on any host using `nc`

### Development Tools

#### 12. **env_manager.sh**
- View and manage environment variables
- Show all, shell, and exported variables
- Display PATH variable in formatted, numbered list
- Export variables to file on Desktop
- Search variables by name
- Show common macOS system variables (HOME, USER, SHELL, JAVA_HOME, etc.)

## Usage Examples

### System Information
```bash
./system_info.sh
```

### Backup Documents
```bash
# Edit the SOURCE variable in the script first
./quick_backup.sh
```

### Organize Downloads Folder
```bash
cd ~/Downloads
/path/to/folder_organizer.sh
```

### Monitor Performance
```bash
./performance_monitor.sh
# Choose option 7 for continuous monitoring
```

### Quick Git Commit
```bash
cd /path/to/your/repo
/path/to/git_quick_commit.sh
```

## Important Notes

- Some scripts require **sudo** privileges for full functionality
- Review and customize paths in scripts as needed
- The cleanup script permanently deletes files - use with caution
- Always backup important data before running cleanup operations

## Customization

### Modify Backup Source
Edit `quick_backup.sh`:
```bash
SOURCE="$HOME/Documents"  # Change to your folder
```

### Customize File Organization
Edit `folder_organizer.sh` to add more file types:
```bash
mv "$TARGET"/*.{ext1,ext2} "$TARGET/FolderName/" 2>/dev/null
```

## Permissions

If you get "Permission Denied" errors:
```bash
chmod +x script_name.sh
```

For system operations requiring admin access:
```bash
sudo ./script_name.sh
```

## Linux Compatibility

These scripts are designed for macOS but most will work on Linux with minor modifications:
- Network commands may differ (use `ip` instead of `ifconfig`)
- System profiler commands are Mac-specific
- Path structures may vary

## Notes

- Scripts include error handling and user-friendly output
- All scripts provide feedback during execution
- Menu-driven scripts loop until manually exited
- Continuous monitoring can be stopped with Ctrl+C

## See Also

- [Main README](../README.md) - Project overview
- [Windows Scripts](../windows/README.md) - Windows batch files

---

**Tip**: Create aliases in your `~/.bashrc` or `~/.zshrc` for frequently used scripts:
```bash
alias sysinfo='/path/to/system_info.sh'
alias cleanup='sudo /path/to/system_cleanup.sh'
```
