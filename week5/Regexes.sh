#!/bin/bash

echo " "
echo "XXXXX - search for all lines containing "Sed""
echo " "

grep -r  -w sed

echo " "
echo "XXXXX - search for all lines that start with the letter m "
echo " "

grep -r "^m"

echo " "
echo " XXXXX - search for all lines that contain 3 digits"
echo " "

grep -r -P  -Po '\b\d{3}\b'

echo " "
echo "XXXXX - search for all lines starting with echo containing at least 3 words"
echo " "

grep -r -P '"\w+\s+\w+\s+\w+\s+' | grep -P "echo"

echo " "
echo "XXXXX - search for lines which would make a good password - 10 chars min, containing upper, lower and numerics"
echo " "

grep  -h -r -o -E '(\w{10,})' | grep -h '[[:upper:]][[:lower:]][[:digit:]]'

exit 0
