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

DEBIAN_MAJOR="$(cat /etc/debian_version | cut -f1 -d.)"

apt-get update -q
DEBIAN_FRONTEND=noninteractive apt-get -yq install ruby && rm -rf /home/vagrant/.cache
# Fix ssl on wheezy
if [ $DEBIAN_MAJOR -eq 7 ]; then
  DEBIAN_FRONTEND=noninteractive apt-get -yq install --only-upgrade libssl1.0.0
fi
DEBIAN_FRONTEND=noninteractive apt-get -yq install python-virtualenv
virtualenv /opt/ansible-omnibus
# Install the latest version of pip
/opt/ansible-omnibus/bin/pip install -U pip -i https://pypi.python.org/simple/

if [ -z $ANSIBLE_VERSION ]; then
  /opt/ansible-omnibus/bin/pip install ansible
else
  /opt/ansible-omnibus/bin/pip install ansible==${ANSIBLE_VERSION}
fi