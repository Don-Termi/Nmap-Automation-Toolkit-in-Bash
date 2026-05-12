# Basic Nmap Automation Script

A simple Bash-based automation tool for Nmap designed to simplify common network scanning tasks through an interactive terminal menu.

The script automatically checks if Nmap is installed and installs it on Debian/Ubuntu-based systems if necessary. It allows users to perform common scans without needing to remember complex Nmap commands.

---

# Features

- Automatic Nmap installation check
- Interactive CLI menu
- Basic network scanning
- Operating system detection
- Service and version detection
- Custom port range scanning
- Input validation for ports and targets
- Lightweight and beginner-friendly

---

# Available Scan Modes

| Option | Description |
|--------|-------------|
| 1 | Normal network scan |
| 2 | Operating system detection (`-O`) |
| 3 | Service and version detection (`-sV`) |
| 4 | Custom port range scan (`-p`) |
| 5 | About section |

---

# Requirements

- Linux environment
- Bash
- Nmap
- Debian/Ubuntu recommended

---

# Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
