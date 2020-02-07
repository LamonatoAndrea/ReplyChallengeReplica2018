# 02 - XMLExternalFlag
## Description
Once again, R-Boy is disappointed! He’s found no clues, so far. He starts thinking the rebels may have used false leads to stop snoopers discovering their plan, or could it be a training website for new Rebels?.

He decides to carry on and chooses the third URL.

The web page he reaches looks empty, but it may have more information than it appears! R-Boy decides to stay on the page and analyse it.

Help R-Boy make sure he’s not wasting his precious time!

## Run the code
To execute the code it is possible to run the run.sh script within this directory.\
Please note that the script will copy its files within a directory (default is /tmp/server/) and creates symbolic links to expr, ls, pwd and rbash executables using the which command.

### run.sh
```bash
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
```