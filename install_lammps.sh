#!/bin/sh
#If everything works fine, DeePMD-kit will generate a module called USER-DEEPMD in the build directory. Now download your favorite Lammps code, and uncompress it (I assume that you have downloaded the tar lammps-stable.tar.gz)
cd $deepmd_source_dir/source/build
make lammps

#The source code of Lammps is store in directory. Now go into the lammps code and copy the DeePMD-kit module like this
cd /root/lammps*/src/
cp -r $deepmd_source_dir/source/build/USER-DEEPMD .

#Patch to enable OpenMP compile
sed -e '/CCFLAGS.*=/ s/$/ -fopenmp/g' -e '/LINKFLAGS.*=/ s/$/ -fopenmp/g' MAKE/Makefile.serial >MAKE/Makefile.omp

#Now build Lammps
make yes-manybody
make yes-mc
make yes-rigid
make yes-user-meamc
make yes-user-deepmd

make mpi-stubs
make omp -j4
