FROM ubuntu:18.04

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		less \
		vim \
		xauth \
		gnuplot \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GNUTERM=x11
RUN gnuplot_ver=$( gnuplot -V | cut -d ' ' -f 2 ) && \
    echo "\nset colors classic" >>/usr/share/gnuplot/gnuplot/${gnuplot_ver}/gnuplotrc

VOLUME /data
WORKDIR /data

CMD ["/bin/bash"]
