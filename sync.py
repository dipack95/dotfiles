#!/usr/bin/env python
import sys
import os
import time
from subprocess import call
# Check if running with python 3 or newer
if sys.version_info[0] != 3:
        print("This script requires Python version 3.x")
        sys.exit(1)

def main():
    filenames = ["/home/dipack/.zshrc", "/home/dipack/.bashrc", "/home/dipack/.vimrc"]
    destination = "/home/dipack/Dotfiles/"

    for tempFile in filenames:
        call(["cp", "-Rv", tempFile, destination])
        addFilename = tempFile.split('/')[-1]
        call(["git", "add", destination + addFilename])
    call(["git", "commit", "-am", "\'" + time.strftime("%c") + "\'"])
    call(["git", "push", "-u", "origin", "master"])
    
    print("Synced with remote repository")

    return

if __name__ == '__main__':
    main()
