FROM tfgpu3b

LABEL maintainer="Marco De La Pierre <marco.delapierre@pawsey.org.au>"

ENV source_dir="/source"
# download tensorflow
ARG tensorflow_version="1.8"
ENV tensorflow_source="/tensorflow" \
    tensorflow_root="/apps/tensorflow"

ARG bazel_version="0.15"

# install the dependencies of tensorflow and xdrfile
ARG xdrfile_version="1.1.4"
ENV xdrfile_version="$xdrfile_version" \
    xdrfile_root="/apps/xdrfile"
COPY install_protobuf.sh install_eigen.sh install_nsync.sh install_absl.sh install_xdrfile.sh copy_lib.sh "$source_dir"/
RUN cd "$tensorflow_source" && \
      tensorflow/contrib/makefile/download_dependencies.sh && \
    cd "$source_dir" && \
      sh -x install_protobuf.sh && \
      sh -x install_eigen.sh && \
      sh -x install_nsync.sh && \
#      sh -x install_absl.sh && \
      sh -x copy_lib.sh && \
      sh -x install_xdrfile.sh

# install deepmd
ARG deepmd_version="v0.12.4"
ENV deepmd_source="${source_dir}/deepmd-kit" \
    deepmd_root="/apps/deepmd"
COPY install_deepmd.sh "$source_dir"/
RUN cd "$source_dir" && \
    git clone https://github.com/deepmodeling/deepmd-kit.git deepmd-kit && \
    cd deepmd-kit && \
    git checkout "$deepmd_version" && \
    cd .. && \
    sh -x install_deepmd.sh

# install lammps
ARG lammps_version="patch_31Mar2017"
ENV lammps_version="$lammps_version"
COPY install_lammps.sh "$source_dir"/
RUN cd "$source_dir" && \
    wget https://codeload.github.com/lammps/lammps/tar.gz/"$lammps_version" && \
    tar xf "$lammps_version" && \
    sh -x install_lammps.sh

ENV PATH="${source_dir}/lammps-${lammps_version}/src:${deepmd_root}/bin:$PATH"

CMD ["/bin/bash"]

