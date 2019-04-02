FROM ubuntu:17.10

LABEL maintainer="brian.skjerven@pawsey.org.au"

# Add aarnet mirror to speed up package update
RUN perl -p -i.orig -e \
      's/archive.ubuntu.com/mirror.aarnet.edu.au\/pub\/ubuntu\/archive/' /etc/apt/sources.list \
      && sed -i '0,/# deb-src/{s/# deb-src/deb-src/}' /etc/apt/sources.list

# Install package dependencies
RUN apt-get update \
      && apt-get install -y \
         build-essential \
         gdb \
         gfortran \
         python3-minimal \
         python3-dev \
         wget \
      && apt-get clean all \
      && rm -r /var/lib/apt/lists/* \
      && update-alternatives --install /usr/bin/python python /usr/bin/python3 10


### Build MPICH ###

ARG MPICH_VERSION="3.1.4"
ARG MPICH_CONFIGURE_OPTIONS="--enable-fast=all,O3 --prefix=/usr"
ARG MPICH_MAKE_OPTIONS="-j4"

WORKDIR /tmp/mpich-build

RUN wget http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
      && tar xvzf mpich-${MPICH_VERSION}.tar.gz \
      && cd mpich-${MPICH_VERSION}  \
      && ./configure ${MPICH_CONFIGURE_OPTIONS} \
      && make ${MPICH_MAKE_OPTIONS} \
      && make install \
      && ldconfig

# Test MPICH
WORKDIR /tmp/mpich-test
COPY mpich-test .
RUN sh test.sh


### Build MPI4PY ###

ARG MPI4PY_VERSION="3.0.0"

WORKDIR /tmp/mpi4py-build

RUN wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-3.0.0.tar.gz \
      && tar xzvf mpi4py-${MPI4PY_VERSION}.tar.gz \
      && cd mpi4py-${MPI4PY_VERSION} \
      && python setup.py build \
      && python setup.py install \
      && rm -r /tmp/mpi4py-build


### Build OSU Benchmarks ###

ARG OSU_BENCH_VERSION="5.4.2"
ARG OSU_BENCH_CONFIGURE_OPTIONS="--prefix=/usr/local CC=mpicc CXX=mpicxx CFLAGS=-O3"
ARG OSU_BENCH_MAKE_OPTIONS="-j4"

WORKDIR /tmp/osu-benchmark-build

RUN wget http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-${OSU_BENCH_VERSION}.tar.gz \
      && tar xzvf osu-micro-benchmarks-${OSU_BENCH_VERSION}.tar.gz \
      && cd osu-micro-benchmarks-${OSU_BENCH_VERSION} \
      && ./configure ${OSU_BENCH_CONFIGURE_OPTIONS} \
      && make ${OSU_BENCH_MAKE_OPTIONS} \
      && make install

WORKDIR /
RUN rm -rf /tmp/*

CMD ["/bin/bash"]
