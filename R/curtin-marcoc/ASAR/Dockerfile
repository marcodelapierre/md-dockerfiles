FROM rocker/rstudio:3.5.1
# it is assumed this container will be run INTERACTIVELY, either with bash or Rstudio

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		curl \
		git \
		libcairo2-dev \
		libcurl4-openssl-dev \
		libgdal-dev \
		libgeos-dev \
		libglu1-mesa-dev \
		libssl-dev \
		libudunits2-dev \
		libxml2-dev \
		libxt-dev \
		pandoc \
		texlive \
		xzdec \
		vim \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chmod go+w /var/lib/texmf/web2c && \
	su rstudio -c "tlmgr init-usertree" && \
	su rstudio -c "tlmgr --usermode install framed titling" && \
	tlmgr --usertree /usr/local/tex init-usertree && \
	tlmgr --usermode --usertree /usr/local/tex install framed titling 
ENV TEXMFHOME="/usr/local/tex"

RUN Rscript -e "install.packages('shiny', dependencies = TRUE)" \
		-e "install.packages('devtools', dependencies = TRUE)" \
		-e "install.packages('ggplot2', dependencies = TRUE)" \
		-e "install.packages('gplots', dependencies = TRUE)" \
		-e "install.packages('RColorBrewer', dependencies = TRUE)" \
		-e "install.packages('data.table', dependencies = TRUE)" \
		-e "install.packages('plyr', dependencies = TRUE)" \
		-e "install.packages('stringr', dependencies = TRUE)" \
		-e "install.packages('shinythemes', dependencies = TRUE)" \
		-e "install.packages('matrixStats', dependencies = TRUE)" \
		-e "install.packages('png', dependencies = TRUE)" \
		-e "install.packages('rhandsontable', dependencies = TRUE)" \
		-e "source('https://bioconductor.org/biocLite.R')" \
		-e "biocLite('pathview', suppressUpdates = TRUE)" \
		-e "biocLite('biomformat', suppressUpdates = TRUE)" \
		-e "biocLite('KEGGREST', suppressUpdates = TRUE)" \
		-e "biocLite('limma', suppressUpdates = TRUE)" \
		-e "library('devtools')" \
		-e "install_github('Alanocallaghan/d3heatmap')" \
		-e "install.packages('pander', dependencies = TRUE)" \
		-e "install.packages('knitr', dependencies = TRUE)" \
		-e "install.packages('RJSONIO', dependencies = TRUE)" \
		-e "install.packages('RCurl', dependencies = TRUE)" \
		-e "install.packages('xtable', dependencies = TRUE)" \
		-e "install.packages('taxize', dependencies = TRUE)"

RUN cd /home/rstudio && \
	git clone https://github.com/Askarbek-orakov/ASAR.git && \
	sed -i 's/srun //g' ASAR/bash/*.* && \
	sed -i 's/sbatch /bash /g' ASAR/bash/*.* && \
	chown -R rstudio:rstudio /home/rstudio/ASAR && \
	chmod -R g+w /home/rstudio/ASAR 
