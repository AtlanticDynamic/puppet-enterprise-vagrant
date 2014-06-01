#!/bin/bash

PE_VER=$1
ANS_FILE=$2
INSTALL_SOURCE="/vagrant/pe-install/${PE_VER}.tar.gz"

if [ $UID != 0 ]
then
    echo "Must be run as root!"
    exit 1
fi

if [ -d '/opt/puppet' ]
then
    echo "PE is already installed."
    exit 0
fi

# If PE is not in the directory, show error
if [ ! -f $INSTALL_SOURCE ]
then
  echo "File not found: $INSTALL_SOURCE"
  echo "Please download Puppet Enterprise x64 for CentOS 6."
  exit 1
fi

cd /tmp
tar -xzf $INSTALL_SOURCE
/tmp/${PE_VER}/puppet-enterprise-installer -a $ANS_FILE
rm -rf /tmp/${PE_VER}
