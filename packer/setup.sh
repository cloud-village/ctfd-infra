#!/bin/bash

# update
apt update -y 

# install apt deps
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential \
	python-dev \
	python-pip \
	libffi-dev
    python-pip-whl \
    git \
	zip

# install pip deps
pip install gunicorn

#get ctfd
wget https://github.com/CTFd/CTFd/archive/2.5.0.zip
unzip 2.5.0.zip -d /opt

# create ctfd user
sudo useradd ctfd -d /opt/2.5.0
sudo chown -R ctfd.ctfd /opt/2.5.0

# install python deps
sudo su ctfd -c "pip install -r /opt/2.5.0/requirements.txt"

# copy systemd unit
cp /vagrant/ctfd.service /etc/systemd/system/ctfd.service

# reload systemd
sudo systemctl daemon-reload
