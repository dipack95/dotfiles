#!/bin/bash
dateCmd=$(date --iso-8601=seconds)
declare -a filenames=("/home/dipack/.zshrc" "/home/dipack/.bashrc" "/home/dipack/.vimrc")
for addFile in "${filenames[@]}"
do 
    echo "Adding ${addFile} to git repo"
    currFileName=${addFile//\/home\/dipack\/} 
    cp -Rv $addFile /home/dipack/Dotfiles
    echo "$currFileName"
    #git add "$currFileName" 
done
git commit -am "Synced on $dateCmd"
git push -u origin master
