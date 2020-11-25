```
docker pull docker.bintray.io/jfrog/artifactory-jcr:latest
docker run --name artifactory -d -p 8081:8081 -p 8082:8082 docker.bintray.io/jfrog/artifactory-jcr:latest
```
vim /etc/docker/daemon.json
```
{
  "insecure-registries" : ["18.139.3.224:8082"]
}
docker login http://18.139.3.224:8082/
```

```
docker pull hello-world
docker tag hello-world 18.139.3.224:8082/pocketfm/hello-world
docker push 18.139.3.224:8082/pocketfm/hello-world
docker pull 18.139.3.224:8082/pocketfm/hello-world
```



Link: 
https://www.jfrog.com/confluence/display/JCR6X/Installing+with+Docker