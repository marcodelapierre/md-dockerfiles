# Docker Engine Utility for DeePMD-kit

[DeePMD-kit](https://github.com/deepmodeling/deepmd-kit#run-md-with-native-code) is a deep learning package 
for many-body potential energy representation, optimization, and molecular dynamics.

This docker project is set up to simplify the installation process of DeePMD-kit.
Thanks to @[TimChen314](https://github.com/TimChen314) 
and @[frankhan91](https://github.com/frankhan91)
for the inital works on this docker project.


## Quick start 

Clone this repo:
```
git clone https://github.com/marcodelapierre/md-dockerfiles.git
```

Build the Docker image:
```
cd md-dockerfiles/machine_learning/deepmd-kit/mpi
docker build -t deepmd-kit_mpi .
```

It can take up to a few hours to download necessary package and install them.


## Notes

The `ENV` statements in the Dockerfile set the install prefix for packages. These environment variables can be set by users themselves.

The `ARG` statements specify package versions to installed, which can be overwritten during the build command, for instance through `--build-arg deepmd_version=0.9.4`.
