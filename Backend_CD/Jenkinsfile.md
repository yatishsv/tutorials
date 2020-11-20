pipeline {
    agent any
    stages{

        stage('Testing on single instance'){
           steps{
               script{
                    withAWS(credentials: 'aws', region: 'ap-southeast-1'){  

                    echo'===============Deploying on one instance for testing purpose=================' 

                    tg_arn = sh (
                                    script: "aws elbv2 describe-target-groups --query 'TargetGroups[*].TargetGroupArn' --names ${env.JOB_NAME}  | jq -r .[]",
                                    returnStdout: true
                              ).trim()  

                    echo "Target Group ARN= ${tg_arn}" 

                    test_instance = sh (
                                    script: "aws elbv2 describe-target-health --query 'TargetHealthDescriptions[1].Target.Id' --target-group-arn ${tg_arn}",
                                    returnStdout: true
                              ).trim()  

                    echo "Test instance ID= ${test_instance}"

                    echo " Deploying changes on test instance ${test_instance}"

                    sh """/opt/jenkins/single_instance.sh ${env.JOB_NAME} ${test_instance}"""
                    }
                }
            }
        }

        stage('Approval'){
        agent any    
           steps{
               script{
                    env.DEPLOY = input (message: ' Select "DEPLOY" to deploy on all instances in target group, Select "REVERT" after making git revert MANUALLY to roll back changes in test instance, Select "ABORT" to terminate deploment process',
                            parameters: [choice(name: 'DEPLOY', choices: 'DEPLOY\nABORT\nREVERT', description: 'Deployment Choices:')])
                }
                echo "${env.DEPLOY}"
            }
        }

        stage('Deploying all instances in target Group'){
        agent any  
           when{
                expression { "${env.DEPLOY}" == 'DEPLOY' }
            }     
           steps{
               script{
                    withAWS(credentials: 'aws', region: 'ap-southeast-1'){
                        echo'===============Deploying on all the instances=================' 
                        sh """/opt/jenkins/deployment.sh ${env.JOB_NAME}"""
                    }
                }
            }
        }

        stage('Reverting back test instance'){
        agent any
           when{
                expression { "${env.DEPLOY}" == 'REVERT' }
            }     
           steps{
               script{       
                    withAWS(credentials: 'aws', region: 'ap-southeast-1'){
                        echo'===============Reverting back changes=================' 
                        sh """/opt/jenkins/single_instance.sh ${env.JOB_NAME} ${test_instance}"""
                    }
                }
            }
        }

        stage('Deployment Aborted'){
        agent any  
           when{
                expression { "${env.DEPLOY}" == 'ABORT' }
            }     
           steps{
               script{
                        echo'=============== Contact Admin if you have faced any issues ================='
                }
            }
        } 
    }
}