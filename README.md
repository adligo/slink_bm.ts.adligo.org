# [The SLink Build Matrix](https://github.com/adligo/slink_bm.ts.adligo.org)

This is the main place to start if your working on SLink or one of it's Adligo.org dependency libraries.  The goal of this (and any) Build Matrix is simply to get the build working everywhere and anywhere so that anyone can easily execute the build successfully and work on the code.  This Build Matrix includes the following 6 build work flows (choose one and if it isn't working try another);

## 1) Build Everything Related to Adligo.org Locally From the [Github.com](https://github.com/adligo) Projects

[docs/BUILD_EVERYTHING_LOCALLY.md](./docs/BUILD_EVERYTHING_LOCALLY.md)

##### Note:

This is used to build (and potentially release) all of the Adligo.org dependencies used by SLink.  This was the way all of the SLink code and dependencies were originally created.

## 2) Build SLink Using [Npmjs.com](https://www.npmjs.com/) Dependencies

[docs/BUILD_SOLO_LOCALLY.md](./docs/BUILD_SOLO_LOCALLY.md)

##### Note:

This is used to build (and release) SLink itself, and is useful if you want to focus on the SLink code. 


## 3) Build Everything In Jenkins From the [Github.com](https://github.com/adligo) Projects

[docs/BUILD_IN_JENKINS_FROM_GITHUB.md](./docs/BUILD_IN_JENKINS_FROM_GITHUB.md)

##### Note:

This is the CI (Continuous Integration) part of the CICD (Continuous Integration Continuous Delivery) system and can be hosted locally or in Docker.  Delivery is also known as releasing (See work flows 1 and 2).

## 4) Build Everything Related to Adligo.org In Docker From the [GitHub.com](https://github.com/adligo) Projects After Local Clones

[docs/BUILD_EVERYTHING_IN_DOCKER_FROM_LOCAL_CLONES.md](./docs/BUILD_EVERYTHING_IN_DOCKER_FROM_LOCAL_CLONES.md)

##### Note:

This is an alternate way to do work flow 1, if it isn't working on your machine, or if you need some sort of a reproducible build environment for something like a test or trial of an AI coding tool.

## 5) Build SLink Using Local [Npmjs.com](https://www.npmjs.com/) Dependencies In Docker

[docs/BUILD_SOLO_IN_DOCKER_FROM_LOCAL_CLONE.md](./docs/BUILD_SOLO_IN_DOCKER_FROM_LOCAL_CLONE.md)

##### Note:

This is an alternate way to do work flow 2, if it isn't working on your machine, or if you need some sort of a reproducible build environment for something like a test or trial of an AI coding tool.

## 6) Build Everything from Local Git Repositories in Jenkins 

[docs/BUILD_IN_JENKINS_FROM_LOCAL_GIT_REPOSITORIES.md](./docs/BUILD_IN_JENKINS_FROM_LOCAL_GIT_REPOSITORIES.md)

##### Note:

This is the build that would be used by library maintainers in order to make sure that changes to libraries don't break downstream projects (projects that require the dependency), before pushing to [GitHub](https://github.com/adligo) and [Npmjs.com](https://www.npmjs.com/).

## SLink Historical Notes

Note:  SLink is actually a fairly screwy (chicken versus egg ) build, because the SLink-Group actually relies on the SLink tool.  Now that we have chickens and eggs, it can be completed in any order.  However, historically the order was build the 'slink' command line tool with SLink-Solo.  Then build the SLink-Group which includes a testing library and test for SLink.  Finally get it all running on a Jenkins server for future CICD work.

### Public Log

This project was renamed from slink_docker.ts.adligo.org to slink-bm.ts.adligo.org on 2025-12-24, because it is really a build matrix (hence the -bm part in the name) which can use Docker.  However Docker isn't required, as you can also build it locally simply from source on the CLI or using Jenkins.  It was the original matrix build system, and matrix build systems are actually fairly complex.