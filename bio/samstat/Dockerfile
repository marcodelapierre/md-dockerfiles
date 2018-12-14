### BUILD STAGE

FROM marcodelapierre/biobase-builder as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG TOOLS_VER="1.9"
ARG STAT_VER="1.5.1"

RUN conda install -c conda-forge -n myconda samtools=${TOOLS_VER}

RUN wget https://sourceforge.net/projects/samstat/files/samstat-${STAT_VER}.tar.gz && \
	tar xzf samstat-${STAT_VER}.tar.gz && \
	cd samstat-${STAT_VER} && \
	./configure && \
	make clean && \
	make && \
	cp src/samstat /opt/conda/envs/myconda/bin/


### PRODUCTION STAGE

FROM marcodelapierre/biobase-runner as runner

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

USER root

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \
        perl \
        perl-modules-5.22 \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER bio

COPY --from=builder /opt/conda/envs/myconda /usr/local/
