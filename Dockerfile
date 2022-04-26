FROM ubuntu:latest

RUN apt update -y

RUN apt install -y \
  lua5.1 \
  liblua5.1-0-dev \
  luarocks \
  git \
  libssl-dev \
  make

RUN wget https://download.konghq.com/gateway-0.x-ubuntu-xenial/pool/all/k/kong-community-edition/kong-community-edition_0.13.1_all.deb \
  && apt install -y ./kong-community-edition_0.13.1_all.deb

RUN git config --global url.https://github.com/.insteadOf git://github.com/

WORKDIR /home/plugin

ADD Makefile .
ADD rockspec.template .
RUN make setup

RUN chmod -R a+rw /home/plugin