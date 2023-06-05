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

# bash history: do not save duplicates and ignore commands starting with space
HISTCONTROL=ignorespace:ignoredups:erasedups
# bash history: max. 5000 entries
HISTSIZE=5000
# bash history: append to history instead of overwriting it
shopt -s histappend

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
RUSTUP_COMPLETION_FILE=$HOME/.local/share/bash-completion/completions/rustup
if [[ -f "$RUSTUP_COMPLETION_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$RUSTUP_COMPLETION_FILE"
fi
CARGO_COMPLETION_FILE=$HOME/.local/share/bash-completion/completions/cargo
if [[ -f "$CARGO_COMPLETION_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$CARGO_COMPLETION_FILE"
fi

# Put your fun stuff here.
alias ls='ls --color=auto'
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
alias Gla='git lga'
alias Gd='git difftool'
alias Gdc='git difftool --cached'
alias Gf='git fetch'
alias Gp='git push'
alias Gpl='git pull'

alias mutt='neomutt'
alias vim='nvim'

alias ssh='TERM=xterm ssh'

alias open='xdg-open'

alias :q='exit'

# automatically use git dotfiles alias in home directory
git() {
    if [[ "$PWD" == "$HOME" ]]; then
        /usr/bin/git dotfiles "$@"
    else
        /usr/bin/git "$@"
    fi
}

# set PS1 and show git branch if we are not in a tty session
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
if [[ "$XDG_SESSION_TYPE" != "tty" ]]; then
    export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]  \u \[\033[01;34m\] \w \[\033[01;33m\]$(parse_git_branch) \[\033[01;34m\]\$ \[\033[00m\]'
fi

# set tty to use for gnupg
GPG_TTY=$(tty)
export GPG_TTY
