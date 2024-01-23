#!/bin/bash

BASE_URL="https://github.com/leanderlombardi"

install_packet() {
    package_name=$1
    url="$BASE_URL/$package_name"
    
    echo "Downloading $package_name..."
    cd /tmp/
    git clone "$url"
    
    echo "Compiling $package_name..."
    sudo gcc -o "/usr/bin/$package_name" "$package_name/$package_name.c"
    

    echo "$package_name installed successfully!"
}

remove_packet() {
    package_name=$1
    
    if [ -e "/usr/bin/$package_name" ]; then
        echo "Removing $package_name..."
        sudo rm -f "/usr/bin/$package_name"
        echo "$package_name removed successfully!"
    else
        echo "$package_name is not installed."
    fi
}

update_packet() {
    package_name=$1
    remove_packet "$package_name"
    install_packet "$package_name"
}

main() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: $0 <install | remove | update> <package_name>"
        exit 1
    fi

    action=$1
    package_name=$2

    case "$action" in
        "install")
            install_packet "$package_name"
            ;;
        "remove")
            remove_packet "$package_name"
            ;;
        "update")
            update_packet "$package_name"
            ;;
        *)
            echo "Invalid action. Use install, remove, or update."
            exit 1
            ;;
    esac
}

main "$@"


