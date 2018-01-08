# Base image
#FROM openhorizon/aarch64-tx2-cudabase:JetPack3.2RC
#FROM tensorrt3.0-cuda9.0:latest 
FROM openhorizon/aarch64-tx2-tensorrt-3.0-cuda9.0:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# Install prerequisites
RUN apt-get update && apt-get install -y curl git swig wget build-essential python python-pip python-dev
#build-essential libboost-all-dev python python-pip python-dev libboost-python-dev libboost-thread-dev
RUN pip install --no-cache-dir numpy
RUN mkdir -p /root/src

# *.deb file update
#COPY *.deb /tmp/
RUN dpkg -i /var/nv-tensorrt-repo-pipecleaner-cuda9.0-trt3.0-20171116/libnvinfer4_4.0.0-1+cuda9.0_arm64.deb
RUN dpkg -i /var/nv-tensorrt-repo-pipecleaner-cuda9.0-trt3.0-20171116/libnvinfer-dev_4.0.0-1+cuda9.0_arm64.deb

ENV PATH=$PATH:/usr/local/cuda/bin
RUN git clone https://github.com/AastaNV/ChatBot /root/src/ChatBot
WORKDIR /root/src/ChatBot
RUN wget https://raw.githubusercontent.com/numpy/numpy/master/tools/swig/numpy.i -P /root/src/ChatBot/src/
# Update Makefile with expected location of Python numpy libs
COPY Makefile /root/src/ChatBot/
RUN make

# python chatbot.py model/ID210.pickle model/ID210_649999.uff 

