FROM centos:7

LABEL maintainer="brian.skjerven@pawsey.org.au"

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

# Copy customised Cell Ranger into container
# Assumes a folder with a Cell Ranger installation is available in the same directory of the Dockerfile
ARG CELLRANGER_VERSION="3.0.0-custom"

RUN mkdir -p /apps/cellranger-${CELLRANGER_VERSION}/
ADD cellranger /apps/cellranger-${CELLRANGER_VERSION}/

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

WORKDIR /data
# Add cell ranger to path
ENV PATH /apps/cellranger-${CELLRANGER_VERSION}:$PATH
