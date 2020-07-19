#!/bin/bash

# update
sudo apt-get update -y 

# install apt deps
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential \
	python-dev \
	python-pip \
	libffi-dev \
    python-pip-whl \
	zip \
    mysql-server \
    redis

# install pip deps
pip install gunicorn virtualenv

#get ctfd
wget -q https://github.com/CTFd/CTFd/archive/2.5.0.zip
sudo unzip 2.5.0.zip -d /opt

# create ctfd user
sudo useradd ctfd -d /opt/CTFd-2.5.0
sudo chown -R ctfd.ctfd /opt/CTFd-2.5.0

# install python deps
sudo su ctfd -c "pip install virtualenv --user"
sudo su ctfd -c "/opt/CTFd-2.5.0/.local/bin/virtualenv /opt/CTFd-2.5.0"
sudo su ctfd -c "/opt/CTFd-2.5.0/bin/pip install -r /opt/CTFd-2.5.0/requirements.txt"

# copy systemd unit
sudo cp /tmp/ctfd.service /etc/systemd/system/ctfd.service

# provision dataase
echo "Initialising database"
commands="CREATE DATABASE ctfd;
CREATE USER 'ctfduser'@'localhost' IDENTIFIED BY 'ctfd';
GRANT USAGE ON *.* TO 'ctfduser'@'localhost' IDENTIFIED BY 'ctfd';
GRANT ALL privileges ON ctfd.* TO 'ctfduser'@'localhost';FLUSH PRIVILEGES;"
echo "${commands}" | sudo /usr/bin/mysql -u root -pctfd

# provision the db
sudo su ctfd -c "/opt/CTFd-2.5.0/.local/bin/python manage.py db upgrade"

# reload systemd
sudo systemctl daemon-reload

# enable and start ctfd
sudo systemctl enable redis
sudo systemctl enable mysql
sudo systemctl enable ctfd.service
