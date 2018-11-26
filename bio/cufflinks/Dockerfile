### BUILD STAGE

FROM marcodelapierre/biobase3-builder as builder

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN conda install -c conda-forge -n myconda cufflinks=2.2.1


### PRODUCTION STAGE

FROM marcodelapierre/biobase-runner as runner

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

COPY --from=builder /opt/conda/envs/myconda /usr/local/
