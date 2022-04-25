FROM debian:stretch

RUN apt-get update -y

RUN apt-get install -y \
  lua5.1 \
  liblua5.1-0-dev \
  luarocks \
  git \
  libssl1.0-dev \
  make

RUN git config --global url.https://github.com/.insteadOf git://github.com/

WORKDIR /home/plugin

ADD Makefile .
ADD rockspec.template .
RUN make setup

RUN chmod -R a+rw /home/plugin