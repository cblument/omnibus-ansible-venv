#!/usr/bin/env bash

VERSION=""

usage() {
  echo "How to use it"
}

if [ "$#" -gt 2 ]; then
  usage
  exit 1
fi

case "$1" in
  "")
    # Pass through will install latest version of ansible
    ;;
  "-h")
    usage
    exit 0
    ;;
  "-v")
    shift
    ANSIBLE_VERSION="$1"
    ;;
  *)
    usage
    exit 1
esac

apt-get update -q
DEBIAN_FRONTEND=noninteractive apt-get -y install ruby && rm -rf /home/vagrant/.cache
DEBIAN_FRONTEND=noninteractive apt-get -yq install python-virtualenv
virtualenv /opt/ansible-omnibus
# Install the latest version of pip
/opt/ansible-omnibus/bin/pip install -U pip

if [ -z $ANSIBLE_VERSION ]; then
  /opt/ansible-omnibus/bin/pip install ansible
else
  /opt/ansible-omnibus/bin/pip install ansible==${ANSIBLE_VERSION}
fi