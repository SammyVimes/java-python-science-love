FROM maven:latest
MAINTAINER "Semyon Danilov <samvimes@yandex.ru>"

RUN apt-get update -yq
RUN apt-get install build-essential -y
RUN apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
RUN wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz \
    && tar -xvf Python-2.7.9.tgz

RUN cd Python-2.7.9 && ./configure && make && make install

# VOLUME /root/.m2

COPY requirements.txt requirements.txt

RUN apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev -y
RUN curl http://archive.apache.org/dist/thrift/0.9.2/thrift-0.9.2.tar.gz | tar zx
RUN cd thrift-0.9.2/ \
    && ./configure \
    && make \
    && make install

RUN python -m ensurepip
RUN apt-get install python2.7-dev -y
RUN apt-get install libblas-dev liblapack-dev gfortran -y
RUN export LC_ALL=C \
    && pip install --upgrade setuptools \
    && pip install -r requirements.txt

CMD ["/bin/bash"]
