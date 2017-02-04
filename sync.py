#!/usr/bin/env python3
import re
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
        toBeAdded = tempFile.split('/')[-1]
        if(toBeAdded[0] == '.'):
            toBeAdded = toBeAdded[1:]
            call(["cp", "-R", tempFile, directory + "/" + toBeAdded])
        else:
            call(["cp", "-R", tempFile, directory])
        call(["git", "add", toBeAdded])
    return 1

def cleanUp(directory, filenames):
    currDir = os.getcwd()
    os.chdir(directory)
    for tempFile in filenames:
        toBeDeleted = tempFile.split('/')[-1]
        if(os.path.isfile(toBeDeleted) and os.path.exists(toBeDeleted) and os.path.exists(tempFile)):
            os.remove(toBeDeleted)
        elif(os.path.isdir(toBeDeleted) and os.path.exists(toBeDeleted) and os.path.exists(tempFile)): shutil.rmtree(toBeDeleted)
    os.chdir(currDir)
    return 1

def main():
    # This section picks up the file names from the provided manifest file.
    filenames = []
    manifestFile = sys.argv[1] if len(sys.argv) >= 2 else './manifest.txt'
    if not os.path.isfile(manifestFile):
        print("Manifest file {} does not exist!".format(manifestFile))
        sys.exit(1)
    # Here, we check if the line read from the manifest is a comment or an actual filename
    # Comments start with an '#'
    commentRegex = re.compile("^\#.*\s$")
    with open('./manifest.txt') as manifest:
        for line in manifest:
            if not commentRegex.match(line):
                filenames.append(line.rstrip('\n'))
    # All the environment variable in the file paths are expanded
    filenames = [os.path.expandvars(tempFile) for tempFile in filenames]
    # The git directory is completely cleaned up to avoid any conflicts while copying/committing.
    if cleanUp(os.getcwd(), filenames):
        print("Cleaned up current directory.")
    else:
        print("Failed to clean up current directory.")
        sys.exit(1)
    # The files are then added/staged in the git repo
    if (addToRepo(os.getcwd(), filenames)):
        print("Copied from source location to current directory, and added to git repo.")
    else:
        print("Failed to copy from source location, and add to git repo.")
        sys.exit(1)
    # Simple git commit, and push combo
    call(["git", "commit", "-am", "\'" + time.strftime("%c") + "\'"])
    call(["git", "push", "-u", "--quiet", "origin", "master"])
    print("Synced with remote repository")
    sys.exit(0)

if __name__ == '__main__':
    main()

