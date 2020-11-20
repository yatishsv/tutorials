# Migration from Mongo to documentDB

```
mkdir mongo1_backup
chmod 777 -R mongo1_backup
mongodump --host 10.0.2.226 --out mongo1_backup/
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install pymongo
git clone https://github.com/awslabs/amazon-documentdb-tools.git
yum install wget -y
wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
python amazon-documentdb-tools/index-tool/migrationtools/documentdb_index_tool.py --show-issues --dir mongo1_backup --username myUserAdmin --password password
mongorestore --drop --host docdb-2020-11-11-00-30-45.ceeijshotffn.ap-southeast-1.docdb.amazonaws.com:27017 --ssl --sslCAFile rds-combined-ca-bundle.pem --username master --password password mongo1_backup/
```