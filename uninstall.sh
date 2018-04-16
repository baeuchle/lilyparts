#!/bin/bash

undeleted=""
while read file; do
    if [ -e "$file" ]; then
        rm $file;
        if [ $? -ne 0 ]; then
            undeleted=$(printf "%s%s\n" $undeleted $file)
        fi
    fi
done < .install_destination

if [ -z $undeleted ]; then
    rm .install_destination
    exit 0;
fi
echo "
Could not delete all files, there may be unsufficient permissions.

Try
sudo $0
to run as root, or delete the following files on your own:
$undeleted"
exit 1;
