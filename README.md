![Debian](https://img.shields.io/badge/OS-Debian-A81D33?style=flat&logo=debian&logoColor=white)
![Window Manager](https://img.shields.io/badge/Window_Manager-i3-blue?style=flat&logo=i3&logoColor=white)
![Dotfiles Manager](https://img.shields.io/badge/Dotfiles-GNU_Stow-4EAA25?style=flat&logo=gnu&logoColor=white)
![Latest commit](https://img.shields.io/github/last-commit/InformaticoIncapace/dotfiles?style=flat)
![Repo size](https://img.shields.io/github/repo-size/InformaticoIncapace/dotfiles?style=flat)

# 🐧 My Linux Dotfiles

Personal configuration for **Debian GNU/Linux**, inspired by [Tsoding](https://www.youtube.com/@TsodingDaily) and [Typecraft](https://www.youtube.com/@typecraft_dev).

A collection of my desktop configurations, terminal tools, and personal tweaks, managed with **GNU Stow**.

---

## 📦 Managed Configurations

| Package | Description |
| --- | --- |
| `i3` | Tiling window manager |
| `alacritty` | GPU-accelerated terminal with Catppuccin Mocha |
| `polybar` | Customizable status bar |
| `picom` | X11 compositor |
| `rofi` | Application launcher and window switcher |
| `backgrounds` | Desktop wallpapers |
| `emacs` | Personal Emacs configuration |

---

## 🛠️ Requirements

- Debian GNU/Linux
- [GNU Stow](https://www.gnu.org/software/stow/)
- Git

The applications listed above must be installed separately.

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/InformaticoIncapace/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Review existing configurations

GNU Stow creates symbolic links in your home directory. Back up existing configurations and resolve any conflicting files before proceeding.

Preview the changes first:

```bash
stow --target="$HOME" --simulate \
    alacritty backgrounds i3 picom polybar rofi
```

### 3. Enable the configurations

Apply the packages you want to use:

```bash
stow --target="$HOME" \
    alacritty backgrounds i3 picom polybar rofi
```

To enable Emacs as well:

```bash
stow --target="$HOME" emacs
```

You can also enable packages individually instead of applying them all at once.

---

## 📁 Repository Structure

Each top-level directory is a Stow package. Its internal structure mirrors the destination paths inside your home directory.

```text
dotfiles/
├── alacritty/
│   └── .config/alacritty/
├── backgrounds/
│   └── .config/backgrounds/
├── emacs/
├── i3/
│   └── .config/i3/
├── picom/
│   └── .config/picom/
├── polybar/
│   └── .config/polybar/
├── rofi/
│   └── .config/rofi/
├── .gitignore
└── README.md
```

---

## 🔄 Updating

Pull the latest changes and reapply the packages when needed:

```bash
git pull
stow --restow --target="$HOME" \
    alacritty backgrounds i3 picom polybar rofi
```

---

## 🎨 Credits

Inspired by [Tsoding](https://www.youtube.com/@TsodingDaily), [Typecraft](https://www.youtube.com/@typecraft_dev), and the Linux desktop customization community.