#!/bin/sh
cd $tensorflow_source
mkdir /tmp/proto
cd tensorflow/contrib/makefile/downloads/protobuf/
./autogen.sh
./configure --prefix=/tmp/proto/
make -j20
make install
