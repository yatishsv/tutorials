```
    1  sudo yum update -y
    2  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    3  unzip awscliv2.zip
    4  sudo ./aws/install
    5  exit
    6  aws --version
    7  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    8  sudo mv /tmp/eksctl /usr/local/bin
    9  eksctl version
   10  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
   11  curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl.sha256
   12  openssl sha1 -sha256 kubectl
   13  chmod +x ./kubectl
   14  sudo mv ./kubectl /usr/local/bin
   15  echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile
   16  kubectl version --short --client
   17  history
```