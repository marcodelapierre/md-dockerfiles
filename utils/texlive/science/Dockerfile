FROM ubuntu:18.04

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		texlive \
		texlive-bibtex-extra \
		texlive-extra-utils \
		texlive-font-utils \
		texlive-lang-english \
		texlive-pictures \
		texlive-publishers \
		texlive-science \
		vim \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /data

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 gnu && \
	echo `echo "gnu\ngnu\n" | passwd gnu` && \
	chown gnu:gnu /data
USER gnu

VOLUME ["/data"]
WORKDIR /data

CMD ["/bin/bash"]
