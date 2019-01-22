FROM continuumio/miniconda:4.5.11

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        autoconf \
        g++ \
        gcc \
        gfortran \
        libatlas-base-dev \
        libglib2.0-dev \
        make \
        pkg-config \
        unzip \
        vim && \
    conda update -y conda \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN conda install -c conda-forge -c bioconda -y cython pysam scipy bx-python bwa

RUN mkdir /build && \
    mkdir /apps

WORKDIR /build
RUN wget http://last.cbrc.jp/last-716.zip && \
    unzip -q last-716.zip && \
    cd last-716 && \
    make CXXFLAGS=-O3 && \
    make install
RUN wget http://gatb-tools.gforge.inria.fr/versions/bin/minia-2.0.3-Linux.tar.gz && \
    tar -xzvf minia-2.0.3-Linux.tar.gz && \
    mv minia-2.0.3-Linux/bin/* /usr/local/bin/
RUN git clone https://github.com/adamewing/align.git && \
    cd align && \
    python setup.py install
RUN git clone https://github.com/adamewing/exonerate.git && \
    cd exonerate && \
    git checkout v2.4.0 && \
    autoreconf -i && \
    ./configure && \
    make && \
    make check && \
    make install

WORKDIR /apps
RUN git clone https://github.com/adamewing/tebreak.git
ENV TB="/apps/tebreak" \
    PATH="/apps/tebreak/tebreak:/apps/tebreak/scripts:/apps/tebreak/scripts/misc:/apps/tebreak/lib:$PATH"

RUN rm -rf /build && \
    mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none
ENV HOME="/home/none"
WORKDIR /data
