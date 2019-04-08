FROM continuumio/miniconda:4.5.11

RUN conda update -y conda

ARG VERSION="1.0.13=py27_1"
RUN conda install -c conda-forge -c bioconda -y checkm-genome=${VERSION}
RUN echo -e "cat << EOF\n/data/db_checkm\nEOF\n" | checkm data setRoot

RUN mkdir /home/none && \
    mkdir /home/none/.cache && \
    cp -p $HOME/.bashrc $HOME/.profile /home/none/ && \
    chmod -R go+w /home/none

ENV HOME="/home/none"

VOLUME /data
WORKDIR /data
