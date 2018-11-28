#!/bin/bash

pre="R"
type="$(basename $0)"
type="${type%.sh}"
type="${type#${pre}-}"

flag="-it"
cmd="R"
args=""
if [ "$type" == "tidy" ] ; then
 cont="rocker/tidyverse:3.5.1"
elif [ "$type" == "bioc-base" ] ; then
 cont="bioconductor/release_base2:R3.5.1_Bioc3.8"
elif [ "$type" == "bioc-core" ] ; then
 cont="bioconductor/release_core2:R3.5.1_Bioc3.8"
else
 cont="rocker/rstudio:3.5.1"
fi
if [ $# -gt 0 ] ; then
 flag=""
 cmd="Rscript"
 args="$@"
fi

docker run --rm $flag \
	-v $(echo ~):$(echo ~) -w $(pwd) \
	$cont $cmd $args
