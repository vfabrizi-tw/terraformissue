#!/bin/bash -e

BOOTSTRAP_SCRIPT="cogentserver-bootstrap.tgz"
BUCKET="s3://pyramid-aws-dev/dev/infra"


BOOTSTRAP_URL="$BUCKET/$BOOTSTRAP_SCRIPT"

#temporary stuff
apt-get update; apt-get install nginx -y; service nginx start


#we need to install the aws cli client
apt-get update -y; apt-get install unzip -y
wget "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -O /root/awscli-bundle.zip
unzip /root/awscli-bundle.zip -d /root
/root/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

#fetching the bootstrap file
aws s3 cp "$BOOTSTRAP_URL" /root/bootstrap.tgz
tar xvzf /root/bootstrap.tgz -C /root/
chmod +x /root/bootstrap/bootstrap.sh
/root/bootstrap/bootstrap.sh
