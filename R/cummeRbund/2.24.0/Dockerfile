FROM marcodelapierre/bioconductor-base

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN Rscript -e "install.packages('shiny')" \
		-e "BiocManager::install('cummeRbund')"
