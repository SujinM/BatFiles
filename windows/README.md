# Windows Batch Files

A comprehensive collection of useful Windows batch files for system administration, network management, file operations, and development tools.

## Getting Started

### Running Batch Files
1. Double-click any `.bat` file to run it
2. Or open Command Prompt and type: `filename.bat`

### Administrator Access
Some scripts require Administrator privileges:
- Right-click the `.bat` file
- Select "Run as administrator"

## Available Batch Files

### System Management

#### 1. **system_info.bat**
- Displays comprehensive system information
- Shows CPU, RAM, disk, BIOS, motherboard, GPU details
- No admin rights required

#### 2. **system_cleanup.bat**
- Cleans temporary files and system cache
- Removes Windows temp files, prefetch, recycle bin
- Runs disk cleanup utility
- **Requires Administrator**

#### 3. **performance_monitor.bat**
- Real-time CPU, Memory, and Disk monitoring
- View top processes by CPU or Memory
- Continuous monitoring with auto-refresh
- Interactive menu system

### Network Tools

#### 4. **network_info.bat**
- Displays comprehensive network information
- Shows IP configuration, active connections
- Displays DNS cache and network adapters
- Shows public IP address

#### 5. **port_scanner.bat**
- Check which ports are in use
- Find processes using specific ports
- Shows status of common ports (80, 443, 3306, etc.)
- Interactive port checking

#### 6. **wifi_manager.bat**
- Complete WiFi management tool
- View available networks and saved profiles
- Show WiFi passwords
- Connect/disconnect, export/delete profiles
- **Some features require Administrator**

### File Management

#### 7. **folder_organizer.bat**
- Automatically organizes files by extension
- Creates folders: Images, Documents, Videos, Music, Archives, Executables
- **Run in the folder you want to organize**

#### 8. **file_search.bat**
- Advanced file search utility
- Search by name, extension, content, date, or size
- Find duplicate files
- Multiple search criteria

#### 9. **quick_backup.bat**
- Creates timestamped backups
- **Edit SOURCE variable** to set your backup folder
- Automatically organizes backups by date/time

#### 10. **disk_analyzer.bat**
- Shows disk space for all drives
- Analyze specific drive usage
- Find large files (over 100MB)
- Calculate folder sizes

### Development Tools

#### 11. **git_quick_commit.bat**
- Quick Git workflow automation
- Stages all changes, commits, and pushes
- Interactive commit message input
- **Run from within a Git repository**

#### 12. **start_python_env.bat**
- Opens PowerShell in Python project directory
- Automatically activates .venv virtual environment
- **Edit the path** for your Python project location

#### 13. **env_manager.bat**
- View and manage environment variables
- Show system, user, and all variables
- Display PATH variable in readable format
- Export variables to file

### System Utilities

#### 14. **kill_process.bat**
- Terminate processes by name or PID
- View running processes
- Interactive menu-driven interface

#### 15. **service_manager.bat**
- Manage Windows services
- Start, stop, restart services
- List running and stopped services
- **Requires Administrator**

#### 16. **registry_backup.bat**
- Backup important registry keys
- Creates timestamped backups on Desktop
- Exports HKCU, HKLM, and environment variables
- **Requires Administrator for full access**

#### 17. **app_launcher.bat**
- Quick launcher for 18+ Windows utilities
- Launch: Calculator, Task Manager, Registry Editor, etc.
- Access system tools quickly
- Custom program launcher option

#### 18. **url_launcher.bat**
- Quick launcher for multiple websites
- Predefined categories: Development, Social Media, Productivity, Entertainment
- Custom URL opener

## Usage Examples

### System Information
```batch
system_info.bat
```

### Organize Downloads Folder
```batch
cd C:\Users\YourName\Downloads
D:\path\to\folder_organizer.bat
```

### Find Large Files
```batch
disk_analyzer.bat
REM Choose option 3, then enter path
```

### Quick Git Workflow
```batch
cd C:\path\to\your\repo
git_quick_commit.bat
```

### Check What's Using Port 3000
```batch
port_scanner.bat
REM Choose option 4, enter 3000
```

## Important Notes

- **Backup your data** before running cleanup scripts
- Some batch files require **Administrator privileges**
- Review and customize file paths as needed (especially quick_backup.bat)
- Test scripts in a safe environment first
- Scripts use PowerShell commands compatible with Windows 10/11

## Customization

### Modify Backup Source
Edit `quick_backup.bat`:
```batch
set SOURCE=D:\Documents  REM Change to your folder
```

### Customize Cleanup Operations
Edit `system_cleanup.bat` to add/remove cleanup steps

### Add More File Types to Organizer
Edit `folder_organizer.bat`:
```batch
move "%TARGET%\*.ext" "%TARGET%\FolderName\" 2>nul
```

## Troubleshooting

### "Access Denied" Errors
- Run the batch file as Administrator
- Right-click → "Run as administrator"

### "Command not recognized"
- Ensure PowerShell is installed (comes with Windows 10/11)
- Check if the command exists in your Windows version

### Script Window Closes Immediately
- Scripts include `pause` commands
- If it still closes, run from Command Prompt to see errors

## Notes on Windows Compatibility

- All scripts use PowerShell's `Get-CimInstance` (replaces deprecated `wmic`)
- Compatible with Windows 10, Windows 11, and Server 2019+
- Some features may not work on older Windows versions

## See Also

- [Main README](../README.md) - Project overview
- [Mac Scripts](../mac/README.md) - Mac/Linux shell scripts

---

**Tip**: Create shortcuts to frequently used batch files on your Desktop or taskbar for quick access!
