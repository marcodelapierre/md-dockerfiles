#!/bin/bash

# general root data directory in cluster/VM, with everything in there
workspace="/data"
# topdir and juicerdir should be within workspace
topdir="$(pwd)"
juicerdir="$(pwd)"

# cluster can be : CPU AWS LSF PBS SLURM UGER 
cluster="CPU"



export SINGULARITY_BINDPATH="${SINGULARITY_BINDPATH},$workspace"

if [ "$cluster" != "CPU" ] ; then
  cluster="${cluster}/scripts"
fi

if [ "$topdir" != "$juicerdir" ] ; then
  ln -s ${juicerdir}/references $topdir
  if [ -d ${juicerdir}/restriction_sites ] ; then
    ln -s ${juicerdir}/restriction_sites $topdir
  fi
fi

#  marcodelapierre/juicer:27Aug19 \
singularity exec \
  $SYMAGES/juicer_27Aug19.sif \
  bash -c " \
    ln -s /apps/juicer/$cluster ${topdir}/scripts && \
    ${topdir}/scripts/juicer.sh -d $topdir -D $topdir "$@" ; \
    rm ${topdir}/scripts \
    "

if [ "$topdir" != "$juicerdir" ] ; then
  rm ${topdir}/references
  if [ -d ${juicerdir}/restriction_sites ] ; then
    rm ${topdir}/restriction_sites
  fi
fi

