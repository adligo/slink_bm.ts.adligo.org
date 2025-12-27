#!/usr/bin/bash

echo "Running npm version"
npm -v
echo "Running git version"
git -v

git clone git@github.com:adligo/slink.ts.adligo.org.git
cd slink.ts.adligo.org
npm install
npm run build
