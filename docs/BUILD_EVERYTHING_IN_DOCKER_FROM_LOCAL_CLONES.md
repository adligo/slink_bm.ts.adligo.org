# Workflow 4) Build Everything in Docker From Local Clones

First you will want to run the following commands in order to create a Docker image tagged <strong><b>slink_group9</b></strong>.
Use GitBash for these commands;

```
git clone https://github.com/adligo/slink_bm.ts.adligo.org.git
cd slink_bm.ts.adligo.org/slink-group
clone4docker.sh
docker build --progress=plain  -t slink_group9 .
docker run -it slink_group9
```

### Note 

This build setup does NOT work with [Workflow #1](BUILD_EVERYTHING_LOCALLY.md) because of the symbolic links between the library projects (aka projects under slink_group.ts.adligo.org) and the Dockerfile!  You will need to check everything out in a separate directory to get this to work.

## Part 2

Then from the docker interactive shell you can run npm build and test;

```
ls
cd slink_group.ts.adligo.org
npm run build
npm run tests
```

##### Note:

This is an alternate way to do [work flow 1](./BUILD_EVERYTHING_LOCALLY.md), if it isn't working on your machine, or if you need some sort of a reproducible build environment for something like a test or trial of an AI coding tool.