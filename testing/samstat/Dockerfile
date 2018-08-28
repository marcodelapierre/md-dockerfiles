### BUILD STAGE

################## BASE IMAGE ######################
FROM biocontainers/biocontainers:latest as builder

################## METADATA ######################
LABEL base_image="biocontainers:latest"
LABEL version="1"
LABEL software="SAMStat"
LABEL software.version="1.5.1"
LABEL about.summary="SAMStat displays various properties of next-generation sequencing reads stored in SAM/BAM format"
LABEL about.home="https://sourceforge.net/projects/samstat/"
LABEL about.home="https://github.com/TimoLassmann/samstat"
LABEL about.documentation="https://github.com/TimoLassmann/samstat"
LABEL about.license_file="https://github.com/TimoLassmann/samstat"
LABEL about.license_file="https://github.com/TimoLassmann/samstat/blob/master/COPYING"
LABEL about.license="GPL-3"
LABEL about.tags="Genomics"
LABEL extra.identifiers.biotools="samstat"

################## MAINTAINER ######################
MAINTAINER Marco De La Pierre <marco.delapierre@gmail.com>

RUN conda create -n myconda && \
	conda install -c conda-forge -n myconda samtools=1.9

ENV PATH=/opt/conda/envs/myconda/bin:$PATH CONDA_DEFAULT_ENV=myconda CONDA_PREFIX=/opt/conda/envs/myconda

USER root
RUN mkdir /build
WORKDIR /build

RUN wget https://sourceforge.net/projects/samstat/files/samstat-1.5.1.tar.gz && \
	tar xzf samstat-1.5.1.tar.gz && \
	cd samstat-1.5.1 && \
	./configure && \
	make clean && \
	make && \
	cp src/samstat /opt/conda/envs/myconda/bin/

USER biodocker
WORKDIR /data

CMD ["bash"]


### PRODUCTION STAGE

################## BASE IMAGE ######################
FROM ubuntu:16.04 as runner

################## METADATA ######################
LABEL base_image="biocontainers:latest"
LABEL version="1"
LABEL software="SAMStat"
LABEL software.version="1.5.1"
LABEL about.summary="SAMStat displays various properties of next-generation sequencing reads stored in SAM/BAM format"
LABEL about.home="https://sourceforge.net/projects/samstat/"
LABEL about.home="https://github.com/TimoLassmann/samstat"
LABEL about.documentation="https://github.com/TimoLassmann/samstat"
LABEL about.license_file="https://github.com/TimoLassmann/samstat"
LABEL about.license_file="https://github.com/TimoLassmann/samstat/blob/master/COPYING"
LABEL about.license="GPL-3"
LABEL about.tags="Genomics"
LABEL extra.identifiers.biotools="samstat"

################## MAINTAINER ######################
MAINTAINER Marco De La Pierre <marco.delapierre@gmail.com>

COPY --from=builder /opt/conda/envs/myconda /usr/local/

RUN mkdir /data
WORKDIR /data

CMD ["samstat"]

