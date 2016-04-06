{
  port: 8125,
  mgmt_port: 8126,

  graphitePort: 2003,
  graphiteHost: "127.0.0.1",
  backends: ['./backends/graphite', 'statsd-influxdb-backend'],

  debug: true,
  dumpMessages: true,

  influxdb: {
    host: '127.0.0.1',   // InfluxDB host. (default 127.0.0.1)
    port: 8086,          // InfluxDB port. (default 8086)
    version: 0.9,        // InfluxDB version. (default 0.8)
    ssl: false,          // InfluxDB is hosted over SSL. (default false)
    database: 'app',  // InfluxDB database instance. (required)
    username: 'root',    // InfluxDB database username.
    password: 'root',    // InfluxDB database password.
    flush: {
      enable: true       // Enable regular flush strategy. (default true)
    },
    proxy: {
      enable: false,       // Enable the proxy strategy. (default false)
      suffix: 'raw',       // Metric name suffix. (default 'raw')
      flushInterval: 1000  // Flush interval for the internal buffer.
                           // (default 1000)
    },
    includeStatsdMetrics: false, // Send internal statsd metrics to InfluxDB. (default false)
    includeInfluxdbMetrics: false // Send internal backend metrics to InfluxDB. (default false)
                                  // Requires includeStatsdMetrics to be enabled.
  }
}
