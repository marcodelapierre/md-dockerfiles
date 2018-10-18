### BUILD STAGE

FROM marcodelapierre/biobase-builder as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN conda install -c conda-forge -n myconda bcftools=1.9


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
