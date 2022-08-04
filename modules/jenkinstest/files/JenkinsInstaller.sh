#!/usr/bin/bash
/usr/bin/wget -qq -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
/usr/bin/sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
/usr/bin/sudo apt update
/usr/bin/sudo apt-get -qq install jenkins
/usr/bin/sudo systemctl start jenkins
/usr/bin/sudo systemctl status jenkins > /opt/status.txt