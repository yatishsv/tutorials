#!/bin/bash

tg_name=$1
echo "Target group name=$tg_name"

tg_arn=$(aws elbv2 --region ap-southeast-1 describe-target-groups --names $tg_name --query "TargetGroups[*].TargetGroupArn" | jq -r .[])
echo "Target group ARN=$tg_arn"

tgtotal=$(aws elbv2 --region ap-southeast-1  describe-target-health  --target-group-arn $tg_arn --query 'TargetHealthDescriptions[*].Target.Id' | jq length)
echo "Total number of current targets = $tgtotal"

## Deregister Target and confirm

target=$2
        
echo "Deregistering Target $target"
aws elbv2 --region ap-southeast-1 deregister-targets --target-group-arn $tg_arn --targets Id=$target
tgcurrent=$tgtotal
while [ "$tgcurrent" -eq "$tgtotal" ]
do
    echo "Target deregistration is in progress" 
    sleep 60
    let tgcurrent=$(aws elbv2 --region ap-southeast-1  describe-target-health  --target-group-arn $tg_arn --query 'TargetHealthDescriptions[*].Target.Id' | jq length)
    echo "Number of Registered Tartgets = $tgcurrent"
done

echo "Deregistered target $target successfuly"

## Revert Changes : Deploy current master merge

echo "Deploying changes"
         
commandID2=$(aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" --targets Key=instanceids,Values=$target  --parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["sudo su","cd /var/www/radioly/radioly_client_api/v2/feed_api","git pull origin master","service httpd restart",""]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "infra.pocketfm" --region ap-southeast-1  | jq -r '.Command.CommandId')

echo "Confirming Deployment"

status2=$(aws ssm --region ap-southeast-1 get-command-invocation --command-id  $commandID2 --instance-id $target| jq -r '.Status')

until [ "$status2" == "Success" ]
do
   status2=$(aws ssm --region ap-southeast-1 get-command-invocation --command-id  $commandID2 --instance-id $target| jq -r '.Status')
   echo "status = $status2"
   sleep 10
done

echo "Deployment confirmed"

echo "Registering back the Target $target"

aws elbv2 --region ap-southeast-1  register-targets --target-group-arn $tg_arn --targets Id=$target