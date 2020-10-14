# Promotheues

**Language**

- sample = timestamp + value (float)
- Time series = List of samplees ordered by time (timestamp(x),value(y))
- TSDB : DB storing timeseries
- Quantiles(0.9) and Percentiles(90th)
- Time series  Representaion : *metric_name*{label1="value1", label2="value2"....} . Eg. temperature{city="Los Angeles", state="California"}
- Job(api-server) and Instance labels
- Instant Vector : List of samples containing same time stamp. (Different labels and values). Eg. Temperature@now in different cities
- Range Vector : Subset of samples from a time series in a given time range. Temperature at a place at now, now -10s, now - 20s etc

**Architecture**

- Prometheus scrapes Targets from /metrics endpoints exposed in the application
- PromQL : Language to qury timeseries. avg(temperature{state="California"})
- Service Discovery
- Push Gateway : For short running Jobs which can later be scraped
- Exporters : Import stats, Covert to Prometheus stats and opens http server for prometheus to scrap.

**Installation**

```
# -c (continue automatically if download gets interrupted), -O(standard output to), tar -x(extract), z(gzip)

wget -c https://github.com/prometheus/prometheus/releases/download/v2.21.0/prometheus-2.21.0.darwin-amd64.tar.gz -O - |tar xz

cd prometheus-2.21.0.darwin-amd64/

./prometheus --config.file=prometheus.yml 

# visit http://localhost:9090
```
Prometheus on Docker

```
#Detached mode(Container running even after you exit using ^C) 
docker run -d --name prometheues -p 9090:9090 prom/prometheus

mkdir /tmp/prometheus

cd /tmp/prometheus

#Make use of prometheus.yml file in your local system as a config file to run prometheus inside container
docker run -d --name prometheus -p 9090:9090 -v /tmp/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```



**Metric Types**

1. Counter : Can only go up. Eg. Total number of requests a handler recieves, Total number of errors
1. Guage Metric : Can go both up and Down. Eg. Temperature in a city, Resource usage (CPU, memory, disk), Number of Elements in a queue
1. Histogram : Calculate time durations and can be used to calculate quantiles. Mainly used to measure request latencies
1. Summary : Legacy of Histogram. Averaging quantiles doesnt make sense. Not used much

## Go client integration Demo : Creating a server publishing some metrics on "/metrics" endpoint

*github.com/prometheus/client_golang v1.5.1*: This package is official Library for exposing prometeus metrics in Go.

**go.mod** file

```
module goexample

require github.com/prometheus/client_golang v1.5.1

go 1.14
```

**main.go v1.0** file (expose "/metrics" endpoint which exposes prometheus metrics )

```
package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/prometheus/common/log"
)

var criticismCounter = promauto.NewCounter(prometheus.CounterOpts{
	Name: "aaa_criticism",
	Help: "Total number of times Jackie crit Daniel",
})

var liesCounter = promauto.NewCounterVec(prometheus.CounterOpts{
	Name: "aaa_lies",
	Help: "Total number of lies by politicians",
}, []string{"name"})

var temperatureGauge = promauto.NewGauge(prometheus.GaugeOpts{
	Name: "aaa_temperature",
	Help: "Temperature in celsius",
})

var latencyHistogram = promauto.NewHistogram(prometheus.HistogramOpts{
	Name:    "aaa_latency",
	Help:    "latency",
	Buckets: prometheus.DefBuckets,
})

var latencySummary = promauto.NewSummary(prometheus.SummaryOpts{
	Name: "aaa_latency2",
})

func main() {
	criticismCounter.Inc()
	liesCounter.With(map[string]string{"name": "p1"}).Inc()
	liesCounter.With(map[string]string{"name": "p2"}).Inc()
	liesCounter.With(map[string]string{"name": "p2"}).Inc()
	liesCounter.With(map[string]string{"name": "p3"}).Inc()
	temperatureGauge.Set(24.4)
	latencyHistogram.Observe(0.5)
	latencySummary.Observe(0.2)
	fmt.Println("running")
	http.Handle("/metrics", promhttp.Handler())
	log.Fatal(http.ListenAndServe(":1234", nil))
}

```

**main.go v1.1** file (expose "/metrics" endpoint which exposes prometheus metrics )

```
package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/prometheus/common/log"
)

var criticismCounter = promauto.NewCounter(prometheus.CounterOpts{
	Name: "aaa_criticism",
	Help: "Total number of times Jackie crit Daniel",
})

var liesCounter = promauto.NewCounterVec(prometheus.CounterOpts{
	Name: "aaa_lies",
	Help: "Total number of lies by politicians",
}, []string{"name"})

var temperatureGauge = promauto.NewGauge(prometheus.GaugeOpts{
	Name: "aaa_temperature",
	Help: "Temperature in celsius",
})

var latencyHistogram = promauto.NewHistogram(prometheus.HistogramOpts{
	Name:    "aaa_latency",
	Help:    "latency",
	Buckets: prometheus.DefBuckets,
})

var latencySummary = promauto.NewSummary(prometheus.SummaryOpts{
	Name: "aaa_latency2",
})

func main() {
	measure(criticismCounter.Inc)
	measure(liesCounter.With(map[string]string{"name": "p1"}).Inc)
	measure(liesCounter.With(map[string]string{"name": "p2"}).Inc)
	measure(liesCounter.With(map[string]string{"name": "p2"}).Inc)
	measure(func() {
		temperatureGauge.Set(rand.Float64() * 30)
	})
	measure(func() {
		latencyHistogram.Observe(rand.Float64() / 1.5)
	})
	measure(func() {
		latencySummary.Observe(rand.Float64() / 1.5)
	})
	fmt.Println("running")
	http.Handle("/metrics", promhttp.Handler())
	log.Fatal(http.ListenAndServe(":1234", nil))
}

func measure(f func()) {
	go func() {
		for {
			time.Sleep(3 * time.Second)
			f()
		}
	}()
}

```
**Prometheus Config**

global:
- scrape_interval
- scrape_timeout
- evaluation_interval
- external_labels
- query_logfile

scrape_configs:
- job_name
    - scrape_interval
    - scrape_timeout
    - metric path
- honor_label (Whether to keep conflicting scrabed labels. Default: False)
- relabel_configs (Used to choose meta Labels we want to keep (pre-scrape))
- metric_relabel_configs (Used to choose meta Labels we want to keep (post-scrape))
- sample_limit (Limits per scrape)
- static_configs: 
    - targets: ['localhost:9090','localhost:9191']
    - labels: myports: over9000
- Authentication:
    - bearer_token_file: /some/path
    - basic_auth: useername and password_file
    - tls_config : ca_file, cert_file and key_file
- Service Discovery
    - dns_sd_configs
    - kubernetes_sd_configs
    - ec2_sd_configs

Alerting
- alert_relable_configs
- alertmanagers
    - scheme: https
        - static_configs:
            - targets:
    - We can also use service discovery to find AlertManagrs

## PromQL Basics

**Outputs Instant Vector**

http_request_total

http_request_total{job="MyService",instance="1.2.3.4:1234"}

**Outputs Range Vector**

http_request_total{job="MyService",instance="1.2.3.4:1234"}[5m]

- Duration types: s , m , h , d , w , y
- Binary Aritmatic Operators: + , - , * , / , % (modulo) , ^ (exponentiation)
- Convert bytes to bits: *node_network_transmit_bytes_total \* 8*
- One to One Matching on same label set : M1/M2
	- If label don't match exactly: **Metric1**/on(label)**Metric2** (or) **Metric1**/ignoring(extraLabel)**Metric2**
- One to many Matching on same label set : **Metric1**/ignoring(label,extraLabel) group_left **Metric2**
- Binary Operators on label sets: and,or, unless(opposite to and)
- Aggregation Operators: max(M1), min(M1), sum(M1), count(M1), avg(M1), quantile(0.5,M1), count_values("value",M1), topk(k,M1), bottomkk,(M1),sum(M) by (label),

**PromQL Functions**

- abs(M1), M1 is instant-vector
- absent(M1), absent returns 1 if given vector doesn't exist, M1 is instant-vector
- absent_over_time(M2), absent_over_time returns 1 if given vector doesn't exist, M2 is range-vector
- ceil(M1), Rounds off instant vector M1 value to near greater value
- floor(M1),Rounds off instant vector M1 value to near lesser value
- clamp_max (M1 IV,max_scalar) Return sample value with upper limit
- clamp_min (M1 IV,max_scalar) Return sample value with lower limit
- changes (M2 RV): number of times a vector has changed in given time
- delta (M2[timePeriod]): Difference between first and last sample values
- idelta (M2[timePeriod]): Difference between last 2 sample values
- increase (M2[timePeriod]): Difference between first and last sample values like delta , can handle counter resets
- rate(M2[timePeriod]) : increase(M2)/(number of seconds in time Range)
- irate(M2[timePeriod]) : idelta(M2)/(Time delta in last 2 sample values)
- label_join: label_join(M{a="1",b="2"}, "three", "+","a", "b") ==> M{a="1",b="2",three=1+2}
- label_replace
- resets(M2[timePeriod]) 
- sort (M1)
- sort_desc(M1)
- timestamp(M1)
- scalar(M1)
- vector(s scalar)
- Date and Time Functions (Use time value)
- Aggregation over Time
- histogram_quantile(q float, M1)

**PromQL Examples**

- Instance free memory in MiB
	- (instance_memory_limit_bytes - instance_memory_usage_bytes) / 1024/1024
- Average requests duration over last 5 minutes
	- increase(http_request_duration_seconds_sum[5m]) / increase(http_request_duration_seconds_count[5m])
- 95th percentile latency for service running on multiple nodes
	- histogram_quantile(0.95,sum(rate(my_service_http_request_duration_seconds_bucket[5m]))by(le))
- Average number of Go threads in last 5 minutes
	- avg_over_time(go_threads{job="A"}[5m])
- Number of running instances
	- sum(up{job="A"})
- Comparision operators

## Alert Manager

**Installation**

```
wget -c https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanager-0.21.0.darwin-amd64.tar.gz -O - |tar xz

cd alertmanager-0.21.0.darwin-amd64/

./alertmanager --config.file=alertmanager.yml 

# visit http://localhost:9093
```

**Alert Manager Responsibility**

- Grouping and deduplicating alerts
- Routing alert to correct team
- Snooze alert

**Alert Manager Config**

global:
- Slack /  Email / PagerDuty etc global config (api_URLs,  hosts, smtp_auth_username, passwords)

receivers:
- List of recievers (name of team, email, service keys etc)

routes:
- How do we route alert. (Default routing, Send critical alerts to certain team by paging , group waits, intervals, repeat intervals etc )

**Adding Alert**

1. Add a new yaml file with alert rules.
1. Specify the yaml file in Prometheus configuration.

**Alert via Slack Demo**

alert-rules.yaml
```
groups:
  - name: dev
    rules:
      - alert: HighLatency
        expr: histogram_quantile(0.9, aaa_latency_bucket) > 0.08
        labels:
          foo: bar
        annotations:
          summary: High Latency!
```

alertmanager.yaml
```
global:
  resolve_timeout: 5m
  slack_api_url: https://hooks.slack.com/services/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

route:
  group_by: ['alertname', 'job']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 1h
  receiver: 'web.hook'
  routes:
    - match:
        foo: 'bar'
      receiver: 'slack'
receivers:
- name: 'web.hook'
  webhook_configs:
  - url: 'http://127.0.0.1:5001/'
- name: 'slack'
  slack_configs:
    - channel: '#alerts1'
      icon_emoji: ':hear_no_evil:'
      fields:
        - title: '{{ .GroupLabels.job }}/{{ .GroupLabels.alertname }}'
          value: '{{ .CommonAnnotations.summary }}'
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']

```

prometheus.yaml
```
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
        - localhost:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "alert-rules1.yaml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']

  - job_name: 'myexample'

    static_configs:
    - targets: ['localhost:1234']

```

## Prometheus - Grafana Integration

```
#Run Grafana

docker run -d --name=grafana -p 3001:3000 -v grafana_config:/etc/grafana -v grafana_data:/var/lib/grafana -v grafana_logs:/var/log/grafana grafana/grafana

# visit http://localhost:3000
```

- Grafana Dashboard --> Datasources --> Prometheus --> Host URL : host.docker.internal:9090
- Requests Rate(Graph) : Metric Query : rate(prometheus_http_requests_total[5m])
- Apdex Score (Single Stat) : Metric Query : (sum(rate(prometheus_http_request_duration_seconds_bucket{le="0.2"}[5m])) + sum(rate(prometheus_http_request_duration_seconds_bucket{le="0.4"}[5m])) / 2 ) / sum(rate(prometheus_http_request_duration_seconds_bucket[5m])) 
- 90th Percentile Latency (Gauge) : Metric Query : histogram_quantile(0.9,sum(rate(prometheus_http_request_duration_seconds_bucket[5m])) by (le))

## Node Exporter

```
wget https://github.com/prometheus/node_ex...


wget -c https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.darwin-amd64.tar.gz -O - |tar xz

tar xvfz node_exporter-1.0.0-rc.0.linux-amd64.tar.gz

./node_exporter

sudo firewall-cmd --permanent --zone=public --add-port=9100/tcp

sudo firewall-cmd --reload
```

### Deploy prometheus in Kubernetes

CRD: Custom  Resource Definitions
kind: Prometheus
Helm: K8S package manager

```
brew install helm
helm repo list
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo list
helm install stable-prom stable/prometheus-operator
```

# On EC2

Install Prometheus
```
# Update the dependencies using yum update
# Download the source using curl, untar it and rename the extracted folder to prometheus-files.
# Create a Prometheus user, required directories, and make prometheus user as the owner of those directories.
# Copy prometheus and promtool binary from prometheus-files folder to /usr/local/bin and change the ownership to prometheus user.
# Move the consoles, console_libraries directories and prometheus config file from prometheus-files to /etc/prometheus folder and change the ownership to prometheus user.
# Setup Prometheus Service File
# Reload the systemd service to register the prometheus service and start the prometheus service and check if the service is running successfully


sudo yum update -y
sudo wget -c https://github.com/prometheus/prometheus/releases/download/v2.21.0/prometheus-2.21.0.linux-amd64.tar.gz  -O - |tar xz
sudo mv prometheus-2.21.0.linux-amd64 prometheus-files
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
sudo cd prometheus-files/
sudo cp prometheus-files/prometheus /usr/local/bin/
sudo cp prometheus-files/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r prometheus-files/consoles /etc/prometheus
sudo cp -r prometheus-files/console_libraries /etc/prometheus
sudo cp prometheus-files/prometheus.yml /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
sudo vi /etc/systemd/system/prometheus.service
```
Copy the following content to the file.
```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

Reload the systemd service to register the prometheus service and start the prometheus service and check if the service is running successfully
```
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus
```

Install Node Exporter
```
# Update the dependencies using yum update
# Download the source using curl, untar it and move the node_exporter binary to /usr/local/bin
# Create a node_exporter user to run the node exporter service.
# Copy prometheus and promtool binary from prometheus-files folder to /usr/local/bin and change the ownership to prometheus user.
# Create a node_exporter service.


sudo yum update -y
sudo wget -c https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz  -O - |tar xz
sudo mv node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin
sudo useradd -rs /bin/false node_exporter
sudo vi /etc/systemd/system/node_exporter.service
```

Copy the following content to the file.
```
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

Reload the systemd service to register the node_exporter service and start the node_exporter service and check if the service is running successfully
```
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter
```

