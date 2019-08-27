FROM centos:7

LABEL maintainer="marco.delapierre@pawsey.org.au"

# Install package dependencies
RUN yum -y update \
    && yum -y install \
         file \
         git \
         sssd-client \
         which \
         wget \
         unzip \
    && yum clean all

# Install bcl2fastq
ARG BCL_ZIP_VERSION="2-20-0"
ARG BCL_RPM_VERSION="2.20.0.422"

RUN mkdir -p /tmp/bcl2fastq-build \
    && cd /tmp/bcl2fastq-build \
    && wget http://sapac.support.illumina.com/content/dam/illumina-support/documents/downloads/software/bcl2fastq/bcl2fastq2-v${BCL_ZIP_VERSION}-linux-x86-64.zip \
    && unzip bcl2fastq2-v${BCL_ZIP_VERSION}-linux-x86-64.zip \
    && yum -y --nogpgcheck localinstall bcl2fastq2-v${BCL_RPM_VERSION}-Linux-x86_64.rpm \
    && rm -f bcl2fastq2-v${BCL_ZIP_VERSION}-linux.zip \
    && cd / \
    && rm -rf /tmp/bcl2fastq-build

# Install Cellranger
ARG CELLRANGER_VERSION="3.1.0"
ARG CELLRANGER_WEB_TOKEN="http://cf.10xgenomics.com/releases/cell-exp/cellranger-${CELLRANGER_VERSION}.tar.gz?Expires=1542833383&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9jZWxsLWV4cC9jZWxscmFuZ2VyLTMuMC4wLnRhci5neiIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTU0MjgzMzM4M319fV19&Signature=K5rfRDuevGMGMW3BjNW6FrINbZ-LfUdA5M4eZSkX9Uy4zeJGujHiDj9q7BZMe~NcwwU6LiSHsYE0GGKBav4Nl1c8vKTF2yXr8ibdYnwYy95Yimm1IzQDtCRemie8ssd62pO2qqmk5TFCrjOwR1Gsn1w4Iw8DOz3d9NUjs39PRmeDyGPVODzTIeAYgUkm1lzYkAsRPtZaNriaZs0ttr2HqBoNYwfDQClfnsMBaCy4JML8PAXSEABq-FFf~-Ryiwv0omonRQ4Z6XU4LRdcOT~LFdMUBzsRkt5SRBChGmlLv5lDq~Zk5rFIvcJS8vRfBTvEL7SsdybF~E0dYBzeOxhjFg__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

RUN mkdir -p /tmp/cellranger-build \
    && cd /tmp/cellranger-build \
    && wget -O cellranger-${CELLRANGER_VERSION}.tar.gz ${CELLRANGER_WEB_TOKEN} \
    && mkdir /apps \
    && mv cellranger-${CELLRANGER_VERSION}.tar.gz /apps/ \
    && cd /apps \
    && tar -xzvf cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -f cellranger-${CELLRANGER_VERSION}.tar.gz \
    && rm -rf /tmp/cellranger-build

WORKDIR /data
# Add Cellranger to path
ENV PATH /apps/cellranger-${CELLRANGER_VERSION}:$PATH
