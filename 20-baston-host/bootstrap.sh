#!/bin/bash

sudo lsblk
sudo growpart /dev/nvme0n1 4
sudo lvextend -r -L+30G /dev/mapper/RootVG-homeVol

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo dnf install -y terraform