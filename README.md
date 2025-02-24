# Workspace Role

An Ansible role that configures a development workspace with integrated tools and configurations, designed for educational environments.

## Features

- Interactive Help System:
  - `workspace-help` command shows all available features
  - Non-intrusive welcome message (excludes SSH sessions)
- Enhanced Shell Environment:
  - Intelligent history management with size controls
  - Smart command completion and colored output
  - VSCode terminal detection and compatibility
  - Custom prompt with git status integration (note: may conflict with prompt managers like Starship)
- Integrated Development Tools:
  - Terminator (CTRL+- split horizontal, CTRL+\ split vertical, CTRL+T new tab)
  - Git with smart aliases and branch status indicators
  - Vim with system clipboard integration
  - bat for syntax-highlighted file viewing
  - fzf with file/history/directory search
  - fd-find as modern alternative to find
  - Additional tools: ncdu, htop, tree, xclip
- Key Bindings:
  - ALT-T: Fuzzy file search with bat preview
  - CTRL-R: History search with preview/copy (CTRL-Y to copy)
  - ALT-C: Directory navigation with tree preview
  - CTRL-/: Toggle preview windows
- Quick Commands:
  - vf: Fuzzy find and open in vim
  - cf: Fuzzy directory navigation
  - kp: Interactive process killer
  - g: Git shortcuts (st, co, br, ci, lg)

## Installation Options

You can customize the installation using Ansible tags:

```yaml
# Full installation with all features
ansible-playbook playbook.yml

# Install without custom prompt (use system default)
ansible-playbook playbook.yml --skip-tags "prompt"

# Only install base packages and tools
ansible-playbook playbook.yml --tags "setup"

# Only configure tools without installing packages
ansible-playbook playbook.yml --tags "configuration"

# Uninstall workspace configuration
ansible-playbook playbook.yml --tags "uninstall"
```

### Available Tags

- `setup`: Install required packages
- `configuration`: Configure tools and shell environment
- `prompt`: Install custom prompt (can be skipped)
- `uninstall`: Remove workspace configuration

## Requirements

- Ansible 2.9+
- Debian/Ubuntu system
- Internet connection for package installation

## Variables

### Required

```yaml
workspace_git_user_name: ""    # Your Git username
workspace_git_user_email: ""   # Your Git email address
```

### Optional

All other configurations have sensible defaults in `defaults/main.yml`:

- Git (editor, branch, tools)
- Terminator (font, colors, behavior)
- Shell (history size, file size, control)
- FZF integration settings
- `workspace_use_custom_prompt`: Set to false to use system default prompt

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

1. Install: Run playbook with required variables
2. Activate: `source ~/.bashrc` or restart terminal
3. Explore: Run `workspace-help` to see available features

## Important Notes

### Shell Integration

This role provides two prompt options:

1. Custom prompt with git status integration (default)
2. System default prompt (when using --skip-tags "prompt" or setting workspace_use_custom_prompt: false)

The custom prompt includes:

- Two-line layout with user@host and current directory
- Git branch and status indicators
- Color-coded sections for better readability
- VSCode terminal compatibility

### Bashrc Modifications

This role modifies your ~/.bashrc file by adding a block between markers:

```bash
# {mark} WORKSPACE CONFIGURATION
# History configuration
HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=5000
shopt -s histappend
shopt -s checkwinsize

# Development environments
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# Source workspace configuration
if [ -f $HOME/.workspace_rc ]; then
  . $HOME/.workspace_rc
fi
# {mark} WORKSPACE CONFIGURATION
```

### Uninstallation

The uninstall tag will:

- Remove workspace configuration files
- Remove workspace-specific bashrc modifications
- Leave installed packages intact (a command will be provided to remove them manually)

## License

MIT
