#!/usr/bin/env bash

#
# Author      : Dipack P Panjabi
# Description : This script is used to watch and mirror a directory to another.
#               I use it to mirror my dropbox data to my Google Drive
#

source="$1";
target="$2";

if [ -z "$source" ] || [ -z "$target" ]; then
    echo "Source or target not set.";
    echo "Source: $source";
    echo "Target: $target";
    exit 255;
fi

echo
echo "Mirroring $source to $target";
echo

while inotifywait --recursive --event modify,create,delete $source; do
    rsync --archive --update --delete --one-file-system --info=progress2 --exclude=".*" --exclude="Skydiving" --exclude=".dropbox" --exclude="~*" $source $target;
done
