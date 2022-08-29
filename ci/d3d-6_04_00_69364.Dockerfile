FROM osgeo/gdal:ubuntu-full-3.2.2

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    libssl-dev \
    bzip2 \
    libffi-dev \
    xz-utils \
    libxml2-dev \
    libboost-all-dev \
    wget \
    vim \
    python3-pip

WORKDIR /root/Software

COPY Delft3D-6_04_00_69364 /root/Software/Delft3D-6_04_00_69364
COPY torque-6.0.1 /root/Software/torque-6.0.1
COPY mpich-3.2 /root/Software/mpich-3.2

#RUN wget https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz &&\
#    tar xvf Python-3.8.9.tgz &&\
#    rm -f Python-3.8.9.tgz
COPY nefis-python-0.4.0 /root/Software/Python/nefis-python-0.4.0

RUN echo $(ls -alh /root/Software)

WORKDIR /root/Software/torque-6.0.1
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

#WORKDIR /root/Software/Python-3.8.9
#RUN ./configure --enable-optimizations &&\
#    make altinstall
#
#RUN wget https://bootstrap.pypa.io/get-pip.py &&\
#    python3.8 get-pip.py
RUN pip3 install -U pip &&\
    pip3 install bpytop setuptools scikit-build \
    Cython numpy

WORKDIR /root/Software/Python/nefis-python-0.4.0
RUN pip3.8 install ./dist/nefis-0.4.0-cp38-cp38-linux_x86_64.whl
RUN cp -rf ./lib/* /usr/local/lib/
RUN export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

WORKDIR /root
