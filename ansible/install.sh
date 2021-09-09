#!/bin/bash
usage()
{
  echo -e "Usage: $0 [-p PROFILE]\nWhere PROFILE is ( sh-test / sh-stage / sh-prod)"
  exit 2
}
if [ "$EUID" -ne 0 ]
then 
  echo "You are running as $(whoami) user. Please run as sudo"
  usage
  exit
fi
#--- Add the deb package in /etc/apt/source.list
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >>  /etc/apt/sources.list

#--- Add app key to server
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

# apt update and install ansible
apt update
apt install -y ansible
