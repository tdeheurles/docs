# Some Git Tricks

## PR

git checkout -b feature/feature1
git push -u origin feature/feature1
git checkout -b feature/feature2


## Short version
Permissions :  

```
git update-index --chmod=+x script.sh
```

Prepare OS :  

```
git config --global core.eol lf
git config --global core.autocrlf false
```

Remove CRLF :  

```
git rm --cached -r .
git reset --hard
git add .
git commit -m "Normalize all the line endings"
```

## CF / CLRF

Good [tutorial](git config --global core.autocrlf true) for the CF/CLRF problem that can occure from switching OS.

```bash
git config --global core.autocrlf false
```

```bash
# Set the default behavior, in case people don't have core.autocrlf set.
* text=auto

# Explicitly declare text files you want to always be normalized and converted
# to native line endings on checkout.
*.c text
*.h text

# Declare files that will always have CRLF line endings on checkout.
*.sln text eol=crlf

# Denote all files that are truly binary and should not be modified.
*.png binary
*.jpg binary
```


Save your current files in Git, so that none of your work is lost.

```bash
git add . -u
git commit -m "Saving files before refreshing line endings"
```

Remove every file from Git's index.

```bash
git rm --cached -r .
```

Rewrite the Git index to pick up all the new line endings.

```bash
git reset --hard
```

Add all your changed files back, and prepare them for a commit. This is your chance to inspect which files, if any, were unchanged.

```bash
git add .
# It is perfectly safe to see a lot of messages here that read
# "warning: CRLF will be replaced by LF in file."
```

Commit the changes to your repository.

```bash
git commit -m "Normalize all the line endings"
```



Other guide, for code will work on linux :
```bash
# The proper way to get LF endings in Windows is to first set core.autocrlf to false:
git config --global core.autocrlf false

# You need to do this if you are using msysgit, because it sets it to true in its system settings.

# Now git won’t do any line ending normalization. If you want files you check in to be normalized, do this: Set text=auto in your .gitattributes for all files:
cat <<EOF >> .gitattributes
* text=auto
EOF

#And set core.eol to lf:
git config --global core.eol lf

# Now you can also switch single repos to crlf (in the working directory!) by running
# git config core.eol crlf

# After you have done the configuration, you might want git to normalize all the files in the repo. To do this, go to to the root of your repo and run these commands:
git rm --cached -rf .
git diff --cached --name-only -z | xargs -n 50 -0 git add -f

# If you now want git to also normalize the files in your working directory, run these commands:
git ls-files -z | xargs -0 rm
git checkout .
```

## Permissions
```
How to change file premissions in Git on Windows
Git manages file permissions for each file in the repository. It may be appropriate to have the executable bit set for shell/bash files to make them easier to execute in Linux systems.

Windows own file permissions does not map to the Git file permissions so it may be a bit hard to change file permissions when you are on Windows. This is how you do it:

Lets assume the file script.sh needs to have the executable bit set. Use the command git ls-tree to inspect the file permissions:
C:\views\myproject>git ls-tree HEAD
100644 blob 55c0287d4ef21f15b97eb1f107451b88b479bffe    script.sh

As you can see the file has 644 permission (ignoring the 100). We would like to change it to 755:
C:\views\myproject>git update-index --chmod=+x script.sh

C:\views\myproject>git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   script.sh
#

The file is now staged. Note that the file contents is not changed, only the meta data. We must commit the file so save the change:
C:\views\myproject>git commit -m "Changing file permissions"
[master 77b171e] Changing file permissions
0 files changed, 0 insertions(+), 0 deletions(-)
mode change 100644 => 100755 script.sh

Running git ls-tree again to see the change:
C:\views\myproject>git ls-tree HEAD
100755 blob 55c0287d4ef21f15b97eb1f107451b88b479bffe    script.sh
```
