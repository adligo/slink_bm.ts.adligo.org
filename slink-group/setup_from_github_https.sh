#!/usr/bin/bash

echo "Running npm version"
npm -v
echo "Running git version"
git -v
echo "Running slink version"
slink -v
npm install -g @ts.adligo.org/slink
git clone https://github.com/adligo/slink_group_deps.ts.adligo.org.git
git clone https://github.com/adligo/slink_group.ts.adligo.org.git
cd slink_group_deps.ts.adligo.org
npm install
cd ../slink_group.ts.adligo.org
npm run git-clone # Note this should use https and not ssh!
npm run setup
npm run build
npm run tests
