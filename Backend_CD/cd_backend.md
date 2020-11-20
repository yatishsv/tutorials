```
# 1.Get target Group ARN using Target group name

tg_arn=$(aws elbv2 describe-target-groups --names "cd-test" --query "TargetGroups[*].TargetGroupArn" | jq -r .[])

# 2.Get Targets using Target group ARN : Save it to array variable "Targets"

targets_json=$(aws elbv2 describe-target-health  --target-group-arn $tg_arn --query 'TargetHealthDescriptions[*].Target.Id')

readarray -t targets < <(jq -r '.[]' <<< "$targets_json")

# 3. Get number of instances and save it to tgtotal

tgtotal =$(aws elbv2 describe-target-health  --target-group-arn arn:aws:elasticloadbalancing:ap-southeast-1:856517911253:targetgroup/cd-test/6a1736553963706a --query 'TargetHealthDescriptions[*].Target.Id' | jq length)

# 3.For each instance in the Target.

# 3.1 Deregister a Target from Target group

aws elbv2 deregister-targets --target-group-arn arn:aws:elasticloadbalancing:ap-southeast-1:856517911253:targetgroup/cd-test/6a1736553963706a --targets Id="i-0c0c9ebedbeeb7193"

## 3.2 Confirm

# 3.2 Update the Target with recebt AWS ssm agent

aws ssm send-command --document-name "AWS-UpdateSSMAgent" --document-version "1" --targets '[{"Key":"InstanceIds","Values":["i-071f400a278c47f7c"]}]' --parameters '{"version":[""],"allowDowngrade":["false"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "infra.pocketfm" --region ap-southeast-1

# 3.2.1 Update the Target with recent AWS ssm agent, Also get command ID for checking status

aws ssm send-command --document-name "AWS-UpdateSSMAgent" --document-version "1" --targets Key=instanceids,Values= i-071f400a278c47f7c --parameters '{"version":[""],"allowDowngrade":["false"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "infra.pocketfm" --region ap-southeast-1  | jq -r '.Command.CommandId'

# 3.3 Confirm that above command was a success
aws ssm get-command-invocation --command-id  558ae783-d015-4b3c-a3fc-e67f52a1ac76 --instance-id i-082169b79bc1005dd| jq -r '.Status'

# 3.3 Git pull recent Repo and restart httpd service, outputs the command ID

aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" --targets '[{"Key":"InstanceIds","Values":["i-071f400a278c47f7c"]}]' --parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["sudo su","cd /var/www/radioly/radioly_client_api/v2/feed_api","git pull origin master","service httpd restart",""]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "infra.pocketfm" --region ap-southeast-1  | jq -r '.Command.CommandId'



# 3.3 Confirm that above command was a success
aws ssm get-command-invocation --command-id  558ae783-d015-4b3c-a3fc-e67f52a1ac76 --instance-id i-082169b79bc1005dd| jq -r '.Status'


# 4. Register the target back
aws elbv2 register-targets --target-group-arn arn:aws:elasticloadbalancing:ap-southeast-1:856517911253:targetgroup/cd-test/6a1736553963706a --targets Id=i-082169b79bc1005dd
```