#!/usr/bin/bash

echo "Running npm version"
npm -v
echo "Running git version"
git -v
echo "Running slink version"
slink -v
git clone git@github.com:adligo/slink_group_deps.ts.adligo.org.git
git clone git@github.com:adligo/slink_group.ts.adligo.org.git
cd slink_group_deps.ts.adligo.org
npm install
cd ../slink_group.ts.adligo.org
npm run git-clone-ssh
npm run setup
npm run build
npm run tests