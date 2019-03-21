### BUILD STAGE

FROM marcodelapierre/biobase-builder as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG VERSION="1.0.13=py27_1"
RUN conda install -n myconda checkm-genome=${VERSION}


### PRODUCTION STAGE

FROM marcodelapierre/biobase-runner as runner

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

COPY --from=builder /opt/conda/envs/myconda /usr/local/
