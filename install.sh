#!/bin/bash

# copies lilysplit to a directory inside PATH and sets the includedir
# variable inside it to this directory.

file=lilysplit

#TODO: read additional path candidate from $*
#TODO: allow overwrite of is-inside-PATH-condition from $*

# get directory inside path:
path_candidates=($HOME/.bin $HOME/bin /usr/bin /usr/local/bin)
path_candidates=($HOME/.bin $HOME/bin /usr/bin /usr/local/bin)
for dir in $path_candidates; do
    if [[ $PATH == *":$dir:"* ]] && [ -w "$dir" ]; then
        path=$dir
    fi
done

if [ "$path" == "" ]; then
    echo "No suitable and writable target directory found!" >&2;
    exit 1;
fi
echo "Copying $file to $dir/$file";

#TODO: Only overwrite existing file if forced or new version

perl -pe 's{^\s*includedir=.*$}{includedir='$(dirname $(readlink -f $0))'}' $file > $dir/$file
chmod +x $dir/$file
