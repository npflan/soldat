FROM debian:10-slim AS base
RUN apt-get -y update && \
    apt-get -y --force-yes install ca-certificates wget unzip && \
    mkdir soldat && \
    wget https://static.soldat.pl/downloads/soldatserver2.8.2_1.7.1.1.zip && \
    unzip soldatserver2.8.2_1.7.1.1.zip && \
    mv soldatserver2.8.2_1.7.1.1 soldat && \
    chmod +x soldat/soldatserver && \
    chmod -R 0777 soldat/logs && \
    chmod -R u+w soldat/logs/ && \
    chmod -R u+w soldat/anti-cheat/ && \
    chmod 666 soldat/banned*.txt
ADD ./config/ /soldat/
RUN chmod +x soldat/start.sh

FROM debian:10-slim
MAINTAINER Kristian Dahl Kærgaard <hcand.dk@gmail.com>
COPY --from=base /soldat /soldat
RUN useradd -ms /bin/bash soldat && \
    chown -R soldat:soldat /soldat
USER soldat
EXPOSE 23073
EXPOSE 23083
WORKDIR /soldat
CMD ./start.sh
