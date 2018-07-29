#!/bin/bash
# Version 0.1

printf "${GREEN}"
echo ' _       __     __                        '
echo '| |     / /__  / /________  ____ ___  ___ '
echo '| | /| / / _ \/ / ___/ __ \/ __ `__ \/ _ \'
echo '| |/ |/ /  __/ / /__/ /_/ / / / / / /  __/'
echo '|__/|__/\___/_/\___/\____/_/ /_/ /_/\___/ '
echo ''
echo ''
printf "${NORMAL}"

# Mise à jour du serveur
printf "${GREEN}"
echo '###########################################'
echo '#         Mise à jour globale !           #'
echo '###########################################'
echo ''
echo ''
printf "${NORMAL}"
apt-get -y update && apt-get -y upgrade

# Liste des paquets pouvant-être mis à jour
# apt list --upgradable

# Installation des dépendances
printf "${GREEN}"
echo '###########################################'
echo '#              Installation               #'
echo '#            des dependances              #'
echo '###########################################'
echo ''
echo ''
printf "${NORMAL}"
apt-get install -y build-essential
apt-get install -y apt-transport-https
apt-get install -y zip
apt-get install -y git
apt-get install -y python-pip
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
python setup.py install

# Installation apache2
printf "${GREEN}"
echo '###########################################'
echo '#         Installation apache2            #'
echo '###########################################'
echo ''
echo ''
printf "${NORMAL}"
apt-get install -y apache2
# Ajout du module rewrite
a2enmod rewrite
service apache2 restart

# Installation MySQL
printf "${GREEN}"
echo '###########################################'
echo '#           Installation MySQL            #'
echo '###########################################'
echo ''
echo ''
printf "${NORMAL}"
apt-get install -y mysql-server

# Installation php7.1
printf "${GREEN}"
echo '###########################################'
echo '#           Installation php7.1           #'
echo '###########################################'
echo ''
echo ''
printf "${NORMAL}"
echo "deb http://mirrordirector.raspbian.org/raspbian/ buster main contrib non-free rpi">>/etc/apt/sources.list
apt-get update -y
# apt-cache pkgnames | grep php7.1
apt-get install -y php7.1 php7.1-cli php7.1-common libapache2-mod-php7.1 php7.1-mysql php7.1-fpm php7.1-curl php7.1-gd php7.1-bz2 php7.1-mcrypt php7.1-json php7.1-tidy php7.1-mbstring php7.1-xml php7.1-dev php7.1-soap php-redis php-memcached php7.1-zip php7.1-apcu php7.1-sqlite3
a2enmod proxy_fcgi setenvif
a2enconf php7.1-fpm
systemctl reload apache2

pecl install xdebug

# Configuration date
sed -i "s/;date.timezone =/date.timezone = Europe\/Paris/g" /etc/php/7.1/apache2/php.ini

# Configuration de Xdebug
echo "
xdebug.show_error_trace = 1
" >> /etc/php/7.1/mods-available/xdebug.ini

echo '
;;;;;;;;;;;;;;;;;;;;
;      xdebug      ;
;;;;;;;;;;;;;;;;;;;;
zend_extension="/usr/lib/php/20160303/xdebug.so"

xdebug.remote_enable = On
' >> /etc/php/7.1/apache2/php.ini

echo '
;;;;;;;;;;;;;;;;;;;;
;      xdebug      ;
;;;;;;;;;;;;;;;;;;;;
zend_extension="/usr/lib/php/20160303/xdebug.so"

xdebug.remote_enable = On
' >> /etc/php/7.1/cli/php.ini

service apache2 restart

#
# Composer
#
# curl -sS https://getcomposer.org/installer | php
# mv composer.phar /usr/local/bin/composer.phar
# echo "
# alias composer='/usr/local/bin/composer.phar'" >> ~/.bashrc
# . ~/.bashrc
#
# PHP-CS-FIXER
#
# composer global require friendsofphp/php-cs-fixer
#
# PHP code sniffer
#
# composer global require "squizlabs/php_codesniffer=*"
# echo "
# alias php-cs-fixer='/home/zohac/.config/composer/vendor/bin/php-cs-fixer'
# alias phpcs='/home/zohac/.config/composer/vendor/bin/phpcs'
# alias phpcbf='/home/zohac/.config/composer/vendor/bin/phpcbf'
# export PATH='$PATH:$HOME/.config/composer/vendor/bin'" >> ~/.bashrc
# . ~/.bashrc
#
# PHP md
#
# wget -c http://static.phpmd.org/php/latest/phpmd.phar
# mv phpmd.phar /usr/local/bin/phpmd.phar
# chmod u+x /usr/local/bin/phpmd.phar
# echo "
# alias phpmd='/usr/local/bin/phpmd.phar'" >> ~/.bashrc
# . ~/.bashrc
#
# PHP Copy/Paste Detector (PHPCPD)
#
# wget https://phar.phpunit.de/phpcpd.phar
# chmod +x phpcpd.phar
# mv phpcpd.phar /usr/local/bin/phpcpd
# echo "alias phpcpd='/usr/local/bin/phpcpd'" >> ~/.bashrc

# exemple commande:
#
# php-cs-fixer fix src --rules=@Symfony,-@PSR1,-@PSR2
# phpcs
# phpcbf
# phpmd src html codesize,unusedcode,naming --reportfile phpmd.html --suffixes php,phtml

# Installation de postfix, envoie seulement de mail
echo "
###########################################
#          Installation postfix           #
###########################################"
apt-get -y install postfix
apt-get install -y mailutils
# Site internet
# home-ubuntu-server
# /etc/postfix/main.cf
# sudo dpkg-reconfigure postfix
# echo "Cesi est un mail de test" | mail -s "Sujet de test" fenrir0680@gmail.com

# Installation de postfix, envoie seulement de mail
echo "
###########################################
#          Configuration serveur          #
###########################################"
mkdir /home/zohac/www
chown -R zohac:www-data /home/zohac/www

echo "ServerName localhost" >> /etc/apache2/conf-available/servername.conf
a2enconf servername
service apache2 reload
rm /etc/apache2/sites-available/000-default.conf
echo "
<VirtualHost *:80>

        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /home/zohac/www
        <Directory /home/zohac/www/>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Require all granted
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
		
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet"  >> /etc/apache2/sites-available/000-default.conf

apache2ctl configtest
service apache2 reload

# Nettoyage après installation
echo "
###########################################
#                 SAMBA                   #
###########################################"
apt-get install samba

#Ajouter à la fin du fichier de config
echo "
[Share]
comment = Share
path = /home/zohac
writeable = yes
guest ok = yes
create mask = 0644
directory mask = 0755
force user = zohac" >> /etc/samba/smb.conf

# Shell custom
echo "
###########################################
#        Installation de zsh              #
###########################################"


# Nettoyage après installation
echo "
###########################################
#               Nettoyage                 #
###########################################"
apt-get -y autoremove --purge
apt-get -y autoclean

printf "${GREEN}"
echo ' _____         __                    '
echo '/__  /  ____  / /_  ____ ______      '
echo '  / /  / __ \/ __ \/ __ `/ ___/      '
echo ' / /__/ /_/ / / / / /_/ / /__        '
echo '/____/\____/_/ /_/\__,_/\___/  script'
echo '                                     ....is now installed!'
echo ''
echo ''
printf "${NORMAL}"
