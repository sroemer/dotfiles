# dotfiles

A git repository to synchronize and keep track of my configurations, scripts, etc.



#### How do I use it?

While in the past the repository was intended to be used as a bare git repository I
switched to using a regular repository directly within my home directory. The main
reason for the switch was git-crypt not working with my previous approach.

For setting up a new machine, I run the following commands in my home directory:
```
git clone git@github.com:sroemer/dotfiles.git .
git config --local status.showUntrackedFiles no
git-crypt unlock
```

The call of `git-crypt unlock` requires my private gpg key which is only on my
Yubikey and stored at a safe place guarded by Orcs - good luck with that ;)



#### What is git-crypt and why to use it for 'dotfiles'?

When keeping track of configuration files and scripts in a git repository
sooner or later you will find yourself in a situation where you also would
like to synchronize some kind of sensitive information.

This could be API keys, passwords or keys that obviously shouldn't be shared
publicly. In my case the primary usecase is to hide my email address from
robots crawling around for collecting it and sending spam.

[git-crypt](https://github.com/AGWA/git-crypt) allows you to selectively
choose files to protect. Those files then will be encrypted when commited
and decrypted when checked out.



#### License

Unless otherwise stated the licensable work in my dotfiles repository - if there is any - uses
the '[BSD Zero Clause License](LICENSE)'.

Some parts of this repository are not my own work and have their own licensing conditions.
In this cases a separate license file is included. This notably is the case for:

1. The fonts located in .local/share/fonts (see separate LICENSE files within the [directory](./.local/share/fonts/))
2. The 'Vim plugin manager' located in .local/share/nvim/site/autoload/ uses the
   ['MIT License'](./.local/share/nvim/site/autoload/VIM-PLUG-LICENSE)
