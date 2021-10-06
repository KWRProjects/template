FROM centos:centos7

RUN yum groupinstall -y "Development Tools"
RUN yum install -y openssl-devel bzip2-devel libffi-devel xz-devel \
	libxml2-devel boost-devel \
	wget

WORKDIR /root/Software

RUN wget https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz &&\
	tar xvf Python-3.8.9.tgz &&\
	rm -f Python-3.8.9.tgz

RUN echo $(ls -alh /root/Software)

WORKDIR /root/Software/Python-3.8.9
RUN ./configure --enable-optimizations &&\
	make altinstall
	
RUN wget https://bootstrap.pypa.io/get-pip.py &&\
	python3.8 get-pip.py &&\
	pip3 install bpytop 

WORKDIR /root
