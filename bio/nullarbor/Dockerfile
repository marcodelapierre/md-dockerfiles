FROM continuumio/miniconda:4.5.11
  
MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN conda update -y conda

RUN conda install -c conda-forge -c bioconda -c defaults nullarbor

RUN mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none
ENV HOME="/home/none"

VOLUME /data
WORKDIR /data

