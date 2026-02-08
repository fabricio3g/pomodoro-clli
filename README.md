# Pomodoro CLI Timer

A simple, colorful Pomodoro timer for the command line with progress bars and cross-platform support.

![Pomodoro Timer](https://img.shields.io/badge/pomodoro-timer-green)

## Features

- Visual progress bar `[====      ]`
- Color-coded sessions (green for work, yellow for break)
- Percentage completion indicator
- Cross-platform (Linux, macOS, Windows Git Bash/WSL)
- Audio notifications when sessions end
- Continuous sessions with session counter

## Installation

### Ubuntu/Debian

**Option 1: Quick Install (Recommended)**
```bash
./install.sh
```

**Option 2: Manual Install**
```bash
sudo cp pomodoro.sh /usr/local/bin/pomodoro
sudo chmod +x /usr/local/bin/pomodoro
```

**Option 3: User-local Install (no sudo)**
```bash
mkdir -p ~/.local/bin
cp pomodoro.sh ~/.local/bin/pomodoro
chmod +x ~/.local/bin/pomodoro
# Add to PATH if needed:
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
source ~/.bashrc
```

### macOS

```bash
# Install to /usr/local/bin
sudo cp pomodoro.sh /usr/local/bin/pomodoro
sudo chmod +x /usr/local/bin/pomodoro
```

### Windows (Command Prompt / PowerShell)

**Option 1: Using the batch file**
```batch
# Run directly
pomodoro.bat

# Or with custom times
pomodoro.bat 30 10
```

**Option 2: Install to PATH**
```batch
# Copy to a directory in your PATH (e.g., C:\Windows\System32 or a custom folder)
copy pomodoro.bat C:\Tools\pomodoro.bat

# Add to PATH via System Properties or PowerShell:
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Tools", "User")
```

**Option 3: Using Git Bash**
```bash
# Copy to a directory in your PATH
cp pomodoro.sh /usr/bin/pomodoro
chmod +x /usr/bin/pomodoro
```

## Usage

```bash
# Default: 25 min work, 5 min break
pomodoro

# Custom times (work break)
pomodoro 30 10    # 30 min work, 10 min break
pomodoro 45 15    # 45 min work, 15 min break
pomodoro 50 10    # 50 min work, 10 min break
```

Press `Ctrl+C` to stop the timer.

## Uninstallation

### Ubuntu/Debian

```bash
# Remove from system
sudo rm /usr/local/bin/pomodoro

# Or if installed locally
rm ~/.local/bin/pomodoro
```

### macOS

```bash
sudo rm /usr/local/bin/pomodoro
```

### Windows (Command Prompt / PowerShell)

```batch
# Remove batch file from PATH location
del C:\Tools\pomodoro.bat
```

### Windows (Git Bash)

```bash
rm /usr/bin/pomodoro
```

## File Structure

```
.
├── pomodoro.sh    # Main script (Linux/macOS)
├── pomodoro.bat   # Windows batch script
├── install.sh     # Installation helper
└── README.md      # This file
```

## License

MIT License - Feel free to use and modify!
