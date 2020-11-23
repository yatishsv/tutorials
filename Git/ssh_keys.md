# Git connection for Private Repos

```
sudo su
yum install git -y
ssh-keygen -t ed25519 -C "yatish.sv@pocketfm.in"
eval "$(ssh-agent -s)"
#copy to Github account
cat /root/.ssh/id_ed25519.pub
ssh -T git@github.com
git clone git@github.com:Pocket-Fm/Backend-CD-Scripts.git
```
