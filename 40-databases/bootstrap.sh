#!/bin/bash

component=$1
env=$2

dnf install -y ansible git

REPO_URL="https://github.com/pattasai123/ansi_roles_tf.git"
REPO_DIR="/opt/roboshop/ansible"
ANSIBLE_DIR="ansi_roles_tf"

mkdir -p "$REPO_DIR"
mkdir -p /var/log/roboshop
touch /var/log/roboshop/ansible.log

cd "$REPO_DIR" || exit 1

if [ -d "$ANSIBLE_DIR" ]; then
    cd "$ANSIBLE_DIR" || exit 1
    git pull
else
    git clone "$REPO_URL"
    cd "$ANSIBLE_DIR" || exit 1
fi

ansible-playbook \
    -e component="$component" \
    -e env="$env" \
    main.yaml

# ansible-playbook -e component=$component -e env=$env main.yaml



