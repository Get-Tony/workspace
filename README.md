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

## License

MIT
