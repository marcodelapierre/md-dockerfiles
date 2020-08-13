FROM rocker/r-ver:3.6.3

LABEL maintainer="<marco.delapierre@pawsey.org.au>"

ENV DEBIAN_FRONTEND="noninteractive"
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8"

RUN apt-get update && \
    apt-get install -y \
      libcurl4-openssl-dev \
      libgdal-dev \
      libgit2-dev \
      libxml2-dev \
      libssl-dev \
      libudunits2-dev \
      zlib1g-dev \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN R -e "install.packages('spdep')" \
      -e "install.packages('devtools', repo = 'http://cran.rstudio.com', dep = TRUE)" \
      -e "devtools::install_github('wpeterman/ResistanceGA', build_vignettes = TRUE)"

