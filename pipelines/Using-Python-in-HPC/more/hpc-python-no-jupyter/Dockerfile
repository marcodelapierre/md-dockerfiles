FROM marcodelapierre/mpi-base-py3:latest
  
MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get update && \
    apt-get install -y \
      cython3 \
      python3-pip \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && update-alternatives --install /usr/bin/cython cython /usr/bin/cython3 10 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10

RUN pip install \
      h5py \
      matplotlib \
      netCDF4 \
      numba \
      numpy \
      pandas \
      scipy \
      sklearn \
      tables

RUN mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none
ENV HOME="/home/none"

VOLUME /data
WORKDIR /data

CMD ["/usr/bin/python"]
