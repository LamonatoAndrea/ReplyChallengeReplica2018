# 02 - XMLExternalFlag
## Description
Once again, R-Boy is disappointed! He’s found no clues, so far. He starts thinking the rebels may have used false leads to stop snoopers discovering their plan, or could it be a training website for new Rebels?.

He decides to carry on and chooses the third URL.

The web page he reaches looks empty, but it may have more information than it appears! R-Boy decides to stay on the page and analyse it.

Help R-Boy make sure he’s not wasting his precious time!

### Run the code
To execute the code it is possible to run the run.sh script within this directory.\
Please note that the script will copy its files within a directory (default is /tmp/server/) and creates symbolic links to expr, ls, pwd and rbash executables using the which command.

#### run.sh
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

## Vulnerability
This is an example of command injections and an XXE vulnerabilities due to insufficient sanitization of the user input.

### Command injection vulnerability
The use of custom sanitization functions can easily lead to miss some details that allows the exploitation, the input is sanitized with a regex at line 26 in the `level3Test.php` code:
```php
preg_match('/([^a-zA-Z0-9;])/', $xml[$i])
```

Moreover the input itself is sent directly to the rbash subsystem without further processing through the php `shell_exec` function as:
```bash
rbash -c 'expr length $sanitized' 2>&1
```

### XXE vulnerability
This vulnerability also revolves around insufficient sanitization of user input that, in this case, is directly passed to the XML parser:
```php
$dom->loadXML($_POST['xml'], LIBXML_NOENT | LIBXML_DTDLOAD); 
```
