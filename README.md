# dotfiles

A git repository to keep track of my configurations, scripts, etc.



#### What is a bare git repository and why to use it for 'dotfiles'?

The default way of working with a git repository is having a directory which contains
the work tree (the files you work on and keep track of) and an additional .git directory
in which git stores its data.

A bare repository essentially consists of **only** the contents of this .git directory.
For working with such a bare repository you need to setup a work tree separate from it.

The nice thing about using a bare repository for 'dotfiles' is that $HOME directly can be
used as the work tree while the repository can be located wherever wanted.

I use $HOME/Git/sroemer/dotfiles.bare/ for the 'dotfiles' repository and set the work tree to
$HOME. The git parameters --git-dir and --work-tree are used for that.

For cloning the repository and setting up the configurations I call following commands from
the home directory:
```
git clone --bare git@github.com:sroemer/dotfiles.git $HOME/Git/sroemer/dotfiles.bare
git --git-dir=$HOME/Git/sroemer/dotfiles.bare config --local status.showUntrackedFiles no
git --git-dir=$HOME/Git/sroemer/dotfiles.bare/ --work-tree=$HOME checkout
```

For comfort and usability my configurations contain some magic dust:

1.) There is an alias 'dotfiles' defined in my `.gitconfig` file:
```gitconfig
[alias]
    dotfiles = !git --git-dir=$HOME/Git/sroemer/dotfiles.bare/ --work-tree=$HOME
```

2.) A wrapper function in my `.bashrc` automatically selects the right git call.
```bash
# automatically use git dotfiles alias in home directory
git() {
    if [[ "$PWD" == "$HOME" ]]; then
        /usr/bin/git dotfiles "$@"
    else
        /usr/bin/git "$@"
    fi
}
```

#### License

Unless otherwise stated the licensable work in my dotfiles repository - if there is any - uses
the '[BSD Zero Clause License](LICENSE)'.

Some parts of this repository are not my own work and have their own licensing conditions.
In this cases a separate license file is included. This notably is the case for:

1. The fonts located in .local/share/fonts (see separate LICENSE files within the [directory](./.local/share/fonts/))
2. The 'Vim plugin manager' located in .local/share/nvim/site/autoload/ uses the
   ['MIT License'](./.local/share/nvim/site/autoload/VIM-PLUG-LICENSE)
