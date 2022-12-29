# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "ubunutu-01" {
    
    # VM General Settings in Proxmox
    target_node = "pe"
    vmid = "110"
    name = "d1"
    desc = "D1 from Terraform"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings, where to clone from
    clone = "testubuntu"

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cores = 2
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings
    memory = 2048

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    # disk {
    #     storage = "local-lvm"
    #     type = "virtio"
    #     size = "40G"
    # }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"
    
    # (Optional) Default User
    # ciuser = "sven"
    
    # (Optional) Add your SSH KEY
    # sshkeys = <<EOF
    # #YOUR-PUBLIC-SSH-KEY
    # EOF
}