#!/bin/bash

pre="jupyter"
type="$(basename $0)"
type="${type%.sh}"
type="${type#${pre}-}"

if [ "$type" == "base" ] ; then
 cont="jupyter/base-notebook"
elif [ "$type" == "minimal" ] ; then
 cont="jupyter/minimal-notebook"
elif [ "$type" == "scipy" ] ; then
 cont="jupyter/scipy-notebook"
elif [ "$type" == "r" ] ; then
 cont="jupyter/r-notebook"
else
 cont="jupyter/datascience-notebook"
fi

docker stop jupyter &>/dev/null
docker run --rm -d \
	-p 8888:8888 \
	-v /data/jupyter:/home/jovyan/data \
	-u $(id -u):$(id -g) --group-add users \
	--name jupyter \
	$cont &>/dev/null
sleep 5
( docker logs jupyter 3>&1 1>/dev/null 2>&3- ) | grep token= | tail -1 | cut -d '=' -f 2 | pbcopy
open -a /Applications/Safari.app http://localhost:8888
