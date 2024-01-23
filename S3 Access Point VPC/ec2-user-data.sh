#!/bin/bash
# Use this for your user data (script from top to bottom)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id -H "X-aws-ec2-metadata-token: $TOKEN")
REGION_ID=$(curl http://169.254.169.254/latest/meta-data/placement/region -H "X-aws-ec2-metadata-token: $TOKEN")
FINANCE_AP=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=FINANCEAP" --region $REGION_ID --output text --query "Tags[0].Value")
ANALYTICS_AP=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=ANALYTICSAP" --region $REGION_ID --output text --query "Tags[0].Value")

echo === Finance access point === > log.txt

echo - Should upload test file >> log.txt
echo This is just a test > test.txt
aws s3api put-object --bucket $FINANCE_AP --key finance/test.txt --body test.txt >> log.txt 2>&1

echo - Should list files >> log.txt
aws s3api list-objects-v2 --bucket $FINANCE_AP >> log.txt 2>&1

echo - Should get an uploaded file >> log.txt
aws s3api get-object --bucket $FINANCE_AP --key finance/test.txt downloaded_test.txt >> log.txt 2>&1
cat downloaded_test.txt >> log.txt

echo === Analytics access point === >> log.txt

echo - Should list files >> log.txt
aws s3api list-objects-v2 --bucket $ANALYTICS_AP >> log.txt 2>&1

echo - Should an uploaded file >> log.txt
aws s3api get-object --bucket $ANALYTICS_AP --key finance/test.txt downloaded_test_2.txt >> log.txt 2>&1
cat downloaded_test_2.txt >> log.txt

echo - Should not allow to upload files >> log.txt
echo This is just a second test > test_2.txt
aws s3api put-object --bucket $ANALYTICS_AP --key finance/test_2.txt --body test_2.txt >> log.txt 2>&1
