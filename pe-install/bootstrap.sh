#!/bin/bash

PE_VER='puppet-enterprise-3.2.3-el-6-x86_64'
ANS_FILE=$1

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

cd /tmp
tar -xzf "/vagrant/pe-install/${PE_VER}.tar.gz"
/tmp/${PE_VER}/puppet-enterprise-installer -a $ANS_FILE
