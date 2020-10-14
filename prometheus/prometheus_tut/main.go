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
