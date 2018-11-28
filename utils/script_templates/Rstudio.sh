#!/bin/bash
  
pre="Rstudio"
type="$(basename $0)"
type="${type%.sh}"
type="${type#${pre}-}"

if [ "$type" == "tidy" ] ; then
 cont="rocker/tidyverse:3.5.1"
elif [ "$type" == "bioc-base" ] ; then
 cont="bioconductor/release_base2:R3.5.1_Bioc3.8"
elif [ "$type" == "bioc-core" ] ; then
 cont="bioconductor/release_core2:R3.5.1_Bioc3.8"
else
 cont="rocker/rstudio:3.5.1"
fi

docker stop rstudio &>/dev/null
PASS="$((RANDOM))rstudiopwd$((RANDOM))"
echo $PASS |pbcopy
docker run --rm -d \
	-p 8787:8787 -e PASSWORD=$PASS \
	-v ~/Documents/rstudio:/home/rstudio/data \
	--name rstudio \
	$cont &>/dev/null
sleep 5
open -a /Applications/Safari.app http://localhost:8787
