#!/bin/bash

dateCmd=$(date --iso-8601=seconds)
declare -a filenames=("/home/dipack/.zshrc" "/home/dipack/.bashrc" "/home/dipack/.vimrc")
for addFile in "${filenames[@]}"
do 
    echo "Adding ${addFile} to git repo"
    cp -Rv $addFile /home/dipack/Dotfiles
    #echo "$currFileName"
    currFileName=${addFile//\/home\/dipack\/} 
    git add "$currFileName" 
done
git commit -am "Synced on $dateCmd"
git push -u origin master
echo "Finished syncing with remote repository"
