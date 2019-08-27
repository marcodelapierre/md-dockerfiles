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

# Install Supernova
ARG SUPERNOVA_VERSION="2.1.1"
ARG SUPERNOVA_WEB_TOKEN="http://cf.10xgenomics.com/releases/assembly/supernova-2.1.1.tar.gz?Expires=1566931698&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cDovL2NmLjEweGdlbm9taWNzLmNvbS9yZWxlYXNlcy9hc3NlbWJseS9zdXBlcm5vdmEtMi4xLjEudGFyLmd6IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTY2OTMxNjk4fX19XX0_&Signature=Ht3Sr~lPj5Zuqetgdd89NzWHC1xN~J1qsfrGAP3JX5Sb9Y0rNH-GAKSCYVKb0Yn6lcY8F-N-o6FvE4zWiigte-TU9yOEle~aeh7fbY8reGGooOBcSmvaHK4uqjSAg8zKV59HghfKKGHOiNMNZqCzJB1FtxnChlhLSCUlhfkToVdSj32SN7bsALFtVGQKt2uEVlMpgPBORX0LFrWRsRVB8C4PFarqMXvlTaA8rcG5-MSOOsp2ViO0HP1yV~~8jBF6VV3GKopItJHzv5RHnmJwjl71KXt4HCgaqOo3Bc5mh0JmSgG84oKfgz45n8bFlb23oAZzHUUIayayse0EmlHfuQ__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

RUN mkdir -p /tmp/supernova-build \
    && cd /tmp/supernova-build \
    && wget -O supernova-${SUPERNOVA_VERSION}.tar.gz ${SUPERNOVA_WEB_TOKEN} \
    && mkdir /apps \
    && mv supernova-${SUPERNOVA_VERSION}.tar.gz /apps/ \
    && cd /apps \
    && tar -xzvf supernova-${SUPERNOVA_VERSION}.tar.gz \
    && rm -f supernova-${SUPERNOVA_VERSION}.tar.gz \
    && rm -rf /tmp/supernova-build

WORKDIR /data
# Add Supernova to path
ENV PATH /apps/supernova-${SUPERNOVA_VERSION}:$PATH
