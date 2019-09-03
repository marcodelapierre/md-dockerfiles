FROM ubuntu:18.04 as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG LC_ALL="C"
ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="${LC_ALL}"
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    wget \
    zlib1g-dev \
  && apt-get clean all && \
  apt-get purge && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG BWA_VER="0.7.17"
RUN mkdir /install && cd /install && \
  git clone https://github.com/lh3/bwa.git && \
  cd bwa && git checkout v"$BWA_VER" && \
  make && cp bwa /usr/local/bin/ && \
  cd / && rm -r /install

ARG JUICER_TOOLS_VER="1.13.02"
RUN mkdir /apps && cd /apps && \
  git clone https://github.com/aidenlab/juicer.git && \
  cd juicer && \
  wget https://s3.amazonaws.com/hicfiles.tc4ga.com/public/juicer/juicer_tools_"${JUICER_TOOLS_VER}".jar && \
  ln -s /apps/juicer/juicer_tools_*.jar /apps/juicer/CPU/common/juicer_tools.jar && \
  ln -s /apps/juicer/juicer_tools_*.jar /apps/juicer/AWS/scripts/juicer_tools.jar && \
  ln -s /apps/juicer/juicer_tools_*.jar /apps/juicer/LSF/scripts/juicer_tools.jar && \
  ln -s /apps/juicer/juicer_tools_*.jar /apps/juicer/PBS/scripts/juicer_tools.jar && \
  ln -s /apps/juicer/juicer_tools_*.jar /apps/juicer/SLURM/scripts/juicer_tools.jar && \
  ln -s /apps/juicer/juicer_tools_*.jar /apps/juicer/UGER/scripts/juicer_tools.jar && \
  mkdir references && mkdir restriction_sites && \
  chmod -R go+rwX .


FROM  ubuntu:18.04 as runner

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG LC_ALL="C"
ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="${LC_ALL}"
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre \
    perl \
  && apt-get clean all && \
  apt-get purge && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /usr/local/bin/bwa /usr/local/bin/
COPY --from=builder /apps /apps

WORKDIR /data
CMD ["/bin/bash"]
