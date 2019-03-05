#!/bin/sh
cd $source_dir

cd $deepmd_source/source
mkdir build 
cd build

cmake -DXDRFILE_ROOT=$xdrfile_root -DTENSORFLOW_ROOT=$tensorflow_root -DCMAKE_INSTALL_PREFIX=$deepmd_root -DTF_GOOGLE_BIN=true ..
make -j20
make install
cp $deepmd_source/data/raw/* $deepmd_root/bin/
ls $deepmd_root/bin
