#!/bin/sh
#If everything works fine, DeePMD-kit will generate a module called USER-DEEPMD in the build directory. Now download your favorite Lammps code, and uncompress it (I assume that you have downloaded the tar lammps-stable.tar.gz)
cd $deepmd_source/source/build
make lammps

#The source code of Lammps is store in directory. Now go into the lammps code and copy the DeePMD-kit module like this
cd ${source_dir}/lammps-${lammps_version}/src/
cp -r $deepmd_source/source/build/USER-DEEPMD .

#Patch for OpenMP and for CPU architecture
sed -i -e '/CCFLAGS.*=/ s/$/ -fopenmp -march=haswell/g' MAKE/Makefile.mpi

#Now build Lammps
make yes-manybody
make yes-mc
make yes-rigid
make yes-user-meamc
make yes-user-deepmd
# optimisation packages
make yes-opt
make yes-user-intel

make mpi -j4
