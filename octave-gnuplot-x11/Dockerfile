FROM ubuntu:18.04

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \  
        vim \
        gnuplot \
        octave \
        xauth \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /data

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 gnu && \
    echo `echo "gnu\ngnu\n" | passwd gnu` && \
    chown gnu:gnu /data

USER gnu

RUN echo "export GNUTERM=x11" >~/.bashrc && \
	echo "setenv (\"GNUTERM\", \"X11\")" >~/.octaverc

VOLUME ["/data"]

WORKDIR /data

CMD ["/bin/bash"]

