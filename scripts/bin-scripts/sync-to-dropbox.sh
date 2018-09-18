#!/usr/bin/env bash
rsync --archive --update --delete --one-file-system --no-prune-empty-dirs --info=progress2 ~/projects/college/ ~/Dropbox/College/UB/fall_2018 --exclude="wayfarer" --exclude="project-1.2" "$@"
