# % Last Change: Wed Jun 23 04:36:33 PM 2021 CDT
# Base Image
FROM debian:10.9

# File Author / Maintainer
MAINTAINER Tiandao Li <litd99@gmail.com>

ENV PATH /opt/conda/bin:$PATH

# Installation
RUN echo "deb http://deb.debian.org/debian buster contrib" >> /etc/apt/sources.list && \
    apt-get update --fix-missing && \
    apt-get install -y \
    fontconfig \
    python3 \
    python3-pip \
    rsync \
    ttf-mscorefonts-installer \
    wget && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/dpkg.log /var/tmp/*

# install SigProfiler tools
RUN pip3 install -U --no-cache-dir \
    SigProfilerPlotting \
    SigProfilerMatrixGenerator \
    SigProfilerExtractor \
    SigProfilerSimulator \
    SigProfilerTopography \
    SigProfilerHotSpots

RUN echo "from SigProfilerMatrixGenerator import install as genInstall" > /opt/ref.py && \
    echo "genInstall.install('GRCh37')" >> /opt/ref.py && \
    echo "genInstall.install('GRCh38')" >> /opt/ref.py && \
    /usr/bin/python3 /opt/ref.py && \
    rm /opt/ref.py

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	echo "America/Chicago" > /etc/timezone

CMD [ "/bin/bash" ]

