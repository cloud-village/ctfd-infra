#!/bin/bash

# install the latest awscli to make sure we can access SSM
# and ansible to run the playbook
pip install -U awscli ansible

# update the configs
ansible-playbook /tmp/update-configs.yml

# cleanup
rm -rf /tmp/*
