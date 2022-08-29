#!/bin/bash
# Create a python virtual environment based on a given name argument.
# © Get-Tony@outlook.com 20.02.2021

set -e

DEBUG="false"
VENV_DIR_NAME="venv"

# Print usage information.
print_usage() {
cat <<EOF
Usage is case sensitive!
  create: $0 create <venv_mame>
   purge: $0 purge <venv_name>
EOF
}

debug_message() {
    if $DEBUG; then
        echo "DEBUG: $1"
    fi
}

clean_exit() {
    unset $DEBUG
    unset $VENV_DIR_NAME
    exit 0
}

create_environment() {
    # Clean exit if virtual environment directory already exists.
    if [ -d ./$VENV_DIR_NAME ]; then
        echo "Directory '$VENV_DIR_NAME' already exists. No changes made."
        clean_exit
    fi

    # Clean exit if python is not installed.
    if [[ "$(python3 -V)" =~ "Python 3" ]]; then
        debug_message 'Python 3 is available.'
    else
        echo 'Python3 is missing. Installation information link:'
        echo "https://www.python.org/downloads/"
        clean_exit
    fi

    # Clean exit if python venv module is not installed.
    if python3 -c 'import pkgutil; exit(not pkgutil.find_loader("venv"))'; then
        debug_message "Python 3 module 'venv' is available."
    else
        echo "Python 3 module 'venv' is missing. Installation information link:"
        echo "https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/"
        clean_exit
    fi

    # Create the virtual environment, report then clean exit.
    echo "Creating environment for '$1' in '$PWD/$VENV_DIR_NAME'.."
    python3 -m venv $VENV_DIR_NAME --prompt="$1"
    echo "Environment '$1' is ready."
    clean_exit
}

purge_environment() {
    # Clean exit is virtual environment directory already exists.
    if [[ ! -d ./$VENV_DIR_NAME ]]; then
        echo "Directory '$VENV_DIR_NAME' does not exist. No changes made."
        clean_exit
    fi

    echo "Purging '$1' environment folder: '$PWD/$VENV_DIR_NAME'."

    # Verify that the venv directory contains the expected environment.
    if [[ "$(grep -rI $1 $VENV_DIR_NAME/pyvenv.cfg)" =~ "prompt =" ]]; then
        rm -rI ./$VENV_DIR_NAME
        clean_exit
    else
        echo "Environment folder for '$1' not found."
        clean_exit
    fi
}

# Check for environment name argument.
if [ -z "$2" ]; then
    print_usage
    clean_exit
fi

# Case arguments and initialize.
case $1 in
create)
    create_environment $2
    ;;
purge)
    purge_environment $2
    ;;
*)
    echo "Error: Unknown argument."
    print_usage
    clean_exit
    ;;
esac
