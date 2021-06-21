# % Last Change: Mon Jun 21 01:05:13 PM 2021 CDT
# Base Image
FROM debian:10.9

# File Author / Maintainer
MAINTAINER Tiandao Li <litd99@gmail.com>

ENV PATH /opt/conda/bin:$PATH

# Installation
RUN apt-get update --fix-missing && \
    apt-get install -y \
    python3 \
    python3-pip \
    rsync \
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

RUN echo "from SigProfilerMatrixGenerator import install as genInstall" > /opt/hg38.py && \
    echo "genInstall.install('GRCh38')" >> /opt/hg38.py && \
    /usr/bin/python3 /opt/hg38.py && \
    rm /opt/hg38.py

# set timezone, debian and ubuntu
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
	echo "America/Chicago" > /etc/timezone

CMD [ "/bin/bash" ]

