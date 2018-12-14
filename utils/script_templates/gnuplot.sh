#!/bin/bash
  
type="$(basename $0)"
type="${type%.sh}"

flag="-it"
args=""
if [ "$type" == "octave" ] ; then
 cmd="octave-cli"
elif [ "$type" == "octave-gui" ] ; then
 cmd="octave"
else
 cmd="gnuplot"
fi
if [ $# -gt 0 ] ; then
 flag=""
 args="$@"
fi


XAUTH=/tmp/.docker.xauth.$(basename $(tty))
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run --rm $flag \
	-v /data:/data -w $(pwd) \
	-u $(id -u):$(id -g) \
	-e DISPLAY=docker.for.mac.localhost:0 -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH \
	marcodelapierre/octave_gnuplot:4.2.2_5.2.2_2 $cmd $args

