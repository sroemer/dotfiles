# dotfiles

## A git repository to keep track of my configurations, scripts, etc.

#### What is a bare git repository and why to use it for 'dotfiles'?

The default way of working with a git repository is having a directory which contains
the work tree (the files you work on and keep track of) and an additional .git directory
in which git stores its data.

A bare repository essentially consists of **only** the contents of this .git directory.
For working with such a bare repository you need to setup a work tree separate from it.

The nice thing about using a bare repository for 'dotfiles' is that $HOME directly can be
used as the work tree while the repository can be located wherever wanted.

I use $HOME/Git/sroemer/dotfiles/ for the 'dotfiles' repository and set the work tree to
$HOME. The git parameters --git-dir and --work-tree are used for that.

For comfort and usability my configurations contain some magic dust:

1.) There is an alias 'dotfiles' defined in my `.gitconfig` file:
```gitconfig
[alias]
    dotfiles = !git --git-dir=$HOME/Git/sroemer/dotfiles/ --work-tree=$HOME
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

Some parts of this repository have their own licensing conditions. This notably is the case for:

1. The fonts located in .local/share/fonts (see separate LICENSE files within this directory)
2. The 'Vim plugin manager' located in .local/share/nvim/site/autoload/ uses the
   ['MIT'](./.local/share/nvim/site/autoload/VIM-PLUG-LICENSE) license

I doubt that a license for dotfiles really is needed, but anyway to be clear about it:
The general license for my dotfiles repository is the 'BSD Zero Clause License' as shown below:

```
BSD Zero Clause License

Copyright (c) 2022 Stefan Römer

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
```
