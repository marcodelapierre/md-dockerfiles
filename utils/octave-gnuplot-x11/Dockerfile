FROM ubuntu:18.04

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		vim \
		xauth \
		gnuplot \
		octave \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /home/none/.cache && \
	cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
	chmod -R go+w /home/none
ENV HOME="/home/none"

ENV GNUTERM=x11
RUN echo "set colors classic" >/home/none/.gnuplot && \
	echo "setenv (\"GNUTERM\", \"X11\")" >/home/none/.octaverc

VOLUME /data
WORKDIR /data

CMD ["/bin/bash"]
