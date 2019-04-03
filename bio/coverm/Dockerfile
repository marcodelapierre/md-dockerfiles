FROM continuumio/miniconda:4.5.11

RUN conda update -y conda

ARG COVERM_VER="0.2.0-alpha6"
ARG SAM_VER="1.9"
ARG BWA_VER="0.7.17"

RUN conda install -c conda-forge -c bioconda -y \
      bwa="$BWA_VER" \
      samtools="$SAM_VER"

RUN cd / && wget https://github.com/wwood/CoverM/releases/download/v"${COVERM_VER}"/coverm-x86_64-unknown-linux-musl-"${COVERM_VER}".tar.gz && \
    tar xzf coverm-x86_64-unknown-linux-musl-"${COVERM_VER}".tar.gz && \
    mv coverm-x86_64-unknown-linux-musl-"${COVERM_VER}"/coverm /usr/local/bin && \
    rm -r coverm-x86_64-unknown-linux-musl-"${COVERM_VER}"*

RUN mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none
ENV HOME="/home/none"

VOLUME /data
WORKDIR /data
