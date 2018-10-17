FROM ubuntu:18.04

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		vim \
		xauth \
		gnuplot \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "#!/bin/bash" >/usr/local/bin/init.sh && \
	echo "export GNUTERM=x11" >>/usr/local/bin/init.sh && \
	echo "exec \"\$@\"" >>/usr/local/bin/init.sh && \
	chmod +x /usr/local/bin/init.sh && \
	ln -s /usr/local/bin/init.sh /

RUN mkdir /data

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 gnu && \
	echo `echo "gnu\ngnu\n" | passwd gnu` && \
	chown gnu:gnu /data
USER gnu

RUN echo "set colors classic" >~/.gnuplot

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["init.sh"]
CMD ["/bin/bash"]
