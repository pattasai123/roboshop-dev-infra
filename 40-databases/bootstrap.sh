#!/bin/bash

component=$1
dnf ansible install -y
ansible-pull https://github.com/pattasai123/ansi_roles_tf.git -e component=$component main.yaml