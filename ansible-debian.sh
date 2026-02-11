#!/bin/bash
# Debian/Ubuntu ansible setup
apt update
apt install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible
