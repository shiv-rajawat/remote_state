#!/bin/bash
cd ../terra

terraform init
vpcid=$(aws ec2 describe-vpcs --query "Vpcs[?Tags[?Key=='Name']|[?Value=='myvpc']].VpcId" --region us-east-2 --output text)
echo ${vpcid}
len=${#vpcid}
echo $len
sleep 10s

