#!/bin/bash

# update
apt update -y 

# install apt deps
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential \
	python-dev \
	python-pip \
	libffi-dev \
    python-pip-whl \
	zip

# install pip deps
pip install gunicorn virtualenv

#get ctfd
wget -q https://github.com/CTFd/CTFd/archive/2.5.0.zip
unzip 2.5.0.zip -d /opt

# create ctfd user
sudo useradd ctfd -d /opt/CTFd-2.5.0
sudo chown -R ctfd.ctfd /opt/CTFd-2.5.0

# install python deps
sudo su ctfd -c "pip install virtualenv"
sudo su ctfd -c "virtualenv /opt/CTFd-2.5.0"
sudo su ctfd -c "source /opt/CTFd-2.5.0/bin/activate && pip install -r /opt/CTFd-2.5.0/requirements.txt"

# copy systemd unit
cp /vagrant/ctfd.service /etc/systemd/system/ctfd.service

# enable ctfd unit
sudo systemctl enable ctfd.service

# reload systemd
sudo systemctl daemon-reload
