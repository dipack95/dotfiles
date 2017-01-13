import os
import git
def main():
    repo = git.Repo(os.getcwd())
    filesToAdd = (repo.untracked_files)
    print(filesToAdd)
    print(repo.git.push())

if __name__=='__main__':
    main()
