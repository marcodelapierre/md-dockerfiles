cd $source_dir
wget ftp://ftp.gromacs.org/pub/contrib/xdrfile-${xdrfile_version}.tar.gz
tar xvf xdrfile-${xdrfile_version}.tar.gz
cd xdrfile-${xdrfile_version}
./configure --prefix=$xdrfile_root
make -j8
make install
