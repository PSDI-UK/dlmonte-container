# DL_MONTE Container Image

This repository houses machinery for building a container image of the
molecular simulation Monte Carlo program [DL_MONTE](https://gitlab.com/dl_monte).
The `Dockerfile` here builds a container image housing the latest
development snapshot of DL_MONTE. The image is intended to be used
as a container-image analogue of the DL_MONTE executable.

See the [DL_MONTE manual](https://dl_monte.gitlab.io/dl_monte_manual/)
and [here](https://gitlab.com/dl_monte/user-hub) for further information
about the program.

## Obtaining an image

Images can be found in  the [Packages](https://github.com/PSDI-UK/dlmonte-container/pkgs/container/dlmonte-container%2Fdlmonte)
section of this GitHub project.
Commands are provided there to pull a specific version to your local
instance of docker, e.g.
```
docker pull ghcr.io/psdi-uk/dlmonte-container/dlmonte:v0.0.1
```

## Usage

It is intended that the image be used similarly to the
DL_MONTE binary executable in order to run DL_MONTE simulations. An
example command is:
```
docker run -v ${PWD}:/data dlmonte:v0.0.1
```
This command assumes that the image is named 'dlmonte:v0.0.1' and that the
current directory contains the DL_MONTE input files for the desired
simulation. Upon instigating this command, the container will
execute DL_MONTE in the current directory, and DL_MONTE output files
will be created in the directory. Upon completion of the DL_MONTE
executable the container will terminate.


## Security vulnerabilities

The latest version of this container image uses [Apline Linux](https://hub.docker.com/_/alpine)
as a base image. **Note that the base image, and the packages
installed onto it in order to compile DL_MONTE when creating the DL_MONTE
container image, may have security vulnerabilities.** Hence use this image at your own risk.
See the `Dockerfile` for more details regarding the contents of this image.

## Building the image

To use the `Dockerfile` to build the image locally the command is:
```
docker build -t dlmonte .
```
where it is assumed that the image is to be named `dlmonte` and it
is also assumed that the `Dockerfile` file is in the current
directory.


## License

The code in this repository is provided under the conditions
described in the `LICENSE` file in this repository. However, while some of this
code describes container images or processes to build container images,
the software license applicable to these container images will in general not be the
same as `LICENSE`. This is because a container image typically includes binaries
and source code from many pieces of software; the software license for a
container image depends on the licenses of its constitutent software.
This should be kept in mind when using any container image linked to this
repository, or any container image built using code in this repository.


## Notes for developers

### Testing the container image
Some example DL_MONTE input files are provided in the directory
`dlmonte_example_input`. (Note that DL_MONTE expects a minimum of
3 files: `CONTROL`,`CONFIG`, and `FIELD`. Such files are provided therein).
Invoking DL_MONTE using the container
image as described above in the same directory as these files
should result in the creation of a number of files ending in
`.000`. Moreover, the `OUTPUT.000` file, which contains a log
created by DL_MONTE during execution, should conclude with 'normal
exit'. As mentioned below, the CI/CD pipeline incorporates a job to ensure
that the container image behaves in this way. In the future it would be
nice if the container image were checked against the entire
[DL_MONTE test suite](https://gitlab.com/dl_monte/dl_monte_tests).

### CI/CD pipeline
Note that GitHub Actions is used to implement a CI/CD pipeline which, every
commit:
1. Builds the container image and performs light testing to ensure that it works.
   The testing currently entails ensuring that the DL_MONTE output file `OUTPUT.000`
   is generated if the image is used to invoke a DL_MONTE simulation,
   as described above, using the example input DL_MONTE files in the
   `dlmonte_example_input` directory. 
2. Builds the container image and scans it for **security vulnerabilities**.
   Reports regarding vulnerabilities can be found
   [here](https://github.com/PSDI-UK/dlmonte-container/security/code-scanning).
3. Builds the container image, gives it a version tag, and publishes it in
   the [Packages](https://github.com/PSDI-UK/dlmonte-container/pkgs/container/dlmonte-container%2Fdlmonte)
   section of this project.
4. Creates an archive containing the source code of this repository, gives
   it a version tag, and publishes it in the [Releases](https://github.com/PSDI-UK/dlmonte-container/releases)
   section.

It is important to keep this pipeline up to date with regards to upstream
dependencies. For example, the pipeline uses a particular version of the
`anchore/scan-action` Action (e.g. `anchore/scan-action@v6` means version 6).
This should be updated if a new version of this Action is released. Note that
certain Actions will print warnings if, e.g. certain features in the Actions
which are used in this repo are to be deprecated; pay attention to such
warnings.


### Metadata for the PSDI Resource Catalogue
The file `psdi-tool-store-metadata.json` houses metadata for the
container image which is used by the prototype
[PSDI Tool Store](https://psdi-uk.github.io/psdi-tool-store/). Ideally the
information in this file would be updated as part of a CI/CD pipeline,
but for now its contents are 'static'. This is something that may be explored.


