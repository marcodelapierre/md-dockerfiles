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
ARG CELLRANGER_WEB_TOKEN="http://cf.10xgenomics.com/releases/cell-exp/cellranger-3.1.0.tar.gz?Expires=1566932555&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9jZWxsLWV4cC9jZWxscmFuZ2VyLTMuMS4wLnRhci5neiIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTU2NjkzMjU1NX19fV19&Signature=dhUiXD~y-YCP0uWMH3oK4PsGHLuChtSqPnSHvRk9hssC5V1WRRxvZDpHx5dkoXPNgPbjmU-RXeSXdVChQ3YhVTR7T9LTFlZK9m-RuSSTiniwIhvC-mt8Xkoy66W8QuLxf98THZTGMIhj7nFtCMKkKhrkIt5mDr9a2xO5HC2wRbuXViLDW4lPORNqzpUoShc8yupjuzk~GhSrb-V~XRUNTPOXf6ofGyaPMT~qhgxlQvUU5Cc~kJIX6fQYH6gENsjxkmp3iQrAU8qz3r9sKOMZAUiCnSc0LfPKE0ov9zNhctxr7FPzlMSVY1WbeOLJIpVivL-cBdxxAtV3eXaYO~qdbw__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

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
