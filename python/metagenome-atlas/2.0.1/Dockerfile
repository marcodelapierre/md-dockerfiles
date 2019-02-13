FROM continuumio/miniconda3:4.5.11

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        vim && \
    conda update -y conda \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG atlas_version="2.0.1"
RUN conda install -y -c bioconda -c conda-forge metagenome-atlas="$atlas_version"

RUN mkdir /databases && \
    chmod go+w /databases

RUN mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none
ENV HOME="/home/none"
VOLUME /data
WORKDIR /data
