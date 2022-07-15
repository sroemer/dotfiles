#!/bin/bash
# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
    # Shell is non-interactive.  Be done now!
    return
fi

# fzf key bindings and completion
FZF_KEY_BINDINGS_FILE=/usr/share/fzf/key-bindings.bash
if [[ -f "$FZF_KEY_BINDINGS_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$FZF_KEY_BINDINGS_FILE"
fi
FZF_COMPLETION_FILE=/usr/share/fzf/completion.bash
if [[ -f "$FZF_COMPLETION_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$FZF_COMPLETION_FILE"
fi

# Put your fun stuff here.
alias l='ls -lh'
alias ll='ls -lh'
alias la='ls -lAh'
alias lh='ls -ldh .*'

alias ..='cd ..'
alias ...='cd ../../'

alias Gs='git status'
alias Ga='git add'
alias Gc='git commit'
alias Gl='git lg'
alias Gd='git difftool'
alias Gdc='git difftool --cached'
alias Gp='git push'

alias mutt='neomutt'
alias vim='nvim'

alias ssh='TERM=xterm ssh'

alias open='xdg-open'

# automatically use git dotfiles alias in home directory
git() {
    if [[ "$PWD" == "$HOME" ]]; then
        /usr/bin/git df "$@"
    else
        /usr/bin/git "$@"
    fi
}

# set PS1 and show git branch
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u \[\033[01;34m\]\w \[\033[01;33m\]$(parse_git_branch) \[\033[01;34m\]\$ \[\033[00m\]'
