#!/bin/sh
ln -s -f crossos/Vagrantfile
ln -s -f crossos/ansible
ln -s -f crossos/ansible.cfg
ln -s -f crossos/boot.sh
ln -s -f crossos/provision.sh
if [ ! -e crossos/ansible/vars/secrets.yml ]; then
  echo "Don't forget to setup the local vars."
fi

