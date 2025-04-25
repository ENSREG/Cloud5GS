# Ansible Playbooks for free5GC on Azure VM

This directory contains the Ansible playbooks required to configure an Azure VM to run free5GC.

## Directory Structure

```
ansible/
├── ansible.cfg            # Ansible configuration file
├── inventory/             # Host inventory directory
│   └── hosts              # Target host definitions
├── playbooks/             # Playbook directory
│   ├── main.yml           # Main playbook file
│   └── tasks/             # Task files directory
│       ├── install_helm.yml       # Install Helm
│       ├── install_microk8s.yml   # Install MicroK8s
│       └── install_packages.yml   # Install necessary packages
└── README.md              # Documentation file
```

## Usage

1. Update the `<VM_IP_ADDRESS>` in the `inventory/hosts` file to the actual IP address of your Azure VM.

2. Run the playbook:
   ```bash
   cd /home/ian/cloud5gc/ansible
   ansible-playbook playbooks/main.yml
   ```

## Features

This Ansible setup installs the following on an Ubuntu 24.04 Azure VM:

1. Essential development tools and libraries:
   - gcc, g++, cmake, autoconf, libtool, pkg-config, libmnl-dev, libyaml-dev

2. MicroK8s with the following add-ons enabled:
   - community
   - dns
   - storage
   - rbac
   - multus

3. Helm 3 package manager

## Notes

- Ensure you have the correct SSH private key located at `~/.ssh/id_rsa_azure`
- Make sure the target host is running Ubuntu 24.04
