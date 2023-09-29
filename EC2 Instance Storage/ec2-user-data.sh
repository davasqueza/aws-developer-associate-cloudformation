Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
# Use this for your user data (script from top to bottom)
yum update -y
yum install -y amazon-efs-utils # Installs Amazon EFS utilities for mounting EFS file systems
yum install -y jq # Installs JQ for parsing JSON

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
REGION_ID=$(curl http://169.254.169.254/latest/meta-data/placement/region)
EFS_TAG=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=EFSID" --region $REGION_ID)
EFS_ID=$(echo $EFS_TAG | jq -r ".[][].Value")

mkdir /mnt/efs

mount -t efs -o tls $EFS_ID:/ /mnt/efs
--//