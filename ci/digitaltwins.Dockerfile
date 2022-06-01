FROM centos:centos7

# Development Tools
WORKDIR /root/Software

RUN yum groupinstall -y "Development Tools"
RUN yum install -y vim-enhanced \
    openssl-devel bzip2-devel \
	libffi-devel xz-devel \
	libxml2-devel boost-devel \
	wget cmake
RUN debuginfo-install -y gcc

# GDAL
WORKDIR /root/Software/GDAL

## lib
RUN yum install -y libzstd-devel sqlite-devel libwebp-devel hdf5-devel

## proj, /usr/local
RUN wget --no-check-certificate https://download.osgeo.org/proj/proj-6.1.1.tar.gz
RUN tar xf proj-6.1.1.tar.gz &&\
	rm -f proj-6.1.1.tar.gz
RUN cd proj-6.1.1 &&\
    ./configure &&\
    make install

## libkml, /usr/local
RUN wget --no-check-certificate http://s3.amazonaws.com/etc-data.koordinates.com/gdal-travisci/install-libkml-r864-64bit.tar.gz &&\
    tar xzf install-libkml-r864-64bit.tar.gz &&\
	rm -f install-libkml-r864-64bit.tar.gz
RUN cd install-libkml &&\
    cp -r include/* /usr/local/include &&\
    cp -r lib/* /usr/local/lib &&\
    ldconfig

## gdal, /usr/local
RUN wget --no-check-certificate http://download.osgeo.org/gdal/3.0.2/gdal-3.0.2.tar.gz &&\
    tar xzf gdal-3.0.2.tar.gz &&\
	rm -f gdal-3.0.2.tar.gz
RUN cd gdal-3.0.2 &&\
    ./configure --with-libkml --with-proj &&\
    make install

# Python
WORKDIR /root/Software/Python

## python
RUN wget --no-check-certificate https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz &&\
	tar xvf Python-3.8.9.tgz &&\
	rm -f Python-3.8.9.tgz
RUN cd Python-3.8.9 &&\
    ./configure --enable-optimizations &&\
	make altinstall

## pip
RUN wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
RUN python3.8 get-pip.py &&\
    pip3 install bpytop scikit-build

# Python lib
COPY ./ci/Python-lib /root/Software/Python/Python-lib
RUN pip3 install -r /root/Software/Python/Python-lib/requirements.txt

WORKDIR /Docker

# FROM ubuntu:16.04
# RUN apt-get update && apt-get install -y \
#   vim \
#   autoconf \
#   libtool \
#   flex \
#   g++ \
#   gfortran \
#   libstdc++6 \
#   byacc \
#   libexpat1-dev \
#   uuid-dev \
#   ruby \
#   build-essential \
#   wget \
#   pkg-config \
#   gedit \
#   libcurl4-openssl-dev
