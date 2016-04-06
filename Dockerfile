FROM vandries/node
MAINTAINER Valentin Andriès <valentin.andries@music-story.com>

# Default versions
ENV STATSD_VERSION 0.7.2
ENV INFLUXDB_VERSION 0.9.6-1
ENV GRAFANA_VERSION 2.6.0

# Database Defaults
ENV INFLUXDB_GRAFANA_DB app
ENV INFLUXDB_GRAFANA_USER datasource
ENV INFLUXDB_GRAFANA_PW datasource

RUN npm install -g statsd@0.7.2
RUN npm install -g statsd-influxdb-backend
ADD statsd/config.js /opt/statsd/config.js

RUN yum -y install wget
RUN wget http://s3.amazonaws.com/influxdb/influxdb-${INFLUXDB_VERSION}.x86_64.rpm
RUN yum -y localinstall influxdb-${INFLUXDB_VERSION}.x86_64.rpm
RUN rm influxdb-${INFLUXDB_VERSION}.x86_64.rpm

ADD influxdb/run.sh  /usr/local/bin/run_influxdb
RUN chmod 0755 /usr/local/bin/run_influxdb
ADD influxdb/setup.sh /tmp/setup_influxdb.sh
RUN chmod 0755 /tmp/setup_influxdb.sh
RUN /tmp/setup_influxdb.sh

ADD grafana/grafana.repo /etc/yum.repos.d/grafana.repo
RUN yum -y install grafana

RUN yum -y install python-setuptools
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

# Statsd
EXPOSE 8125

# Grafana UI
EXPOSE 3000

# InfluxDB
EXPOSE 8083
EXPOSE 8086

CMD ["/usr/bin/supervisord"]
