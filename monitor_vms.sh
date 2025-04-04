#!/bin/bash

# Set the VM directory (make sure this matches your USB path)
VM_DIR="/media/$USER/YOUR_USB_NAME/VirtualBox VMs"  # Change to your actual USB mount point

# Function to wait until the VM directory exists
wait_for_vm_dir() {
    echo "Waiting for VM directory to be available..."
    while [[ ! -d "$VM_DIR" ]]; do
        notify-send "Waiting for Storage" "VirtualBox VMs directory not found. Retrying..."
        sleep 3  # Retry every 3 seconds
    done
    notify-send "VM Storage Ready" "VirtualBox VMs directory is now available."
}

# Function to list available VM folders
list_vm_folders() {
    find "$VM_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n"
}

# Function to register and start a VM
start_vm() {
    local vm_folder="$1"
    local vbox_file

    # Find the .vbox file inside the selected folder
    vbox_file=$(find "$VM_DIR/$vm_folder" -maxdepth 1 -name "*.vbox" | head -n 1)

    if [[ -n "$vbox_file" ]]; then
        vm_name=$(basename "$vbox_file" .vbox)

        # Check if the VM is already registered
        if ! VBoxManage list vms | grep -q "\"$vm_name\""; then
            notify-send "Registering VM" "Adding $vm_name to VirtualBox..."
            VBoxManage registervm "$vbox_file"
        fi

        # Start the VM
        VBoxManage startvm "$vm_name"
        notify-send "Starting VM" "Launching $vm_name in GUI mode..."
    else
        notify-send "Error" "No .vbox file found in $vm_folder."
    fi
}

# Function to prompt user to pick a VM folder
prompt_user() {
    export DISPLAY=:0
    export XAUTHORITY="$HOME/.Xauthority"

    local selected_folder
    selected_folder=$(list_vm_folders | zenity --list --title="Select a Virtual Machine" --column="VM Name" --width=400 --height=300 2>/dev/null)

    if [[ -n "$selected_folder" ]]; then
        start_vm "$selected_folder"
    fi
}

# Wait until the VM directory is available
wait_for_vm_dir

# Run the VM selection prompt
prompt_user &

# Monitor the VM directory for new VM folders
inotifywait -m -e create --format "%f" "$VM_DIR" 2>/dev/null | while read NEW_FOLDER; do
    if [[ -d "$VM_DIR/$NEW_FOLDER" ]]; then
        notify-send "New VM Folder Detected" "New VM $NEW_FOLDER added. Prompting to open..."
        prompt_user
    fi
done
