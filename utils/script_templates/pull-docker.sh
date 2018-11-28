#!/bin/bash

pkg_list="
ubuntu
ubuntu:18.04
debian
centos

marcodelapierre/octave_gnuplot:4.2.2_5.2.2_2

continuumio/miniconda:4.5.11
continuumio/miniconda3:4.5.11
continuumio/anaconda:5.3.0
continuumio/anaconda3:5.3.0
jupyter/base-notebook
jupyter/minimal-notebook
jupyter/scipy-notebook
jupyter/r-notebook
jupyter/datascience-notebook

rocker/r-ver:3.5.1
rocker/rstudio:3.5.1
rocker/tidyverse:3.5.1
bioconductor/release_base2:R3.5.1_Bioc3.8
bioconductor/release_core2:R3.5.1_Bioc3.8
"

for p in $pkg_list ; do
 docker pull $p
done

exit
