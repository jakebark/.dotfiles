# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

An Ansible-based dotfiles repo that provisions a development environment (zsh, tmux, neovim) across macOS and Linux (Debian/Ubuntu, Fedora, RHEL/CentOS).

## Running the Playbooks

First, install Ansible for your OS using the bootstrap scripts in `os/`:

```bash
# Debian/Ubuntu
sudo bash os/ansible-debian.sh

# Fedora
bash os/ansible-fedora.sh

# RHEL/CentOS
bash os/ansible-rhel.sh

# macOS (requires Homebrew and pip)
pip install ansible
```

Then run the appropriate playbook from the `os/` directory:

```bash
# macOS
ansible-playbook os/mac.yml

# Debian/Ubuntu
ansible-playbook os/debian.yml

# Fedora
ansible-playbook os/fedora.yml

# RHEL/CentOS
ansible-playbook os/rhel.yml
```

Run only specific components using tags (`zsh`, `tmux`, `nvim`, `core`, `conf`):

```bash
ansible-playbook os/mac.yml --tags tmux
ansible-playbook os/debian.yml --tags "zsh,conf"
```

## Architecture

```
os/
  mac.yml / debian.yml / fedora.yml / rhel.yml   # top-level playbooks
  mac/ debian/ fedora/ rhel/                      # per-OS task files
    core.yml   # base packages (Linux only)
    zsh.yml    # zsh install + copy .zshrc
    tmux.yml   # tmux install, .tmux.conf, tpm, tmux-sessionizer
    nvim.yml   # neovim install, clone/pull jakebark/nvim config
    yabai.yml  # macOS tiling WM (mac only, disabled in mac.yml)
scripts/
  tmux-sessionizer   # fzf project switcher; bound to Ctrl-f (zsh) and prefix-f (tmux)
  tmux-ai            # toggles a right-side pane running claude or kiro-cli; bound to prefix-q
.zshrc               # minimal: adds scripts/ to PATH, sets Ctrl-f → tmux-sessionizer
.tmux.conf           # prefix=Ctrl-a, vi mode, tpm + tmux-resurrect, binds for scripts
```

**Key design notes:**
- Config files (`.zshrc`, `.tmux.conf`) live at the repo root and are copied to `~/` by the playbooks.
- Neovim config is managed in a separate repo (`jakebark/nvim`) cloned/pulled to `~/.config/nvim`.
- Linux playbooks use `become: yes` at the play level; mac relies on Homebrew (no sudo).
- `tmux-ai` auto-detects `kiro-cli` or `claude` and toggles a 35%-wide right pane.
