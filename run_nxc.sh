#!/bin/bash

# Define the paths to your files
HOSTS_FILE="hosts.txt"
USERS_FILE="users.txt"
PASSWORDS_FILE="passwords.txt"

# Check if the files exist
if [[ ! -f "$HOSTS_FILE" ]]; then
    echo "Hosts file not found: $HOSTS_FILE"
    exit 1
fi

if [[ ! -f "$USERS_FILE" ]]; then
    echo "Users file not found: $USERS_FILE"
    exit 1
fi

if [[ ! -f "$PASSWORDS_FILE" ]]; then
    echo "Passwords file not found: $PASSWORDS_FILE"
    exit 1
fi

# Define the variables to iterate over
SERVICES=("smb" "winrm" "ftp" "rdp" "ssh" "mssql" "wmi" "ldap" "vnc")

# Iterate over each service and run the nxc command
for SERVICE in "${SERVICES[@]}"; do
    echo "Running nxc with service: $SERVICE"
    if [[ "$SERVICE" == "smb" || "$SERVICE" == "ssh" || "$SERVICE" == "ftp" || "$SERVICE" == "rdp" ]]; then
        nxc "$SERVICE" "$HOSTS_FILE" -u "$USERS_FILE" -p "$PASSWORDS_FILE" --continue-on-success 
    else
        nxc "$SERVICE" "$HOSTS_FILE" -u "$USERS_FILE" -p "$PASSWORDS_FILE"
    fi
done

