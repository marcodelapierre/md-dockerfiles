FROM trinityrnaseq/trinityrnaseq:2.8.6

ARG GNUPAR_VER="20191022"

RUN mkdir /install_temp && cd /install_temp && \
    wget https://ftp.gnu.org/gnu/parallel/parallel-"${GNUPAR_VER}".tar.bz2 && \
    tar xjf parallel-"${GNUPAR_VER}".tar.bz2 && \
    cd parallel-"${GNUPAR_VER}" && \
    ./configure && make && make install && \
    cd / && rm -fr /install_temp

