#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd # Installs Apache HTTP Server

amazon-linux-extras install epel -y
yum install stress -y  # Installs stress utility
# stress -c 4 -t 500 # Stress the instance to test ASG

systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1> using CloudFormation" > /var/www/html/index.html
