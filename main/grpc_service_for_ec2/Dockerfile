FROM ubuntu


RUN apt-get update -y && \
    apt-get install -y git  build-essential curl && \
    apt-get install -y python3 && \
    apt-get install -y python3-pip 

ENV HOME=/home/ws

ADD ./scripts/ $HOME/scripts/
ADD ./main     $HOME/main/

RUN pip3 install -r $HOME/scripts/python_requirements.txt

WORKDIR $HOME/main/protos

RUN make proto_server && \
    make proto_client

WORKDIR $HOME/scripts/
RUN chmod +x run_server.sh

CMD ["/bin/bash", "-c", "${HOME}/scripts/run_server.sh"]




