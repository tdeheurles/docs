FROM       java:8
MAINTAINER thibault Deheurles tdeheurles@gmail.com

RUN apt-get update
RUN apt-get -y install curl

# install
ENV     ELASTIC_SEARCH_VERSION "2.2.0"
WORKDIR /tmp
RUN     curl -O https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/${ELASTIC_SEARCH_VERSION}/elasticsearch-${ELASTIC_SEARCH_VERSION}.deb
RUN     dpkg -i /tmp/elasticsearch-${ELASTIC_SEARCH_VERSION}.deb

# config
ENV     ELASTICSEARCH_HOME "/usr/share/elasticsearch"
WORKDIR ${ELASTICSEARCH_HOME}
RUN     ln -s /etc/elasticsearch ${ELASTICSEARCH_HOME}/
RUN     mv ${ELASTICSEARCH_HOME}/elasticsearch ${ELASTICSEARCH_HOME}/config
RUN     chown -R elasticsearch:elasticsearch ${ELASTICSEARCH_HOME}

# run
WORKDIR ${ELASTICSEARCH_HOME}/bin
USER    elasticsearch
CMD     ./elasticsearch
