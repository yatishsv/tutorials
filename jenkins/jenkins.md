# Jenkins

## On Jenkins-Master(Amazon AMI-2): -

Basic installation

```
sudo su
yum update -y
wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install java-1.8* git docker jenkins -y
systemctl daemon-reload
groupadd docker
usermod -a -G docker jenkins
systemctl start docker
systemctl start jenkins
sleep 20
cat /var/lib/jenkins/secrets/initialAdminPassword
```

Plugin config:-

### Additional steps:-

Set the java home path:-
- find /usr/lib/jvm/java-1.8* | head -n 3
    - /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-1.amzn2.0.1.x86_64 #Java Home path looks like this
- vi ~/.bash_profile 
    - JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-1.amzn2.0.1.x86_64
    - PATH=$PATH:$JAVA_HOME:$HOME/bin
- source ~/.bash_profile

### In Jenkins Console

Manage Jenkins →  Global Tool Configuration → Name (Java-1.8) → JAVA_HOME(/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.265.b01-1.amzn2.0.1.x86_64)
Setting Bitnami application password to 'vvTDLMDZWRi6'         #
[   86.686775] bitnami[530]: #        (the default application username is 'user')   

## On Jenkins-Master(Amazon AMI-2): -