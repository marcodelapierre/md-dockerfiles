#!/bin/sh
cd $source_dir

cd $deepmd_source/source
mkdir build 
cd build

ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:${LD_LIBRARY_PATH}

cmake -DXDRFILE_ROOT=$xdrfile_root \
  -DTENSORFLOW_ROOT=$tensorflow_root \
  -DCMAKE_INSTALL_PREFIX=$deepmd_root \
  ..
#  -DTF_GOOGLE_BIN=true \
#  -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0 \

make -j20
make install

rm /usr/local/cuda/lib64/stubs/libcuda.so.1

cp $deepmd_source/data/raw/* $deepmd_root/bin/
ls $deepmd_root/bin
