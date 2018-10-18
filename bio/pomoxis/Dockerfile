FROM ubuntu:16.04

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		bzip2 \
		cmake \
		gcc-4.9 \
		git \
		g++-4.9 \
		libatlas-base-dev \
		libbz2-dev \
		libffi-dev \
		libhdf5-dev \
		liblzma-dev \
		libncurses5-dev \
		libopenblas-base \
		libopenblas-dev \
		make \
		python3-all-dev \
		virtualenv \
		wget \
		zlib1g-dev \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CXX="g++-4.9" CC="gcc-4.9"

RUN mkdir /apps && \
	cd /apps && \
	git clone --recursive https://github.com/nanoporetech/pomoxis && \
	cd pomoxis && \
	make install

RUN echo "#!/bin/bash" >/usr/local/bin/init.sh && \
	echo ". /apps/pomoxis/venv/bin/activate" >>/usr/local/bin/init.sh && \
    echo "exec \"\$@\"" >>/usr/local/bin/init.sh && \
    chmod +x /usr/local/bin/init.sh && \
    ln -s /usr/local/bin/init.sh /

RUN mkdir /data

RUN useradd --create-home --shell /bin/bash --user-group --uid 1000 bio && \
    echo `echo "bio\nbio\n" | passwd bio` && \
    chown bio:bio /data
USER bio

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["init.sh"]
CMD ["/bin/bash"]
