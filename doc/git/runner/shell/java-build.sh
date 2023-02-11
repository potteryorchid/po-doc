#!/usr/bin/env bash
cd $1
pwd
mvn -DskipTests=true -s /home/gitlab-runner/shell/settings.xml clean package
chmod -R 777 $1