FROM rocker/rstudio:3.5.1

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		libxml2-dev \
		zlib1g-dev \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages('shiny')" \
		-e "source('https://bioconductor.org/biocLite.R')" \
		-e "biocLite('cummeRbund')"
