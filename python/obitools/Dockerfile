FROM python:2.7.16-slim

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get update && \
    apt-get install -y \
      gcc \
      make \
      python-dev \
      vim \
      wget \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /apps && \
    cd /apps && \
    wget https://pythonhosted.org/OBITools/_downloads/get-obitools.py && \
    python get-obitools.py 

ENV PATH="/apps/OBITools-1.2.13/export/bin:$PATH" \
    MANPATH="/apps/OBITools-1.2.13/export/share/man:$MANPATH"

RUN mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none
ENV HOME="/home/none"

VOLUME /data
WORKDIR /data

