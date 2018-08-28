FROM ubuntu:16.04

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN mkdir /data /apps

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 --groups sudo bio && \
    echo `echo "bio\nbio\n" | passwd bio` && \
    chown bio:bio /data && \
    chown bio:bio /apps

USER bio

VOLUME ["/data", "/apps"]

WORKDIR /data

CMD ["/bin/bash"]
