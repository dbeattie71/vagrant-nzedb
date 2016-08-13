#!/usr/bin/env bash

function install {
    echo installing $1
    #apt-get -y install $1
    apt-get -y install $1 >/dev/null 2>&1
}

function update {
    echo updating package information
    # apt-get -y update
    apt-get -y update >/dev/null 2>&1
}

function upgrade {
    echo upgrade package information
    # apt-get -y update
    apt-get -y upgrade >/dev/null 2>&1
}

install software-properties-common
install python-software-properties
install git
install python3-setuptools
install python3-pip
python3 -m easy_install pip
easy_install3 cymysql
update
upgrade
install php5
install php5-cli
install php5-dev
install php5-json
install php-pear
install php5-gd
install php5-mysqlnd
install php5-curl
install nginx
install php5-fpm
install unrar
install p7zip-full
install libav-tools
install lame
install mediainfo
install par2
install memcached
install php5-memcached
update
upgrade