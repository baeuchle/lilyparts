#!/bin/bash

path_candidates=($HOME/.bin $HOME/bin /usr/bin /usr/local/bin)
only_in_path=0
forceoverwrite=-i

function help {
  echo "

Installs lilysplit to a directory in \$PATH.

--cleardirs
        Forget all predefined directories as install candidates.  Also forgets
        all directories that have been added with --dir before this option.
        Pre-defined directories: $path_candidates

--dir DIRECTORY
        Add DIRECTORY to list of predefined directories.

--only-in-PATH (default)
--allow-outside-PATH
        Only use directories that are in the current user's \$PATH environment
        variable (default) or allow others too.

--i (default)
--f
        Ask interactively (--i) or force (--f) overwrite of existing file.

"
}


while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --cleardirs)
      path_candidates=""
      shift;;
    --path)
      path_candidates+=($2)
      shift;
      shift;;
    --only-in-PATH)
      only_in_path=0;
      shift;;
    --allow-outside-PATH)
      only_in_path=1;
      shift;;
    --f)
      forceoverwrite=-f
      shift;;
    --i)
      forceoverwrite=-i
      shift;;
    --help)
      help
      exit 1;;
    *)
      shift;;
  esac
done


# copies lilysplit to a directory inside PATH and sets the includedir
# variable inside it to this directory.

file=lilysplit

for dir in $path_candidates; do
    # get writable directory...
    if [ -w "$dir" ]; then
        # which is inside $PATH, unless we allow other dirs too:
        if [[ $PATH == *":$dir:"* ]] || [[ $only_in_path -eq 0 ]]; then
            path=$dir
            break
        fi
    fi
done

if [ "$path" == "" ]; then
    echo "No suitable and writable target directory found!" >&2;
    exit 1;
fi
echo "Copying $file to $dir/$file";

tmp=$(mktemp)

perl -pe 's{^\s*includedir=.*$}{includedir='$(dirname $(readlink -f $0))'}' $file > $tmp
chmod +x $tmp
mv $forceoverwrite $tmp $dir/$file

# store file name for uninstall
echo "$dir/$file" >> .install_destination
