FROM combined-registry.sbx.zone/ibmcom/db2express-c:10.5.0.5-3.10.0
MAINTAINER Tom Groves <tom.groves1@wipro.com>

ARG data_location

ENV DB2INST1_PASSWORD cptdevpw
ENV LICENSE accept

ADD ./container /container

ADD $data_location /data

RUN /container/setup.sh /data

CMD ["/container/start.sh"]
