!/bin/bash

part=$(man diary | egrep -o '[a-zA-Z0-9]{28}')
echo 'Flag is: ' $part
