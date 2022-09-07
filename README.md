# Workspace

## 1.0 Requirements files

### 1.1 Global base

#### filename: base.txt

All primary requirement files inherit from base.

| Package | Description | Usage |
| --- | --- | --- |
| autopep8 | Automatic pep8 formatting. | Formats on file save. |
| black | Recursive Strict re-formatter. | Run in project root. Format recursive current directory: ```pip black .``` |

### 1.2 Jupyter Lab

#### filename: jupyterlab.txt

| Package | Description | Usage |
| --- | --- | --- |
| jupyterlab | Data Science platform. | Start environment: ```jupyterlab``` |

### 1.3 Package development

#### filename: package_dev.txt

| Package | Description | Usage |
| --- | --- | --- |
| yolk3k | Search for python package information. | return package latest version: ```yolk -V <package_name>``` |
