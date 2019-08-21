#!/bin/bash

type="$(basename $0)"
type="${type%.sh}"

if [ "$type" == "anaconda2" ] ; then
 cont="continuumio/anaconda2:2019.07"
elif [ "$type" == "anaconda" ] ; then
 cont="continuumio/anaconda3:2019.07"
elif [ "$type" == "conda2" ] ; then
 cont="continuumio/miniconda2:4.6.14"
else
 cont="continuumio/miniconda3:4.6.14"
fi

docker run --rm -it \
	-v $(echo ~):$(echo ~) -w $(pwd) \
	$cont /bin/bash
