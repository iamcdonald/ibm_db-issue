FROM ibmcom/db2express-c:10.5.0.5-3.10.0

ENV DB2INST1_PASSWORD cptdevpw
ENV LICENSE accept

ADD ./container /container

RUN /container/setup.sh

CMD ["/container/start.sh"]
