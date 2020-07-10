#!/bin/bash

# update
apt update -y && apt upgrade -y

# install apt deps
apt install -y python-dev \
    python-pip \
    git

# install pip deps
pip install gunicorn

# clone the repo
git clone https://github.com/isislab/CTFd.git /opt

