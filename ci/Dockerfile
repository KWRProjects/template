FROM centos:centos7

WORKDIR /root/Software

COPY Delft3D-6_04_00_69364 /root/Software/Delft3D-6_04_00_69364
COPY torque-6.0.1 /root/Software/torque-6.0.1
COPY mpich-3.2 /root/Software/mpich-3.2
RUN echo $(ls -alh /root/Software)

RUN yum groupinstall -y "Development Tools"

WORKDIR /root/Software/torque-6.0.1
RUN yum install -y openssl-devel libxml2-devel boost-devel
RUN ./autogen.sh &&\
	./configure --prefix=/opt/torque6 2>&1 | tee c.txt &&\
	make 2>&1 | tee m.txt &&\
	make install 2>&1 | tee mi.txt &&\
	ll /opt/torque6/bin &&\
	ll /opt/torque6/lib &&\
	PATH=/opt/torque6/bin:$PATH ; export PATH &&\
	LD_LIBRARY_PATH=/opt/torque6/lib:$LD_LIBRARY_PATH ; export LD_LIBRARY_PATH

WORKDIR /root/Software/mpich-3.2
RUN ./configure --prefix=/opt/mpich2 2>&1 | tee c.txt &&\
	make 2>&1 | tee m.txt &&\
	make install 2>&1 | tee mi.txt &&\
	ll /opt/mpich2/bin &&\
	PATH=/opt/mpich2/bin:$PATH ; export PATH

WORKDIR /root
