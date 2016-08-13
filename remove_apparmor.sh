#!/usr/bin/env bash

update-rc.d apparmor disable
/etc/init.d/apparmor stop
/etc/init.d/apparmor teardown
update-rc.d -f apparmor remove
apt-get -y --purge remove apparmor apparmor-utils libapparmor-perl libapparmor1