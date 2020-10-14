

### Install Java, Maven, Git and export JAVA_HOME, Maven and git environment variables in local system

```
$ pwd
/Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home

$ vi .bash_profile

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home

export PATH=/Users/yv/Downloads/apache-maven-3.6.3/bin:$PATH
```

### Configure Jenkins to Work with Java, Git and Maven 

Provide Name and Path in *Global Tool Configuration*

### Create a Maven Job

Build Triggers:-
1. Trigger builds remotely (from scripts)
1. Build after other projects are build
1. Build periodically
1. Build when change is pushed to GitHub (Push type using webhooks)
1. Poll SCM (Pull type): * * * * * (Every minute) 0 0 * * * (Every day at midnight) 0 2-4 * * * (2am, 3am and  4am every day)

###  Continuos Inspection with Jenkins

1. Code quality and Code coverage Metrics report using static analysis tools : Use *Checkstyle* Plugin and/or Jenkins *PMD* plugin and/or Jenkins *Finbugs* plugin

###  Continuos Delivery with Jenkins

1. Archive Build Artifacts: Post Build steps --> Archive the artifacts --> **/*.war
1. Deploy the artifact in tomcat server (Staging environment)
    1. Download Tomcat
    1. chmod  +x /tomact-folder/bin/*
    1. Change to Port 8090 in connector block in /tomact-folder/conf/server.xml
    1. Add role manager-script, admin-gui and change tomcat user password in /tomact-folder/conf/tomcat-users.xml
    1. start tomcat server
1. Install *copy artifact* and *deploy to container* plugins
1. Downstream Job config:
    1. create new Job (deploy-to-staging)
    1. Build step: Copy artifact from another project
    1. Post Build: Deploy war/ear to container: Specify credentials
1. Upstrem Job config:
    1. *Package* project --> Post build --> Build other projects
1. *Build Pipelin* plugin --> new View --> initial Job (Package)
1. Deploy the artifact in new tomcat server (Production environment)
    1. 1. *deploy-to-staging* project --> Post build --> Build other projects (manual)

###  Pipeline as a code with Jenkins

Jenkinsfile v1.0 (Replicating previous exercise via package job pipeline (Jenkinsfile invoking))
```
pipeline {
    agent any
    tools {
        maven 'localMaven'
    }    
    stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        stage ('Deploy to Staging'){
            steps {
                build job: 'Deploy-to-staging'
            }
        }

        stage ('Deploy to Production'){
            steps{
                timeout(time:5, unit:'DAYS'){
                    input message:'Approve PRODUCTION Deployment?'
                }

                build job: 'Deploy-to-Prod'
            }
            post {
                success {
                    echo 'Code deployed to Production.'
                }

                failure {
                    echo ' Deployment failed.'
                }
            }
        }


    }
}
```

Fully automated Jenkinsfile: v1.1

1. Configure AWS Security groups for tomcat servers and create key pairs
1. provision EC2 on AWS to simulate staging and production environments
1. Install and run Tomcat on AWS instances
    1. Choose Amazone Linux 1 AMI (not 2)
    ```
    sudo yum install tomcat7 -y
    sudo service tomcat7 start
    sudo chown ec2-user /var/lib/tomcat7/webapps
    ```
1. fully automate existing Jenkins pipeline

```



```


