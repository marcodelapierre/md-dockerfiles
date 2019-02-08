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
git clone https://github.com/marcodelapierre/deepmd-kit_docker.git
```

Build the Docker image:
```
cd deepmd-kit_docker
docker build -f Dockerfile -t deepmd-kit .
```

It can take up to a few hours to download necessary package and install them.


## Notes

The `ENV` statement in Dockerfile sets the install prefix of packages. These environment variables can be set by users themselves.

The `ARG tensorflow_version` specifies the version of tensorflow to install, which can be set during the build command through `--build-arg tensorflow_version=1.8`.
