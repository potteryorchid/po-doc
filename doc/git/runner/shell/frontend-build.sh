#!/usr/bin/env bash
cd $1
pwd
npm config set registry https://registry.npm.taobao.org
sleep 2
npm install
sleep 3
npm run build
chmod -R 777 $1
