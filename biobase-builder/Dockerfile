FROM ubuntu:16.04

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

# Add aarnet mirror to speed up package update
RUN perl -p -i.orig -e \
      's/archive.ubuntu.com/mirror.aarnet.edu.au\/pub\/ubuntu\/archive/' /etc/apt/sources.list \
      && sed -i '0,/# deb-src/{s/# deb-src/deb-src/}' /etc/apt/sources.list

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \
        automake        \
        autotools-dev   \
        build-essential \
        bzip2           \
        ca-certificates \
        cmake           \
        curl            \
        fuse            \
        gdb             \
        gfortran        \
        git             \
        grep            \
        pkg-config      \
	python-dev      \
        python-minimal  \
        python-pip      \
        sed             \
        wget            \
        vim             \
        zip             \
        && apt-get clean all && \
        apt-get purge && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG MINICONDA_VER="4.5.4"

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-${MINICONDA_VER}-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    chmod 777 -R /opt/conda

RUN mkdir /data /build /apps

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 --groups sudo bio && \
    echo `echo "bio\nbio\n" | passwd bio` && \
    mkdir /home/bio/bin && \
    chown bio:bio /data && \
    chown bio:bio /build && \
    chown bio:bio /apps

USER bio

ENV PATH=$PATH:/opt/conda/bin

RUN conda config --add channels conda-forge && \
    conda config --add channels r && \
    conda config --add channels bioconda && \
    conda upgrade conda && \
    conda create -n myconda

ENV PATH=/opt/conda/envs/myconda/bin:$PATH CONDA_DEFAULT_ENV=myconda CONDA_PREFIX=/opt/conda/envs/myconda

VOLUME ["/data", "/build","/apps"]

WORKDIR /data

CMD ["/bin/bash"]
