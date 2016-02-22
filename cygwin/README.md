# Cygwin

## Cygwin for Google Cloud, CoreOS-Vagrant and not directly Kubernetes
You can't use Kubernetes via Cygwin for now. Gcloud is available but not kubectl. **Cygwin is used for rsync to sync vagrant CoreOS folders**. Install Cygwin with rsync for CoreOS-vagrant and Go to [coreos-vagrant](https://github.com/tdeheurles/coreos-vagrant) project for Kubernetes.
Personally I use Cygwin for Oh-My-Zsh instead of cmd.exe. The same commands become available inside and outside containers.


## Installation
- First [download](https://www.cygwin.com/), I have used x86 for this tutorial.
- Then install. When it ask for internet / server, you just accept.
- shoes this **Packages** (and other if you want) : `tree (utils), openssh (net), rsync (net), zsh (shells), curl (net), wget (Web), git (Devel), ncurses (Utils), vi, nano`.


### Oh-My-Zsh && apt-cyg
Oh-My-Zsh is a booster for CLI. It gives lots of usefull shortcut and ui. You can skip but it will simplify your life.
To be installed with cygwin installer (just rerun installer to update) :
- zsh
- wget
- git

[install](https://github.com/haithembelhaj/oh-my-cygwin) with
```bash
wget --no-check-certificate https://raw.github.com/haithembelhaj/oh-my-cygwin/master/oh-my-cygwin.sh -O - | sh
```

We have to change Cygwin default shell. I just had zsh at the end of my `.bashrc` that is in `/c/cygwin/home/username/`. It will run bash and then a zsh. Should be a better way for Cygwin.

Finally reload .bashrc with `exec -l $SHELL`.

Some Oh-My-Zsh shortcut :
```bash
gst              # git status
gaa              # git add --all
gcmsg "blabla"   # git commit -m "blabla"
gl               # git pull
gp               # git push
```

There is lots of plugin for most of the tools. Look [here](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins). For [git](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh)



### rc files
In linux, rcfiles are a config files for terminals. When the terminal start, it execute what is in his corresponding rcfile. Bash -> .bashrc, Zsh -> .zshrc.

This files are located in the user folder : `/home/username/`. You can access it in Cygwin with `cd`. (remember that files starting with `.` are hidden (use ls -la to see them))

We use it to add alias (shortcut for commands), functions, configuration, environment variable, etc ...


#### Some alias
alias are shortcut for CLI. Here are some we can use. Just copy past them in your rcfile.
Install with cygwin installer (or update using the same installer file):
- ncurses
- tree
- clear

```bash
# update shell
alias uprc="exec -l $SHELL"

# ls
alias l="ls -lthg --color"
alias la="l -A"

# Affichage
alias ct="clear && pwd && tree"

# Edit .zshrc
alias edz="nano ~/.zshrc"
alias edb="nano ~/.bashrc"

# CoreOS-Vagrant :
  # Go to repository
  alias repo="cd /cygdrive/c/Users/username/repository"

  # Go to the coreOs vagrant, start it and rsync folders
  alias runcore="repo && cd coreos-vagrant && vagrant up && vagrant provision && vagrant rsync-auto"
```



## gcloud (for kubernetes stop here, use the [coreOS-Vagrant project](https://github.com/tdeheurles/coreos-vagrant) instead)
- Install Cygwin (or update using the same installer file). **Search for lynx (web-browser) and remove it**. When the installer ask you to install lynx dependencie for man-db. **Do not select** in order to enable gcloud authentication (if someone know how to disable lynx in gcloud authentication process, let me know)
- Download & Install gcloud sdk with this command `curl https://sdk.cloud.google.com | bash`
- **During process**, installer ask for bashrc file. Give `/bin/zsh` if you install zsh or just press enter otherwise. This process will add this lines to your rcfile :

```bash
       # The next line updates PATH for the Google Cloud SDK.
       source '/home/username/google-cloud-sdk/path.bash.inc'

       # The next line enables bash completion for gcloud.
       source '/home/username/google-cloud-sdk/completion.bash.inc'


       # IF YOU USE ZSH, CHANGE BASH INTO ZSH :
       source '/home/username/google-cloud-sdk/path.zsh.inc'
       source '/home/username/google-cloud-sdk/completion.zsh.inc'
```

- Then you have to login with `gcloud auth login --user-output-enabled=true`. Copy the URL, go to browser, get the token, and give it here. The user-output tag ask to not directly bring to a browser. If lynx is installed, it will open anyway and you should be stuck on the validation time, complaining for javacript.
- Then we have to install components (for kubernetes, gcloud storage, ...) :

    ```bash
    ➜ gcloud components list # to see what is available
    ```

    We need :

    ```bash
    ➜ gcloud components update alpha preview # kubectl is not available for windows
    ```

If you have some trouble, the official page is [here](https://cloud.google.com/sdk/#Quick_Start). Do not install the windows one because `kubectl` is not available for now.
