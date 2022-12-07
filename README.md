# dotfiles

## A git repository to keep track of my configurations, scripts, etc.

#### What is a bare git repository and why to use it for 'dotfiles'?

The default way of working with a git repository is having a directory which contains
the work tree (the files you work on and keep track of) and an additional `.git` directory
in which git stores its data.

A bare repository essentially consists of **only** the contents of this `.git` directory.
For working with such a bare repository you need to setup a work tree separate from it.

The nice thing about using a bare repository for 'dotfiles' is that `$HOME` directly can be
used as the work tree while the repository can be located wherever wanted.

I use `$HOME/Git/sroemer/dotfiles/` for the 'dotfiles' repository and set the work tree to
`$HOME`. The git parameters `--git-dir` and `--work-tree` are used for that.

For comfort and usability my configurations contain some magic dust:

1.) There is an alias `dotfiles` defined in my `.gitconfig` file:
```
[alias]
    dotfiles = !git --git-dir=$HOME/Git/sroemer/dotfiles/ --work-tree=$HOME
```

2.) A wrapper function in my `.bashrc` automatically selects the right git call.
```
# automatically use git dotfiles alias in home directory
git() {
    if [[ "$PWD" == "$HOME" ]]; then
        /usr/bin/git dotfiles "$@"
    else
        /usr/bin/git "$@"
    fi
}
```
