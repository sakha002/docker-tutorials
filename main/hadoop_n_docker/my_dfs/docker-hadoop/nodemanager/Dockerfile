FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

RUN apt-get update -y 
RUN apt-get install -y git wget build-essential

RUN apt-get update && apt-get -y install python3


EXPOSE 8042

CMD ["/run.sh"]
