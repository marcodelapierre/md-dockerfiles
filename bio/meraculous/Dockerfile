### BUILD STAGE

FROM marcodelapierre/biobase-builder as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG MERA_VER="2.2.6"
RUN conda install -c bioconda -n myconda meraculous=${MERA_VER}


### PRODUCTION STAGE

FROM marcodelapierre/biobase-runner as runner

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

COPY --from=builder /opt/conda/envs/myconda /usr/local/

USER root
RUN cd /usr/local/lib && \
	if [ -s libwebp.so.7 ] ; then ln -s libwebp.so.7 libwebp.so.6 ; fi
USER bio

ENV PERL5LIB="/usr/local/lib:$PERL5LIB"
ENV MERACULOUS_ROOT="/usr/local"
