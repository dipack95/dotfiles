#!/usr/bin/env python
import sys
import os
import time
from subprocess import call
# Check if running with python 3 or newer
if sys.version_info[0] != 3:
        print("This script requires Python version 3.x")
        sys.exit(1)

def addToRepo(directory, filenames):
    currDir = os.getcwd()
    os.chdir(directory)
    for tempFile in filenames:
        call(["cp", "-Rv", tempFile, directory])
        toBeAdded = tempFile.split('/')[-1]
        call(["git", "add", directory + "/" + toBeAdded])
    return 1

def cleanUp(directory, filenames):
    currDir = os.getcwd()
    os.chdir(directory)
    for tempFile in filenames:
        toBeDeleted = tempFile.split('/')[-1]
        if call(["rm", "-rf", toBeDeleted]):
            os.chdir(currDir)
            return 0
    os.chdir(currDir)
    return 1

def main():
    filenames = ["/home/dipack/.zshrc", 
   			"/home/dipack/zshfiles",
    			"/home/dipack/.vimrc", 
                        "/home/dipack/vimfiles",
    			"/home/dipack/.bashrc", 
    			"/home/dipack/scripts"] 
    addToRepo(os.getcwd(), filenames)
    call(["git", "commit", "-am", "\'" + time.strftime("%c") + "\'"])
    call(["git", "push", "-u", "--quiet", "origin", "master"])
    print("Synced with remote repository")
    if cleanUp(os.getcwd(), filenames):
        print("Cleaned up!")
    else:
        print("Failed to clean up!")
    return

if __name__ == '__main__':
    main()
