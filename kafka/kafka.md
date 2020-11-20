# Kafka

## Main Concepts and Terminology

1. Event
1. Producers
1. Topics
1. Partitions
1. Replica Partitons
1. Brokers

## kafka APIs

1. Admin API
1. Producer API
1. Consumer API
1. Kafka Streams API : Stream processing applications and microservices
1. Kafka Connect API : Build and run reusable data import/export connectors that consume (read) or produce (write) streams of events from and to external systems and applications so they can integrate with Kafka.

## Official Documentation

- On an Amazon AMI-2 EC2 instance, Download and install Java and Kafka
- Start Zookeeper Service

```
sudo su
yum update -y
yum install java-1.8*
wget https://mirrors.estointernet.in/apache/kafka/2.6.0/kafka_2.13-2.6.0.tgz
tar -xzf kafka_2.13-2.6.0.tgz
cd kafka_2.13-2.6.0/
bin/zookeeper-server-start.sh config/zookeeper.properties
```

- On Another Terminal session, Start Kafka 
- If you get memory Error, You can adjust the JVM heap size by editing `kafka-server-start.sh`, `zookeeper-server-start.sh` and so on: `export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"` . The `-Xms` parameter specifies the minimum heap size. To get your server to at least start up, try changing it to use less memory. Given that you only have 512M, you should change the maximum heap size `(-Xmx)` too: `export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"`

```
sudo su
cd kafka_2.13-2.6.0/
bin/kafka-server-start.sh config/server.properties

```

- On Another Terminal session, Create a Topic
- Describe the topic
- Write some events into the topic

```
bin/kafka-topics.sh --create --topic first-topic --bootstrap-server localhost:9092
bin/kafka-topics.sh --describe --topic first-topic --bootstrap-server localhost:9092
bin/kafka-console-producer.sh --topic first-topic --bootstrap-server localhost:9092
> my first event 
> second event
Ctrl + C^
```

- On Another Terminal session, Read a Events from the Topic

```
$ bin/kafka-console-consumer.sh --topic first-topic --from-beginning --bootstrap-server localhost:9092

```

db.createUser( { user: "myUserAdmin", pwd:"password" , roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ] } )

