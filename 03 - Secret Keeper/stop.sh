#!/bin/bash

dockerImg="mysql"
dbName="web400"
rootPsw="password"
mysqlPort=3306
dbUser="web400"
dbUserPsw="password"

sudo docker stop $dbName
sudo docker rm $dbName -f
