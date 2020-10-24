#!/bin/bash

# Author: Olari Pipenberg

# This script converts machine Debian-like machine into schoolbell application.
# Prerequisites: Tested with Debian 10 operating system, Internet access, filesystem must be extended if you are using Raspberry PI.
# Please read carefully this script before executing.

echo "Please read carefully this script before executing. If you have not read yet, press (CTRL + C). You will be warned! To begin press enter."
read

# TODO fail2ban, error checks

if [ $"$EUID" -ne 0 ]; then
    echo "Script requires root permisssions."
    exit 1
fi

# Install required packages
apt update && 
apt -y install alsa-utils pulseaudio mplayer apache2 fail2ban vim php-fpm php7.3 libapache2-mod-authnz-external pwauth

if [ $? -ne 0 ]
then
	echo "Failed to install update/install packages!"
	exit 1;
fi
sleep 2;

echo "Lets set up account and configure sound. Press enter to begin:"
read

# Set up account and configure sound
echo "Lets create account for schoolbell user"
groupadd -g 1050 schoolbell; useradd -g 1050 -u 1050 -s /bin/bash -d /home/schoolbell -m schoolbell
echo "Password for schoolbell account:"
passwd schoolbell
usermod -aG audio schoolbell # allow scholbell to play music
su - schoolbell -c "mkdir /home/schoolbell/.mplayer/" > /dev/null
echo "softvol=true" >> /home/schoolbell/.mplayer/config
chown schoolbell:schoolbell /home/schoolbell/.mplayer/config
# make sure to disable either hdmi or 3.5 jack if using Raspberry PI
/usr/bin/amixer -M -c 0 set 'Master' 80% /dev/null 2>&1
/usr/bin/amixer -M -c 0 set 'Headphone' 80% /dev/null 2>&1
/usr/bin/amixer -M -c 0 set 'Speaker' 80% /dev/null 2>&1
/usr/bin/amixer -M -c 0 set 'PCM' 80% /dev/null 2>&1

echo "Lets configure schoolbell time. Press enter to begin:"
read
# Set correct time
timedatectl set-ntp true # Synchronize time with ntp servers
timedatectl set-timezone Europe/Tallinn

# Fail2ban
echo "Lets configure fail2ban. Press enter to begin:"
read
cp ./install/fail2ban/apache-parool.conf /etc/fail2ban/filter.d/
systemctl restart fail2ban

echo "Lets configure cronjob-predictor. Press enter to continue:"
read
apt-get install python-pip
pip install croniter

echo "Lets copy schoolbell configuration to /home/schoolbell. Press enter to continue:"
read
cp -r ./install/ding_conf/ /home/schoolbell/
chown -R schoolbell:schoolbell /home/schoolbell/

echo "Finally lets add root crontab. Press Enter to continue:"
read
crontab -u root ./install/global/root_crontab

echo "Lets configure apache2. Press enter to begin:"
read
# Configure apache/php-fpm and HTTPS
a2dissite 000-default # disable default apache site
# php-fpm conf
a2enmod alias proxy proxy_fcgi
mkdir -p /var/www/schoolbell/
a2enmod ssl rewrite
cp ./install/apache/schoolbell-tls.conf /etc/apache2/sites-available/
cp ./install/apache/schoolbell.conf /etc/apache2/sites-available/
cp ./install/php-fpm/schoolbell.conf /etc/php/7.3/fpm/pool.d/
systemctl restart php7.3-fpm

echo "Configure schoolbell account password, copy DocumentRoot files, restart apache2 unit. Press enter to begin:"
read
passwd schoolbell
cp -r ./install/apache/website/* /var/www/schoolbell/
a2ensite schoolbell schoolbell-tls
systemctl restart apache2

echo "Installation finished!"
