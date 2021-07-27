# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# start ssh-agent on login and ensure just one instance is running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Put your fun stuff here.
alias l='ls -l'
alias ll='ls -l'
alias la='ls -lA'
alias lh='ls -ld .*'

alias ..='cd ..'
alias ...='cd ../../'

alias gs='git status'
alias ga='git add'
alias gd='git difftool'

alias mutt='neomutt'
alias vim='nvim'

alias ssh='TERM=xterm ssh'

alias open='xdg-open'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u \[\033[01;34m\]\w \[\033[01;33m\]$(parse_git_branch) \[\033[01;34m\]\$ \[\033[00m\]'
