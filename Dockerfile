FROM ubuntu:16.04

RUN apt-get update && apt-get install -y build-essential wget tcl

WORKDIR /tmp
RUN wget http://download.redis.io/releases/redis-3.2.11.tar.gz
RUN tar xzf redis-3.2.11.tar.gz

WORKDIR /tmp/redis-3.2.11
RUN make && taskset -c 1 make test && make install

COPY redis.conf /tmp

EXPOSE 6379
ENTRYPOINT ["redis-server", "/tmp/redis.conf"]