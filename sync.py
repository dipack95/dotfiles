#!/usr/bin/env python3
import sys
import os
import time
import shutil
from subprocess import call
# Check if running with python 3 or newer
if sys.version_info[0] != 3:
        print("This script requires Python version 3.x")
        sys.exit(1)

def addToRepo(directory, filenames):
    currDir = os.getcwd()
    os.chdir(directory)
    for tempFile in filenames:
        # call(["cp", "-Rv", tempFile, directory])
        toBeAdded = tempFile.split('/')[-1]
        if(toBeAdded[0] == '.'):
            toBeAdded = toBeAdded[1:]
            call(["cp", "-R", tempFile, directory + "/" + toBeAdded, "2>", "/dev/null"])
        else:
            call(["cp", "-R", tempFile, directory, "2>", "/dev/null"])
        call(["git", "add", toBeAdded])
    return 1 
def cleanUp(directory, filenames):
    currDir = os.getcwd()
    os.chdir(directory)
    for tempFile in filenames:
        toBeDeleted = tempFile.split('/')[-1]
        if(os.path.isfile(toBeDeleted) and os.path.exists(toBeDeleted) and os.path.exists(tempFile)):
            os.remove(toBeDeleted)
        elif(os.path.isdir(toBeDeleted) and os.path.exists(toBeDeleted) and os.path.exists(tempFile)):
            shutil.rmtree(toBeDeleted)
    os.chdir(currDir)
    return 1

def main():
    filenames = ["$HOME/.zshrc",
            "$HOME/zshfiles",
            "$HOME/.vimrc",
            "$HOME/vimfiles",
            "$HOME/.bashrc",
            "$HOME/scripts",
            "$HOME/misc-fixes"]
    filenames = [os.path.expandvars(tempFile) for tempFile in filenames]
    if cleanUp(os.getcwd(), filenames):
        print("Cleaned up current directory.")
    else:
        print("Failed to clean up current directory.")
        return 0
    if (addToRepo(os.getcwd(), filenames)):
        print("Copied from source location to current directory, and added to git repo.")
    else:
        print("Failed to copy from source location, and add to git repo.")
        return 0
    call(["git", "commit", "-am", "\'" + time.strftime("%c") + "\'"])
    call(["git", "push", "-u", "--quiet", "origin", "master"])
    print("Synced with remote repository")
    return 1

if __name__ == '__main__':
    main()
