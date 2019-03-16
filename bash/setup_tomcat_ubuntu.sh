#!/bin/bash
#
# This script installs and sets up tomcat on ubuntu 18.04.02
#

if ! [ $(id -u) = 0 ]
then
	echo "This script must be run as root. Exiting."
	exit 1
fi

sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y clean

if [ -f /var/run/reboot-required ]
then
	echo ""
	echo "Please reboot and then run this script again."
	exit 1
fi

sudo apt -y install build-essential gcc make perl dkms vim ant default-jdk mysql-server curl

sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# Latest tar.gz from http://tomcat.apache.org/download-90.cgi
cd /tmp
curl -O http://ftp.wayne.edu/apache/tomcat/tomcat-9/v9.0.16/bin/apache-tomcat-9.0.16.tar.gz

sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1

cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/

JAVA_HOME_DIR=`sudo update-java-alternatives -l |sed 's/^[^\/]*//g'`

sudo cat > /etc/systemd/system/tomcat.service << _EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=${JAVA_HOME_DIR}
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
_EOF

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo ufw allow 8080

sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y clean

if [ -f /var/run/reboot-required ]
then
	echo ""
	echo "Reboot is required."
	exit 1
fi

