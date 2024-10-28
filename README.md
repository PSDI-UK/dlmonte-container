# DL_MONTE Container Image

This repository houses machinery for building a container image of the
molecular simulation Monte Carlo program [DL_MONTE](https://gitlab.com/dl_monte).
The `Dockerfile` here builds a container image housing the latest
development snapshot of DL_MONTE. The image is intended to be used
as a container-image analogue of the DL_MONTE executable.

## Obtaining an image

Images can be found in  the 'Packages' section of this GitHub project.
Commands are provided there to pull a specific version to your local
instance of docker, e.g.
```
docker pull ghcr.io/psdi-uk/dlmonte-container/dlmonte:v0.0.1`
```

## Usage

The intendend use of this image is to run DL_MONTE simulations
via commands such as:
```
docker run -v ${PWD}:/data dlmonte:v0.0.1`
```
This command assumes that the image is named 'dlmonte:v0.0.1' and that the
current directory contains the DL_MONTE input files for the desired
simulation. Upon instigating this command, the container will
execute DL_MONTE in the current directory, and DL_MONTE output files
will be created in the directory. Upon completion of the DL_MONTE
executable the container will terminate.

## Building the image

To use the `Dockerfile` to build the image locally the command is:
```
docker build -t dlmonte .
```
where it is assumed that the image is to be named `dlmonte` and it
is also assumed that the `Dockerfile` file is in the current
directory.

## Notes for developers
- Some example DL_MONTE input files are provided in the directory
  `dlmonte_example_input`. Invoking DL_MONTE using the container
  image as described above in the same directory as these files
  should result in the creation of a number of files ending in
  `.000`. Moreover, the `OUTPUT.000` file, which contains a log
  created by DL_MONTE during execution, should conclude with 'normal
  exit'.