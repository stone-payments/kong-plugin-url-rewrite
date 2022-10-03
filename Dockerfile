FROM ubuntu:22.04

RUN apt-get update -y

RUN apt update -y && apt install -y lua5.1 liblua5.1-dev build-essential wget git zip unzip
RUN git config --global url.https://github.com/.insteadOf git://github.com/
RUN wget https://download.konghq.com/gateway-3.x-ubuntu-bionic/pool/all/k/kong/kong_3.0.0_amd64.deb &&\
  apt install -y ./kong_3.0.0_amd64.deb

WORKDIR /home/plugin

COPY Makefile .
COPY rockspec.template .
RUN make setup

RUN chmod -R a+rw /home/plugin
