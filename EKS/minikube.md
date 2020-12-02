```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
sudo mv /usr/local/bin/minikube /usr/bin/
minikube version
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo mv /usr/local/bin/kubectl /usr/bin/
kubectl version --client
yum install docker -y
yum install conntrack -y
yum install iptables-services -y
systemctl enable iptables
systemctl start iptables
sudo minikube start --vm-driver=none
yum install docker -y
sudo minikube start --vm-driver=none
minikube status
history
   ```