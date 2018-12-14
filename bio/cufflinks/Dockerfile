### BUILD STAGE

FROM marcodelapierre/biobase3-builder as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

ARG CUFF_VER="2.2.1"
RUN conda install -c conda-forge -n myconda cufflinks=${CUFF_VER}


### PRODUCTION STAGE

FROM marcodelapierre/biobase-runner as runner

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

COPY --from=builder /opt/conda/envs/myconda /usr/local/
