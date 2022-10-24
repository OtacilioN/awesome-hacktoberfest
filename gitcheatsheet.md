# Git Cheat Sheet
 Git is a [Distributed Version Control System](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control#_distributed_version_control_systems) that helps software developers around the world to store their code by creating versions of it and tracking them. Git also helps in collaborating with other developers and maintaining your code and documenting it for further use. You can Download [Git](https://git-scm.com/downloads) from here.

## Configuring Credentials

`git config --global user.name <your name>`
Configuring your name for all the repositories on the local computer.

`git config --global user.email <your email>`
Configuring your email for all the repositories of the local computer.

`git config user.name`
Displays the current name set for the local computer.

`git config user.email`
Display the current email set for the local computer.

## Basic Commands

`git init`
Initialize a git repository in the current folder.

`git init <folder-name>`
Create an empty folder and initialize a git repository.

`git add <file-name>`
Adds the following file to the staging area.

`git add .`
Adds all the files to the staging area.

`git commit -m "<your-message"`
Commits the staged file of the repository.

`git remote add origin <your-GitHub-repo-link>`
Linking your Local repo to the remote repo.

`git push --set-upstream <remote-branch(origin)> <commit-branch(master)>`
Setting the upstream branch to push the code.

`git push`
Sending the code from local repo to remote repo.

`git clone <your-GitHub-repo-link>`
Creating a new folder and copying the code from remote repo
to your local computer.

`git pull`
Getting the new changes from the remote repo and merging
them with your local repo.

`git status`
It shows the list of all files  that we have changed or needs to be changed .

`git log` 
Gets the history of all commits in reverse chronological order.

## Branches

`git branch <branch-name>`
Creates a new branch with the `<branch-name>`

`git checkout <branch-name>`
Moves the head to the `<branch-name>`

`git checkout -b <branch-name>`
Creates a new branch (if not exists) and checkouts to the created branch
