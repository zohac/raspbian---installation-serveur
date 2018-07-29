# Installation d'un serveur web Apache2/PHP7.1

Installing Apache2/PHP7.1/MySQL for a development web server on a raspberrypi.

Script tested on linux distribution Raspbian Stretch Lite.
[Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/)

The script installs the following components:

* Apache2
* MySQL
* PHP7.1
* xdebug
* The zsh shell with oh-my-zsh framework
* Composer
* PHP-CS-FIXER
* PHP code sniffer
* PHP md
* PHP Copy/Paste Detector
* samba

## Requirements

* GIT: The script requires GIT. [https://git-scm.com/](https://git-scm.com/)

        sudo apt-get install git

## Installation

### Git Clone

You can also download the script source directly from the Git clone:

    git clone https://github.com/zohac/raspbian---installation-serveur.git

### Run the script

    bash raspbian---installation-serveur/install.sh

## Issues

Bug reports and feature requests can be submitted on the [Github Issue Tracker](https://github.com/zohac/raspbian---installation-serveur/issues)

## Author

Simon JOUAN
[https://jouan.ovh](https://jouan.ovh)