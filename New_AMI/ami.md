```
sudo su
yum update -y
yum update httpd -y
yum install git httpd vim -y
```
```
  948  yum install -y https://s3.ap-southeast-1.amazonaws.com/amazon-ssm-ap-southeast-1/latest/linux_amd64/amazon-ssm-agent.rpm
  949  systemctl enable amazon-ssm-agent
  950  systemctl start amazon-ssm-agent
```
scp
```

    1  yum update -y
    2  yum update httpd -y
    3  yum install git httpd vim -y
    4  ll
    5  python
    6  mkdir centos63
    7  ll
    8  cd centos63/
    9  ll
   10  pwd
   11  cd ..
   12  ll
   13  chown centos:centos centos63 
   14  ll
   15  ll
   16  cd centos63/
   17  ll
   18  rm -rf *
   19  ll
   20  rm -rf *
   21  ll
   22  cd
   23  exit
   24  pwd
   25  cd /etc/httpd
   26  ll
   27  cd /home/centos/centos63
   28  ll
   29  mv * /home/centos/
   30  ll
   31  cd ..
   32  ll
   33  cd centos63/
   34  ll
   35  ll
   36  cd httpd/
   37  ll
   38  rm -rf *
   39  ll
   40  ll
   41  cd /etc/httpd/
   42  ll
   43  ll
   44  rm -rf conf conf.d conf.modules.d/
   45  ll
   46  pwd
   47  exit
   48  cd centos63/
   49  cd httpd
   50  ll
   51  mv * /etc/httpd/
   52  cd /etc/httpd/
   53  ll
   54  cd /var/
   55  ll
   56  cd www/
   57  ll
   58  cd /home/centos/
   59  ll
   60  cd centos63/
   61  ll
   62  ll
   63  cd /etc/
   64  ll
   65  ll | wc =l
   66  ll | wc -l
   67  sudo su
   68  sudo su
   69  sudo su
   70  yum install epel-release
   71  yum update
   72  yum install redis-server@3.2.12
   73  yum install redis-server-3.2.12
   74  yum install redis-server@v=3.2.12
   75  yum install redis-server v=3.2.12
   76  yum install redis@3.2.12
   77  yum install redis-3.2.12
   78  systemctl start redis
   79  systemctl enable redis
   80  systemctl status redis
   81  redis-server --version
   82  cd /etc
   83  ll
   84  cat redis.conf 
   85  ll |grep redis
   86  ll |grep memc
   87  mem
   88  yum install memcached
   89  yum install mysql@5.7
   90  yum install mysql-5.7
   91  yum install mysql-server@5.7
   92  yum install mysql-server-5.7
   93  cd
   94  cd /var/www
   95  cd radioly/
   96  ll
   97  source api_evn/bin/activate
   98  cd radioly_client_api/
   99  ls
  100  pip install -r requirements.txt
  101  ls -a
  102  cd ..
  103  ls
  104  ls -a
  105  cd radioly_client_api/
  106  cd radioly_api
  107  ls
  108  cd ..
  109  python --version
  110  exit
  111  yum install python3
  112  cd /var/www/radioly/
  113  ll
  114  source api_evn/bin/activate
  115  cd radioly_client_api/
  116  ls
  117  pip install -r requirements.txt
  118  exit
  119  pip3 -V  
  120  python3 -m pip --version
  121  python -m pip install --upgrade pip
  122   yum install epel-release
  123  sudo yum install python-pip
  124  pip --version
  125  cd /var/www/radioly/
  126  source api_evn/bin/activate
  127  cd /var/www/radioly/radioly_client_api/
  128  pip install -r requirements.txt
  129  exit
  130  yum install python3-devel
  131  yum install python-devel
  132  yum install mysql-server@5.7
  133  yum install mysql-server-5.7
  134  yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
  135  yum -y install mysql-community-server
  136  systemctl start mysqld
  137  systemctl enable mysqld
  138  systemctl is-enabled mysqld
  139  cd /var/www/radioly
  140  source api_evn/bin/activate
  141  cd radioly_client_api/
  142  pip install -r requirements.txt
  143  exit
  144  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  145  python3 get-pip.py --force-reinstall
  146  cd radioly_client_api/
  147  cd /var/www/radioly
  148  source api_evn/bin/activate
  149  cd radioly_client_api/
  150  pip install -r requirements.txt
  151  yum install mysql-server
  152  history
  ```


  ```
  922  vim radio_ly_test_ec_2_key_pair.pem
  923  ll
  924  chmod 400 radio_ly_test_ec_2_key_pair.pem 
  925  ll
  926  scp -i radio_ly_test_ec_2_key_pair.pem GeoLite2-Country.mmdb centos@52.77.247.26:/home/centos/centos63/
  927  cd /etc/httpd/
  928  ll
  929  mkdir centos63
  930  ll
  931  cd centos63/
  932  pwd
  933  cd ..
  934  cd
  935  exit
  936  ll
  937  cp -avr * /etc/httpd/centos63/
  938  cd /etc/httpd/centos63
  939  ll
  940  scp -i radio_ly_test_ec_2_key_pair.pem download_pocketfm.aac centos@52.77.247.26:/home/centos/centos63/
  941  cd
  942  exit
  943  scp -i radio_ly_test_ec_2_key_pair.pem GeoLite2-Country.mmdb centos@52.77.247.26:/home/centos/centos63/
  944  scp -i radio_ly_test_ec_2_key_pair.pem * centos@52.77.247.26:/home/centos/centos63/
  945  ll
  946  wc -l
  947  scp -i -r radio_ly_test_ec_2_key_pair.pem * centos@52.77.247.26:/home/centos/centos63/
  948  scp -ir radio_ly_test_ec_2_key_pair.pem * centos@52.77.247.26:/home/centos/centos63/
  949  scp
  950  scp -i radio_ly_test_ec_2_key_pair.pem * centos@52.77.247.26:/home/centos/centos63/
  951  ll
  952  ll|grep drwxr
  953  scp -r radio_ly_test_ec_2_key_pair.pem filebeat-7.1.1-linux-x86_64 centos@52.77.247.26:/home/centos/centos63/
  954  scp -r radio_ly_test_ec_2_key_pair.pem libmaxminddb-1.3.2 centos@52.77.247.26:/home/centos/centos63/
  955  man scp
  956  scp -i radio_ly_test_ec_2_key_pair.pem -r filebeat-7.1.1-linux-x86_64 centos@52.77.247.26:/home/centos/centos63/
  957  scp -i radio_ly_test_ec_2_key_pair.pem -r libmaxminddb-1.3.2 centos@52.77.247.26:/home/centos/centos63/
  958  ll
  959  scp -i radio_ly_test_ec_2_key_pair.pem -r node_exporter-1.0.1.linux-amd64 centos@52.77.247.26:/home/centos/centos63/
  960  scp -i radio_ly_test_ec_2_key_pair.pem -r pocketfm_static_files centos@52.77.247.26:/home/centos/centos63/
  961  scp -i radio_ly_test_ec_2_key_pair.pem -r /etc/httpd/ centos@52.77.247.26:/home/centos/centos63/
  962  cd /etc/httpd/
  963  ll
  964  cd
  965  exit
  966  ll
  967  scp -i radio_ly_test_ec_2_key_pair.pem -r /etc/httpd/conf centos@52.77.247.26:/home/centos/centos63/
  968  scp -i radio_ly_test_ec_2_key_pair.pem -r /etc/httpd/conf.d centos@52.77.247.26:/home/centos/centos63/
  scp -i radio_ly_test_ec_2_key_pair.pem -r /etc/httpd/conf centos@52.77.247.26:/home/centos/centos63/httpd
  scp -i radio_ly_test_ec_2_key_pair.pem -r /etc/httpd/conf.d centos@52.77.247.26:/home/centos/centos63/httpd
  971  scp -i radio_ly_test_ec_2_key_pair.pem -r /etc/h centos@52.77.247.26:/home/centos/centos63/
  972  cd /var/www/radioly/radioly_client_api/radioly_api
  973  ll
  974  cd ..
  975  ll
  976  cd ..
  977  ll
  978  pwd
  979  cd ..
  980  ll
  981  ll
  982  cd ..
  983  ll
  984  cd www/
  985  ll
  986  cd pocketfm_data/
  987  ll
  988  cd ..
  989  scp -i radio_ly_test_ec_2_key_pair.pem -r pocketfm_data centos@52.77.247.26:/home/centos/centos63/
  990  pwd
  991  ll
  992  cd /home/centos/
  993  scp -i radio_ly_test_ec_2_key_pair.pem -r /var/www/pocketfm_data centos@52.77.247.26:/home/centos/centos63/
  994  scp -i radio_ly_test_ec_2_key_pair.pem -r /var/www/radioly centos@52.77.247.26:/home/centos/centos63/
  995  ll
  996  cd /etc/
  997  ll
  998  ll | wc -l
  999  systemctl list
 1000  systemctl
 1001  history

  ```

  ```
      1  yum update -y
    2  yum update httpd -y
    3  yum install git httpd vim -y
    4  ll
    5  python
    6  mkdir centos63
    7  ll
    8  cd centos63/
    9  ll
   10  pwd
   11  cd ..
   12  ll
   13  chown centos:centos centos63 
   14  ll
   15  ll
   16  cd centos63/
   17  ll
   18  rm -rf *
   19  ll
   20  rm -rf *
   21  ll
   22  cd
   23  exit
   24  pwd
   25  cd /etc/httpd
   26  ll
   27  cd /home/centos/centos63
   28  ll
   29  mv * /home/centos/
   30  ll
   31  cd ..
   32  ll
   33  cd centos63/
   34  ll
   35  ll
   36  cd httpd/
   37  ll
   38  rm -rf *
   39  ll
   40  ll
   41  cd /etc/httpd/
   42  ll
   43  ll
   44  rm -rf conf conf.d conf.modules.d/
   45  ll
   46  pwd
   47  exit
   48  cd centos63/
   49  cd httpd
   50  ll
   51  mv * /etc/httpd/
   52  cd /etc/httpd/
   53  ll
   54  cd /var/
   55  ll
   56  cd www/
   57  ll
   58  cd /home/centos/
   59  ll
   60  cd centos63/
   61  ll
   62  ll
   63  cd /etc/
   64  ll
   65  ll | wc =l
   66  ll | wc -l
   67  sudo su
   68  sudo su
   69  sudo su
yum install epel-release
yum update
yum install redis-server@3.2.12
yum install redis-server-3.2.12
yum install redis-server@v=3.2.12
yum install redis-server v=3.2.12
yum install redis@3.2.12
yum install redis-3.2.12
systemctl start redis
systemctl enable redis
systemctl status redis
redis-server --version
cd /etc
ll
cat redis.conf 
ll |grep redis
ll |grep memc
mem
yum install memcached
yum install mysql@5.7
yum install mysql-5.7
yum install mysql-server@5.7
yum install mysql-server-5.7
cd
cd /var/www
cd radioly/
ll
source api_evn/bin/activate
cd radioly_client_api/
ls
pip install -r requirements.txt
ls -a
cd ..
ls
ls -a
cd radioly_client_api/
cd radioly_api
ls
cd ..
python --version
exit
yum install python3
cd /var/www/radioly/
ll
source api_evn/bin/activate
cd radioly_client_api/
ls
pip install -r requirements.txt
exit
pip3 -V  
python3 -m pip --version
python -m pip install --upgrade pip
 yum install epel-release
sudo yum install python-pip
pip --version
cd /var/www/radioly/
source api_evn/bin/activate
cd /var/www/radioly/radioly_client_api/
pip install -r requirements.txt
exit
yum install python3-devel
yum install python-devel
yum install mysql-server@5.7
yum install mysql-server-5.7
yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
yum -y install mysql-community-server
systemctl start mysqld
systemctl enable mysqld
systemctl is-enabled mysqld
cd /var/www/radioly
source api_evn/bin/activate
cd radioly_client_api/
pip install -r requirements.txt
exit
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --force-reinstall
cd radioly_client_api/
cd /var/www/radioly
source api_evn/bin/activate
cd radioly_client_api/
pip install -r requirements.txt
yum install mysql-server
history
exit
history
yum -y remove  mysql-community-server
 yum install epel-release yum-utils
yum -y install mysql-community-server
yum repolist all | grep mysql
sudo yum install mysql-community-server
sudo service mysqld start
sudo yum --disablerepo=\* --enablerepo='mysql*-community*' list available
cd /var/www/radioly
source api_evn/bin/activate
cd radioly_client_api/
pip install -r requirements.txt
exit
yum install libmysqlclient-dev
yum list |grep mysql
yum -y remove  mysql-community-server
yum list |grep mysql
yum -y install  mysql-community-server
yum install MySQL-python
cd /var/www/radioly
source api_evn/bin/activate
cd radioly_client_api/
pip install -r requirements.txt
yum install mariadb
exit
sudo yum --disablerepo=\* --enablerepo='mysql*-community*' list available
yum install mysql-community-devel.x86_64 
cd /var/www/radioly
source api_evn/bin/activate
cd radioly_client_api/
pip install -r requirements.txt
exit
yum install -y gcc
yum install -y mysql-python
cd /var/www/radioly
source api_evn/bin/activate
cd radioly_client_api/
pip install -r requirements.txt
exit
  193  history
```


```
Successfully built billiard coreschema django-uuidfield dogslow itypes MarkupSafe mysqlclient newrelic openapi-codec pycrypto pyfcm PyYAML simplejson tornado
Installing collected packages: vine, amqp, colorama, docutils, jmespath, urllib3, six, python-dateutil, botocore, pyasn1, rsa, s3transfer, PyYAML, awscli, billiard, boto, boto3, pytz, kombu, celery, certifi, chardet, MarkupSafe, Jinja2, coreschema, idna, requests, uritemplate, itypes, coreapi, Django, prometheus-client, django-prometheus, simplejson, openapi-codec, djangorestframework, django-rest-swagger, django-uuidfield, dogslow, elasticsearch, requests-toolbelt, pyfcm, fcm-django, kafka-python, mysqlclient, newrelic, numpy, Pillow, pycrypto, pydub, pymemcache, pymongo, redis, requests-aws4auth, SpeechRecognition, whitenoise, tornado, sentry-sdk
  WARNING: The scripts pyrsa-decrypt, pyrsa-decrypt-bigfile, pyrsa-encrypt, pyrsa-encrypt-bigfile, pyrsa-keygen, pyrsa-priv2pub, pyrsa-sign and pyrsa-verify are installed in '/usr/local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script celery is installed in '/usr/local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script chardetect is installed in '/usr/local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script django-admin is installed in '/usr/local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script newrelic-admin is installed in '/usr/local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The scripts f2py, f2py3 and f2py3.6 are installed in '/usr/local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed Django-2.1.1 Jinja2-2.10 MarkupSafe-1.0 Pillow-5.3.0 PyYAML-3.13 SpeechRecognition-3.8.1 amqp-2.3.2 awscli-1.16.28 billiard-3.5.0.4 boto-2.49.0 boto3-1.9.0 botocore-1.12.18 celery-4.2.1 certifi-2018.8.24 chardet-3.0.4 colorama-0.3.9 coreapi-2.3.3 coreschema-0.0.4 django-prometheus-2.1.0 django-rest-swagger-2.2.0 django-uuidfield-0.5.0 djangorestframework-3.8.2 docutils-0.14 dogslow-1.2 elasticsearch-6.3.1 fcm-django-0.2.19 idna-2.7 itypes-1.1.0 jmespath-0.9.3 kafka-python-1.4.3 kombu-4.2.1 mysqlclient-1.3.13 newrelic-4.6.0.106 numpy-1.16.1 openapi-codec-1.3.2 prometheus-client-0.9.0 pyasn1-0.4.4 pycrypto-2.6.1 pydub-0.23.0 pyfcm-1.4.5 pymemcache-1.4.4 pymongo-3.7.2 python-dateutil-2.7.3 pytz-2018.5 redis-2.10.6 requests-2.19.1 requests-aws4auth-0.9 requests-toolbelt-0.8.0 rsa-3.4.2 s3transfer-0.1.13 sentry-sdk-0.19.1 simplejson-3.16.0 six-1.11.0 tornado-5.1.1 uritemplate-3.0.0 urllib3-1.23 vine-1.1.4 whitenoise-4.1.2
```

```
    1  mkdir centos63
    2  ll
    3  chown centos:centos centos63/
    4  cd centos63/
    5  ll
    6  mv * /home/centos/
    7  ll
    8  cd ..
    9  yum update -y
   10  yum update httpd -y
   11  yum install git httpd vim -y
   12  cd centos63/
   13  ll
   14  cd ..
   15  ll
   16  cd centos63/
   17  ll
   18  mv * /var/www/
   19  ll
   20  cd
   21  cd /etc/httpd/
   22  ll
   23  cd conf
   24  ll
   25  vim httpd.conf 
   26  vim magic 
   27  cd ..
   28  cd conf.d/
   29  ll
   30  vim autoindex.conf 
   31  vim django_https.conf
   32  vim django_https1
   33  vim django.conf
   34  ll
   35  vim ssl.conf
   36  vim userdir.conf 
   37  vim welcome.conf 
   38  cd ..
   39  cd conf.modules.d/
   40  ll
   41  cat 00-proxy.conf 
   42  ll
   43  vim 00-ssl.conf
   44  cat 00-systemd.conf 
   45  cd ..
   46  ls
   47  cd logs/
   48  ll
   49  cd
   50  cd /home/centos/
   51  ll
   52  cd ce
   53  cd centos63/
   54  ll
   55  cd ..
   56  yum install epel-release
   57  yum update
   58  yum install redis-3.2.12 -y
   59  systemctl start redis
   60  systemctl enable redis
   61  systemctl status redis
   62  yum install memcached
   63  systemctl status memcached
   64  yum install python3
   65  yum install python-pip
   66  pip --version
   67  yum install python3-devel
   68  yum install python-devel
   69  yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
   70  yum -y install mysql-community-server
   71  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
   72  python3 get-pip.py --force-reinstall
   73  yum install epel-release yum-utils
   74  yum install mysql-community-devel.x86_64
   75  yum install -y gcc
   76  yum install -y mysql-python
   77  cd /var/www/radioly
   78  ll
   79  cd radioly_client_api/
   80  ll
   81  cd radioly_api
   82  ll
   83  cd ..
   84  cd ..
   85  ll
   86  ls -a
   87  rm -rf radioly_client_api/
   88  ssh-keygen -t ed25519 -C "yatish.sv@pocketfm.in"
   89  eval "$(ssh-agent -s)"
   90  cat /root/.ssh/id_ed25519.pub
   91  ssh-keygen
   92  cat /root/.ssh/id_rsa.pub
   93  eval $(ssh-agent) 
   94  ssh-add /root/.ssh/id_rsa
   95  ssh -T git@bitbucket.org
   96  ls
   97  git clone git@bitbucket.org:radioly/radioly_client_api.git
   98  ls
   99  cd radioly_client_api/
  100  ls
  101  cd radioly_api
  102  ls
  103  cd ..
  104  cd ..
  105  ll
  106  yum install mariadb
  107  source api_evn/bin/activate
  108  cd radioly_client_api/
  109  pip install -r requirements.txt
  110  history

```


