# Installing an Apache2/PHP7.1 web server

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
* BlackFire
* samba

## Requirements

* GIT: The script requires GIT. [https://git-scm.com/](https://git-scm.com/)

        sudo apt-get install git

## Installation

If you want to change your raspberrypi hostname, change the name of the MY_HOSTNAME variable.
Otherwise comment there with a #.

### Git Clone

You can also download the script source directly from the Git clone:

    git clone https://github.com/zohac/raspbian---installation-serveur.git

### Run the script

    bash raspbian---installation-serveur/install.sh

## After Reboot - Configure BlackFire

### Installing the Agent

[BlackFire.io](https://blackfire.io/docs/up-and-running/installation)

1. Configure your Blackfire credentials:

        sudo blackfire-agent -register

2. After registering the agent, and whenever you modify its configuration, you have to restart its service:

        sudo /etc/init.d/blackfire-agent restart

### Installing the Blackfire CLI tool

* Run the config command to initialize the client:

        blackfire config

## Issues

Bug reports and feature requests can be submitted on the [Github Issue Tracker](https://github.com/zohac/raspbian---installation-serveur/issues)

## Author

Simon JOUAN
[https://jouan.ovh](https://jouan.ovh)