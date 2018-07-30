#!/usr/bin/env bash

#
# Author      : Dipack P Panjabi
# Description : This script is used to watch and mirror a directory to another.
#               It can also be used to do a quick, one-time sync of data from my Dropbox to my Google Drive
#               I use it to mirror my dropbox data to my Google Drive
#

source="$1";
target="$2";
mode="$3";

function main {
    if [ -z $source ] || [ -z $target ]; then
        print_usage;
        exit 1;
    elif [ "$mode" != "one" ] && [ "$mode" != "" ]; then
        print_usage;
        exit 1;
    fi

    echo "Testing RClone connection to Google Drive";
    if rclone -v lsf remote:Dropbox_Mirror &> /dev/null ; then
        echo "RClone connection to Dropbox_Mirror is working as expected";
    else
        echo "RClone connection to Dropbox_Mirror is not working!";
        exit 255;
    fi

    echo
    echo "Mirroring $source to $target";
    echo

    if [ "$mode" = "one" ]; then
        echo "===========================================";
        echo "Mode: One off sync";
        echo "===========================================";
        sync_to_google_drive;
    elif [ -z "$mode" ]; then
        echo "===========================================";
        echo "Mode: Watch and sync";
        echo "===========================================";
        watch_and_sync;
    fi
}

function print_usage {
    echo "This function requires 2-3 arguments";
    echo "Usage: $0 <source> <target> [ <mode> = { 'one' } ]";
    echo "      <mode> == 'one' -> Does a one-time sync of data from <source> to <target>";
    echo "      <mode> == Empty -> Watches and syncs data from <source> to <target>";
}

function sync_to_google_drive {
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
}

function watch_and_sync {
    while inotifywait --recursive --event modify,create,delete $source; do
        sync_to_google_drive;
    done
}

main;
