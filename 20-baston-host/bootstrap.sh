#!/bin/bash

sudo lsblk
sudo growpart /dev/nvme0n1 4
sudo lvextend -r -L+30G /dev/mapper/RootVG-homeVol

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo dnf install -y terraform

sudo git clone https://github.com/pattasai123/roboshop-dev-infra.git
sudo cd 40-databases
sudo terraform init
sudo terraform apply -auto-approve