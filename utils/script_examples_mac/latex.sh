#!/bin/bash
  
cmd="$(basename $0)"
cmd="${cmd%.sh}"

docker run --rm \
	-v $(echo ~):$(echo ~) -w $(pwd) \
	-u $(id -u):$(id -g) \
	marcodelapierre/texlive_science:2017.20180305-1 $cmd "$@"
