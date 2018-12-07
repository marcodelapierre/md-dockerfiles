FROM rocker/tidyverse:3.5.1

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		libbz2-dev \
		liblzma-dev \
		vim \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages('BiocManager')" \
		-e "BiocManager::install(ask=FALSE)"
