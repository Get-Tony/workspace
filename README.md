# Workspace Role

An Ansible role that configures a development workspace with integrated tools and configurations, designed for educational environments.

## Features

- Interactive Help System:
  - `workspace-help` command shows all available features
  - Non-intrusive welcome message (respects SSH sessions)
- Enhanced Shell Environment:
  - Intelligent history management
  - Smart command completion
  - Colored output for common commands
- Integrated Development Tools:
  - Terminator with custom keybinds (CTRL+-, CTRL+\, CTRL+T)
  - Git with smart aliases and pretty logging
  - Vim with modern defaults
  - bat (enhanced cat with syntax highlighting)
  - fzf (fuzzy finder) with preview integration
  - fd-find (modern alternative to find)
  - Additional tools: ncdu, htop, tree, xclip
- Key Bindings:
  - ALT-T: Fuzzy file search with preview
  - CTRL-R: History search with preview/copy
  - ALT-C: Directory navigation with tree preview
  - CTRL-/: Toggle preview windows
  - CTRL-Y: Copy command in history search
- Quick Commands:
  - vf: Fuzzy file opening in vim
  - cf: Fuzzy directory navigation
  - kp: Interactive process killer
  - g [alias]: Git shortcuts

## Requirements

- Ansible 2.9+
- Debian/Ubuntu system
- Internet connection

## Quick Start

1. Required variables:

```yaml
workspace_git_user_name: ""    # Your Git username
workspace_git_user_email: ""   # Your Git email address
```

1. Optional configs in `defaults/main.yml`:

- Git (editor, branch, tools)
- Terminator (font, colors, behavior)
- Shell (history, aliases)

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - role: workspace
      vars:
        workspace_git_user_name: "Jane Doe"
        workspace_git_user_email: "jane@example.com"
```

## Usage

1. Install: Run playbook
2. Activate: `source ~/.bashrc` or restart your terminal
3. Get Started: Type `workspace-help`

## License

MIT
