#!/bin/bash

# Recommended location to store scripts
SCRIPTS_DIR="$HOME/development_scripts"

# Function to continuously check if Vim is running
wait_for_vim_exit() {
    while pgrep -x "vim" > /dev/null; do
        sleep 1
    done
    echo "Vim closed. Do you want to create an alias for the script? (y/n)"
    read -r create_alias_choice
    if [[ $create_alias_choice == "y" ]]; then
        create_alias
    fi
}

# Function to add a script
add_script() {
    echo "Enter script name:"
    read script_name
    echo "Opening Vim in $SCRIPTS_DIR. Create your script and save it to proceed."
    sleep 2  # Wait for 2 seconds
    vim "$SCRIPTS_DIR/$script_name"
    echo "Script added successfully."

    # After adding script, wait for Vim to close and then prompt to create shell alias
    wait_for_vim_exit
}

# Function to create a shell alias
create_alias() {
    echo "Enter alias name:"
    read alias_name
    echo "Enter command to alias:"
    read command_to_alias
    # Add alias to both .bashrc and .zshrc
    echo "alias $alias_name='$command_to_alias'" >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
    echo "Alias created successfully."
}

# Main menu
while true; do
    echo "Dev Tool Menu:"
    echo "1. Add a script"
    echo "2. Exit"

    read -p "Select an option: " choice
    case $choice in
        1) 
            mkdir -p "$SCRIPTS_DIR"  # Create directory if it doesn't exist
            add_script
            ;;
        2) break ;;
        *) echo "Invalid option. Please choose again." ;;
    esac
done
# Function to continuously check if Vim is running
wait_for_vim_exit() {
    while true; do
        if ! pgrep -x "vim" > /dev/null; then
            echo "Vim closed. Do you want to create an alias for the script? (y/n)"
            read -r create_alias_choice
            if [[ $create_alias_choice == "y" ]]; then
                create_alias
            fi
            break
        fi
        sleep 1
    done
}

