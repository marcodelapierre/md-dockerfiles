#!/bin/bash

type="$(basename $0)"
type="${type%.sh}"

if [ "$type" == "anaconda" ] ; then
 cont="continuumio/anaconda:5.3.0"
elif [ "$type" == "anaconda3" ] ; then
 cont="continuumio/anaconda3:5.3.0"
elif [ "$type" == "conda" ] ; then
 cont="continuumio/miniconda:4.5.11"
else
 cont="continuumio/miniconda3:4.5.11"
fi

docker run --rm -it \
	-v /data:/data -w $(pwd) \
	-u $(id -u):$(id -g) \
	$cont /bin/bash
