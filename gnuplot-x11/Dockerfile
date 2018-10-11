FROM ubuntu:18.04

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \  
        vim \
        gnuplot \
        xauth \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /data

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 gnu && \
    echo `echo "gnu\ngnu\n" | passwd gnu` && \
    chown gnu:gnu /data

RUN echo "#!/bin/bash -i" >/usr/local/bin/init.sh && \
	echo "gnuplot" >>/usr/local/bin/init.sh && \
	chmod +x /usr/local/bin/init.sh && \
	ln -s /usr/local/bin/init.sh /

USER gnu

RUN echo "export GNUTERM=x11" >~/.bashrc

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["init.sh"]
