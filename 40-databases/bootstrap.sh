#!/bin/bash

dnf ansible install -y
ansible-pull https://github.com/pattasai123/ansi_roles_tf.git -e component=mongodb main.yaml