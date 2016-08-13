#!/bin/bash -x
# Percona Server unattended installation script
# Paramter 1: MySql root user password
#
# The parameter must be supplied. If it is blank will you will asked
# for a password during the installation procedure

# from: http://chadwick.wikidot.com/perconadbinstallation
# http://stackoverflow.com/questions/36667254/unattended-percona-server-5-7-install-on-debian-jessie
# https://bugs.launchpad.net/percona-server/+bug/1407613
# https://serversforhackers.com/video/installing-mysql-with-debconf
# http://serverfault.com/questions/686000/vagrant-and-mariadb-provision

#Variables used in script
export DEBIAN_FRONTEND=noninteractive
export PERCONA_PW=$1
export DEBCONF_PREFIX="percona-server-server-5.7 percona-server-server-5.7"

#Check if password is supplied - Exit if no password supplied
[ ! $# -eq 1 ] && echo "Usage: $0 PASSWORD" && exit 1;

#Debian and Ubuntu packages from Percona are signed with a key. Before using the repository, you should add the key to apt.
echo "Adding package key"
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

#Add this to /etc/apt/sources.list
echo "Updating sources.list file with correct repo info"
sh -c "echo '#Percona' >> /etc/apt/sources.list"
sh -c "echo 'deb http://repo.percona.com/apt trusty main' >> /etc/apt/sources.list"
sh -c "echo 'deb-src http://repo.percona.com/apt trusty main' >> /etc/apt/sources.list"

#Update Local cache
echo "Updating local cache"
sudo apt-get update

#Set root password for unattended installation - This allows the installation to happen without a password prompt
echo "Setting root password"

#percona-server-server-5.7	percona-server-server-5.7/re-root-pass	password
#percona-server-server-5.7	percona-server-server-5.7/root-pass	password
#percona-server-server-5.7	percona-server-server-5.7/root-pass-mismatch	error
#percona-server-server-5.7	percona-server-server-5.7/data-dir	note
#percona-server-server-5.7	percona-server-server-5.7/remove-data-dir	boolean	false
echo "${DEBCONF_PREFIX}/root-pass password $PERCONA_PW" | sudo debconf-set-selections
echo "${DEBCONF_PREFIX}/re-root-pass password $PERCONA_PW" | sudo debconf-set-selections
#echo "${DEBCONF_PREFIX}/remove-data-dir boolean true" | sudo debconf-set-selections

#Install the Server and Client packages
DEBIAN_FRONTEND=noninteractive apt-get -y install percona-server-server-5.7 percona-server-client-5.7;

#Percona Mysql is now installed. Start the db using the following command:
#echo "Start Percona Mysql Server"
#service mysql start