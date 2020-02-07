#!/bin/bash

################################
# Will execute in $serverDir ! #
################################

binDir="bin"
serverDir="/tmp/server"

mkdir -p $serverDir
cp -rv ./* $serverDir

cd $serverDir

rm -r $binDir

mkdir $binDir
chmod 755 $binDir

ln -s $(which expr) $binDir
ln -s $(which ls) $binDir
ln -s $(which pwd) $binDir
ln -s $(which rbash) $binDir

php	 -S localhost:8001
