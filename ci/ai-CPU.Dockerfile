FROM python:3.8
LABEL maintainer quanpan302@hotmail.com

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Europe/Amsterdam"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim \
    tzdata \
    keyboard-configuration \
    ca-certificates \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libhdf5-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk2.0-dev \
    libprotobuf-dev \
    libsnappy-dev \
    protobuf-compiler \
    python-dev \
    python-numpy \
    python-pip \
    python-opencv \
    python-setuptools \
    python-scipy && \
    rm -rf /var/lib/apt/lists/*

RUN file="$(find /usr -iname "*hdf5.h*")" && echo $file

WORKDIR /root/Software
RUN pip install easydict
RUN pip install cython

RUN git clone --recursive https://github.com/phtruongan/py-faster-rcnn.git

RUN cd py-faster-rcnn/lib && make

COPY ai.caffe.Makefile.config py-faster-rcnn/caffe-fast-rcnn/Makefile.config
#    INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial && \
#    LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu/hdf5/serial && \
RUN cd py-faster-rcnn/caffe-fast-rcnn && \
    make && \
    make pycaffe
RUN cd py-faster-rcnn && ./data/scripts/fetch_faster_rcnn_models.sh

WORKDIR /root