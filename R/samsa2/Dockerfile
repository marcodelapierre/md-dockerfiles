FROM rocker/tidyverse:3.5.1

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get update && \
	apt-get install -y \
		vim \
	&& apt-get clean all && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir /apps && \
	cd /apps && \
	git clone --branch 2.1.0 https://github.com/transcript/samsa2.git && \
	mkdir /apps/samsa2/full_databases && \
	chmod +x /apps/samsa2/bash_scripts/master_script.sh && \
	bash /apps/samsa2/setup_and_test/package_installation.bash

ENV PATH="/apps/samsa2/bash_scripts:$PATH"
