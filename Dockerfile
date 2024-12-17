# Builds a container image housing to the latest development snapshot
# of DL_MONTE. The intendend use of this image is to run DL_MONTE
# simulations via commands such as:
#
#    docker run -v ${PWD}:/data dlmonte
#
# This command assumes that the image is named 'dlmonte' and that the
# current directory contains the DL_MONTE input files for the desired
# simulation. Upon instigating this command, the container will
# execute DL_MONTE in the current directory, and DL_MONTE output files
# will be created in the directory. Upon completion of the DL_MONTE
# executable the container will terminate.
#
# The command to build this image is:
#   docker build -t dlmonte .
#

#TU: FOR DEBIAN...
#FROM debian:bookworm-slim
#TU: FOR ALPINE...
FROM alpine:latest

WORKDIR /app

# Install system dependencies
#TU: FOR DEBIAN...
#RUN apt-get update
#RUN apt-get install -y \
#    gfortran \
#    make \
#    unzip \
#    wget
#TU: FOR ALPINE...
RUN apk update
RUN apk add \
    make \
    gfortran \
    unzip \
    wget

# Install DLMONTE
RUN wget -q https://gitlab.com/dl_monte/DL_MONTE-2/-/archive/master/DL_MONTE-2-master.zip
RUN unzip DL_MONTE-2-master.zip
RUN rm DL_MONTE-2-master.zip
WORKDIR /app/DL_MONTE-2-master
#TU: FOR DEBIAN...
#RUN bash build.sh SRL dir gfortran
#TU: FOR ALPINE...
RUN sh build.sh SRL dir gfortran

ENV PATH=/app/DL_MONTE-2-master/bin:$PATH

# /data is an empty directory to serve as a mount point
WORKDIR /data

# Default command to execute upon execution of container
CMD ["DLMONTE-SRL.X"]
