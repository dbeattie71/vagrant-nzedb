# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://www.htpcguides.com/install-nzedb-ubuntu-private-usenet-indexing/
# https://github.com/nZEDb/nZEDb/blob/0.x/docs/Ubuntu-14.04.2-Install.md

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.provision :shell, path: 'install_swapfile.sh', keep_color: true, privileged: true
  config.vm.provision :shell, path: 'remove_apparmor.sh', keep_color: true, privileged: true
  config.vm.provision :shell, path: 'install_packages.sh', keep_color: true, privileged: true
  config.vm.provision :shell, path: 'install_percona.sh', :args => ["MyPassword"], keep_color: true, privileged: true
  config.vm.provision :shell, path: 'install_php_yenc_decode.sh', keep_color: true, privileged: false
  config.vm.provision :shell, path: 'cleanup.sh', keep_color: true, privileged: true

  config.vm.provision :shell, privileged: false, keep_color: true, inline:
<<SCRIPT
echo "setup"
sudo cp /vagrant/nZEDb /etc/nginx/sites-available/nZEDb
sudo chmod 644 /etc/nginx/sites-available/nZEDb

sudo unlink /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/nZEDb /etc/nginx/sites-enabled/nZEDb
sudo service php5-fpm restart
sudo service nginx restart
sudo usermod -aG www-data vagrant

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

cd /usr/share/nginx/
sudo chmod 777 /usr/share/nginx/
composer create-project --no-dev --keep-vcs nzedb/nzedb
sudo chmod 777 /usr/share/nginx/nzedb
cd /usr/share/nginx/nzedb
sudo chmod -R 755 .
sudo chmod 777 /usr/share/nginx/nzedb/resources/smarty/templates_c
sudo chmod -R 777 /usr/share/nginx/nzedb/www/covers
sudo chmod 777 /usr/share/nginx/nzedb/www
sudo chmod 777 /usr/share/nginx/nzedb/www/install
sudo mkdir /usr/share/nginx/nzedb/nzbfiles
sudo chmod -R 777 /usr/share/nginx/nzedb/nzbfiles


SCRIPT

end
