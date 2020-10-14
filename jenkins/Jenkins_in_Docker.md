***************************
JENKINS IN DOCKER CONTAINER
***************************
# COMMANDS:-

build:
	docker pull jenkins/jenkins

run:

# -d flag : Detached mode: Run container in the background, print new container id. Container exits when the root process used to run the container exits

# --env JAVA_OPTS="-Xmx8192m" : Gives Jenkins 8 GB memory pool and room to handle garbage collection.

# --env JENKINS_OPTS=" --handlerCountMax=300" Gives Jenkins base pool of handlers and a cap as we get a lot of traffic to our Jenkins server

docker run -p 8080:8080 --name=jenkins-master -d --env JAVA_OPTS="-Xmx8192m" --env JENKINS_OPTS="--handlerCountMax=300" jenkins/jenkins

start:
	docker start jenkins-master
stop:
	docker stop jenkins-master
clean:	stop
	docker rm -v jenkins-master

**********************
JENKINS IN DOCKERFILE
**********************

Dockerfile :-
# Create and  change ownership of Jenkins Log Folder : 
# Set default options (RAM and higher base pool)
# Tell Jenkins to write logs to that folder on startup by modifying the JENKINS_OPTS environment variables.
___________________________________________________________________________________________________
FROM jenkins/jenkins:2.112
LABEL maintainer="mstewart@riotgames.com"

USER root
RUN mkdir /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
USER jenkins

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log"
___________________________________________________________________________________________________

# COMMANDS:-

docker build -t myjenkins .

docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master -d myjenkins

# To confirm that the Java and Jenkins options are set correctly
docker exec jenkins-master ps -ef | grep java

# Tail the log file if everything worked
docker exec jenkins-master tail -f /var/log/jenkins/jenkins.log

start:
	docker start jenkins-master
stop:
	docker stop jenkins-master
clean:	stop
	docker rm -v jenkins-master

*****************************************
JENKINS IN DOCKERFILE : DATA PERSISTENCE
*****************************************
Dockerfile :-
# /var/cache/jenkins : To store the uncompressed Jenkins war file data
___________________________________________________________________________________________________
FROM jenkins/jenkins:2.112
LABEL maintainer="mstewart@riotgames.com"

USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
USER jenkins

ENV JAVA_OPTS="-Xmx8192m"

ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"
___________________________________________________________________________________________________

# COMMANDS:-

docker volume create jenkins-data

docker volume create jenkins-log

docker volume ls
# port 50000:  This is to handle connections from JNLP based build slaves

docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --mount source=jenkins-log,target=/var/log/jenkins --mount source=jenkins-data,target=/var/jenkins_home -d myjenkins

# Post steps :-
# 1. Stop, Remove, start new container again. Verify 
# 2. Copy the data inside volume  into a  container

docker exec jenkins-master ls /var/cache/jenkins/war

docker run -d --name mylogcopy --mount source=jenkins-log,target=/var/log/jenkins debian:stretch

docker cp mylogcopy:/var/log/jenkins/jenkins.log jenkins.log



-----------------------------------------
docker network create jenkins
docker volume create jenkins-docker-certs
docker volume create jenkins-data
docker container run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind


docker container run   --name jenkins-blueocean   --rm   --detach   --network jenkins   --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client   --env DOCKER_TLS_VERIFY=1   --publish 8080:8080   --publish 50000:50000  --env JAVA_OPTS="-Xmx8192m" --env JENKINS_OPTS="--handlerCountMax=300" --volume jenkins-data:/var/jenkins_home   --volume jenkins-docker-certs:/certs/client:ro   jenkinsci/blueocean


docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword

*************************************
build:
	docker pull jenkins/jenkins
run:
	docker run -p 8080:8080 --name=jenkins-master -d --env JAVA_OPTS="-Xmx8192m" --env JENKINS_OPTS="--handlerCountMax=300" jenkins/jenkins
	#-d flag : Detached mode: Run container in the background, print new container id. Container exits when the root process used to run the container exits
	#--env JAVA_OPTS="-Xmx8192m" : Gives Jenkins 8 GB memory pool and room to handle garbage collection.
	#--env JENKINS_OPTS=" --handlerCountMax=300" Gives Jenkins base pool of handlers and a cap

start:
	docker start jenkins-master
stop:
	docker stop jenkins-master
clean:	stop
	docker rm -v jenkins-master

