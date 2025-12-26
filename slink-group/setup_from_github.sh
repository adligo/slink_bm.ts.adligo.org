#!/usr/bin/bash

docker -v
npm -v
git -v
npm install -g @ts.adligo.org/slink
git clone git@github.com:adligo/slink_group_deps.ts.adligo.org.git
git clone git@github.com:adligo/slink_group.ts.adligo.org.git
cd slink_group_deps.ts.adligo.org
npm install
cd ../slink_group.ts.adligo.org
npm run git-clone-ssh
cd ..
./build_docker.sh my_app
docker run -t my_app ./run_tests.sh