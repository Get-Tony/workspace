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
  - Custom prompt with git status integration
  - Python virtual environment indicator (py:venvname)
- Integrated Development Tools:
  - Terminator (CTRL+h split horizontal, CTRL+v split vertical, CTRL+T new tab, CTRL+PgUp/PgDn switch tabs)
  - Git with smart aliases and branch status indicators
  - Vim with system clipboard integration
  - Python environment with pyenv and virtualenv
  - bat for syntax-highlighted file viewing
  - fzf with file/history/directory search
  - fd-find as modern alternative to find
  - Additional tools: ncdu, htop, tree, xclip
- Quick Commands:
  - venv-create: Create Python virtual environment
  - venv-activate: Activate Python virtual environment
  - vf: Fuzzy find and open in vim
  - cf: Fuzzy directory navigation
  - kp: Interactive process killer
  - g: Git shortcuts (st, co, br, ci, lg)

## Installation Options

You can customize the installation using Ansible tags:

```yaml
# Full installation with all features
ansible-playbook playbook.yml

# Install base packages only
ansible-playbook playbook.yml --tags "base,packages"

# Install and configure specific features
ansible-playbook playbook.yml --tags "development"  # Git + Python tools
ansible-playbook playbook.yml --tags "terminal"     # Terminator setup
ansible-playbook playbook.yml --tags "shell"        # Shell environment
ansible-playbook playbook.yml --tags "utils"        # Utility tools

# Feature-specific installations
ansible-playbook playbook.yml --tags "git"          # Git configuration
ansible-playbook playbook.yml --tags "python"       # Python environment
ansible-playbook playbook.yml --tags "prompt"       # Custom prompt only

# Configuration only (no package installation)
ansible-playbook playbook.yml --tags "configuration"

# Remove workspace configuration
ansible-playbook playbook.yml --tags "uninstall"
```

### Feature Sets and Tags

The role uses the following tag structure:

1. Meta Tags:
   - `setup`: Common tag for all installation tasks
   - `configuration`: Configuration tasks only
   - `packages`: Package installation tasks
   - `uninstall`: Remove workspace configuration

2. Feature Set Tags:
   - `base`: Core system utilities
   - `development`: Development tools (git, python)
   - `terminal`: Terminal emulator setup
   - `shell`: Shell environment and prompt
   - `utils`: Additional utility tools

3. Component Tags:
   - `git`: Git-specific configuration
   - `python`: Python environment setup
   - `prompt`: Shell prompt configuration
   - `environment`: Shell environment settings
   - `terminator`: Terminal emulator setup

Each task may have multiple tags to allow flexible installation options.

## Requirements

- Ansible 2.9+
- Debian/Ubuntu system
- Internet connection for package installation

## Variables

### Required

No variables are strictly required, but you should customize:

```yaml
workspace_git_user_name: "{{ ansible_env.USER }}"  # Defaults to system username
workspace_git_user_email: "{{ ansible_env.USER }}@{{ ansible_fqdn }}"  # Defaults to username@hostname
```

### Optional Settings

Configuration variables in `defaults/main.yml`:

```yaml
# Feature toggles
workspace_install_pyenv: true      # Enable/disable PyEnv installation
workspace_use_custom_prompt: true  # Enable/disable custom prompt

# Git configuration
workspace_git_config:
  core.editor: "vim"
  init.defaultBranch: "main"
  diff.tool: "vimdiff"
  merge.tool: "vimdiff"
  credential.helper: "cache --timeout=3600"

# Terminal appearance
workspace_terminator_settings:
  font: "Monospace 12"
  scrollback_lines: 10000
  background_color: "#300a24"
  foreground_color: "#ffffff"
  cursor_shape: "underline"
  cursor_color: "#aaaaaa"
  copy_on_selection: false
  scrollback_infinite: true
  show_titlebar: true

# Shell settings
workspace_shell_config:
  histsize: 5000
  histfilesize: 5000
  histcontrol: "ignoreboth"
```

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - role: workspace
      vars:
        workspace_git_user_name: "Jane Doe"
        workspace_git_user_email: "jane@example.com"
        workspace_use_custom_prompt: true
        workspace_install_pyenv: true
```

## Usage

1. Install: Run playbook with desired tags and variables
2. Activate: `source ~/.bashrc` or restart terminal
3. Explore: Run `workspace-help` to see available features

## Important Notes

### Shell Integration

The role provides a customizable shell environment with:

- Two-line prompt with git/venv status (when enabled)
- Intelligent history management
- VSCode terminal compatibility
- Color-coded sections for better readability

To use the system default prompt instead:

- Set `workspace_use_custom_prompt: false` or
- Use `--skip-tags "prompt"` during installation

### Python Environment

The role provides two Python environment options:

1. PyEnv (when `workspace_install_pyenv: true`):
   - Manages multiple Python versions
   - Automatically added to PATH
   - Initialized in shell environment

2. Virtual Environments:
   - Quick commands: `venv-create` and `venv-activate`
   - Status shown in prompt when active
   - Python 3 venv module pre-installed

### Uninstallation

The `uninstall` tag:

- Removes all workspace configuration files
- Cleans up bashrc modifications
- Preserves installed packages
- Provides commands for manual package removal

## License

MIT
