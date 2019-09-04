#!/bin/bash

# general root data directory in cluster/VM, with everything in there
workspace="/data"
# topdir and juicerdir should be within workspace
topdir="$(pwd)"
juicerdir="$(pwd)"

# cluster can be : CPU AWS LSF PBS SLURM UGER 
cluster="CPU"



# changes usually not required past this point
juicer_container="marcodelapierre/juicer:27Aug19"

if [ "$cluster" != "CPU" ] ; then
  cluster="${cluster}/scripts"
fi

if [ -d ${juicerdir}/restriction_sites ] ; then
  mountsites="-v ${juicerdir}/restriction_sites:/apps/juicer/restriction_sites"
else
  mountsites=""
fi

docker run \
  --rm \
  -u $(id -u):$(id -g) \
  -v $workspace:$workspace -w $(pwd) \
  -v ${juicerdir}/references:/apps/juicer/references \
  $mountsites \
  $juicer_container \
  bash -c " \
    ln -s /apps/juicer/$cluster /apps/juicer/scripts && \
    /apps/juicer/scripts/juicer.sh -d $topdir -D /apps/juicer "$@" \
    "
