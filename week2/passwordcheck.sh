#!/bin/bash
temp1=$(cat ~/scripts/portfolio/week\ 2/pwfolder/secret.txt)
Prmpt="Please enter your Password: "
echo -n  "$Prmpt"
read -s temp2
echo "$temp2" | sha256sum >  tmp.txt
temp3=$(cat  tmp.txt)
echo " "
rm tmp.txt
if [ "$temp3" == "$temp1" ]; then
    echo "Access Granted"
    exit 0
else
    echo "Access Denied"
    exit 1
fi
