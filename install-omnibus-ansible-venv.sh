#!/usr/bin/env bash

VERSION=""

usage() {
  echo "How to use it"
}

if [ "$#" -gt 1 ]; then
  usage
  exit 1
elif [ "$1" == "-h" ]; then
  usage
  exit 0
else
  # set the version so pip can install
  VERSION="$1"
fi

apt-get update -q
DEBIAN_FRONTEND=noninteractive apt-get -y install ruby && rm -rf /home/vagrant/.cache
DEBIAN_FRONTEND=noninteractive apt-get -yq install python-virtualenv
virtualenv /opt/ansible-omnibus
# Install the latest version of pip
/opt/ansible-omnibus/bin/pip install -U pip


if [ -z $VERSION ]; then
  /opt/ansible-omnibus/bin/pip install ansible
else
  /opt/ansible-omnibus/bin/pip install ansible==${VERSION}
fi