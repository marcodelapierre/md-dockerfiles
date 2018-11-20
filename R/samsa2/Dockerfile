FROM rocker/rstudio:3.5.1

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		default-jre \
		libxml2-dev \
		vim \
		zlib1g-dev \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages('shiny')" \
		-e "install.packages('reshape')" \
		-e "install.packages('pheatmap')"

RUN mkdir /apps && \
	cd /apps && \
	git clone --branch 2.1.0 https://github.com/transcript/samsa2.git && \
	mkdir /apps/samsa2/full_databases && \
	chmod +x /apps/samsa2/bash_scripts/master_script.sh && \
	bash /apps/samsa2/setup_and_test/package_installation.bash && \
	chmod -R a+rwX /apps/samsa2 && \
	sed -i -e 's/^INPUT_DIR=.*/INPUT_DIR=\$(pwd)/g' \
	-e 's/^OUT_DIR=.*/OUT_DIR=\$(pwd)/g' \
	/apps/samsa2/bash_scripts/master_script.sh

ENV PATH="/apps/samsa2/bash_scripts:$PATH"
