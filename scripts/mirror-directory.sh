#!/usr/bin/env bash

#
# Author      : Dipack P Panjabi
# Description : This script is used to watch and mirror a directory to another.
#               I use it to mirror my dropbox data to my Google Drive
#

source="$1";
target="$2";

if rclone -v lsf remote:Dropbox_Mirror; then
    echo "RClone connection to Dropbox_Mirror is working as expected";
else
    echo "RClone connection to Dropbox_Mirror is not working!";
    exit 255;
fi

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
    # --archive         : Basically copies the files and subdirs in archive mode, i.e. preserving perms, etc.
    # --one-file-system : Prevent moving across different FS types, i.e. if an NTFS partition is mounted at the $source, and the current FS is Ext4, do not look at the NTFS partition
    # --info=progress2  : Provides a progress log to show you what is happening
    # The trailing slash at the end of `$source` is important, as it prevents a folder with the $source's name from being created on the $target
    rsync --archive --update --delete --one-file-system --no-prune-empty-dirs --info=progress2 --exclude=".*" --exclude="Skydiving" --exclude=".dropbox" --exclude="~*" $source/ $target;

    # RClone has a nice little known bug; it does not sync empty directories from the $source to the $target
    # Only workaround is to create some non-empty files in the directories, to get them to sync
    if rclone sync --stats=10s --stats-log-level=NOTICE $target remote:Dropbox_Mirror; then
        echo
        echo "Completed RClone sync to remote:Dropbox_Mirror";
        echo
    fi
done
