#!/bin/bash

component=$1

dnf install -y ansible

ansible-pull \
  -U https://github.com/pattasai123/ansi_roles_tf.git \
  -e component=$component \
  main.yaml