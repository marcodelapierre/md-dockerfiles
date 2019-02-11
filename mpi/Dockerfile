From pawsey/mpi-base:latest

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      autoconf \
      automake \
      cmake \
      curl \
      git \
      libtool \
      rsync \
      unzip \
      vim \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV source_dir="/source"
# download tensorflow
ARG tensorflow_version="1.8"
ENV tensorflow_source="${source_dir}/tensorflow" \
    tensorflow_root="/apps/tensorflow"
RUN mkdir "$source_dir" && \
    cd "$source_dir" && \
    git clone https://github.com/tensorflow/tensorflow tensorflow && \
    cd tensorflow && \
    git checkout "r$tensorflow_version"
# install bazel
ARG bazel_version="0.13.1"
RUN wget https://github.com/bazelbuild/bazel/releases/download/"$bazel_version"/bazel-"$bazel_version"-installer-linux-x86_64.sh && \
    bash bazel-"$bazel_version"-installer-linux-x86_64.sh
# install tensorflow C lib
COPY install_input "$tensorflow_source"/
RUN cd "$tensorflow_source" && \
    ./configure < install_input && \
    bazel build \
      -c opt \
      # --incompatible_load_argument_is_label=false \
      --copt=-mavx2 \
      --verbose_failures \
      //tensorflow:libtensorflow_cc.so 

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

# install tensorflow in python3 module
ENV conda_root="/apps/conda3"
ENV PATH="${conda_root}/bin:$PATH"
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p "$conda_root" && \
    conda config --add channels conda-forge && \
    conda install -c conda-forge -y tensorflow="$tensorflow_version"

ENV OMP_NUM_THREADS=1 \
    PATH="${source_dir}/lammps-${lammps_version}/src:${deepmd_root}/bin:$PATH"

CMD ["/bin/bash"]
