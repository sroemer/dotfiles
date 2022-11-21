#!/bin/bash
# /etc/skel/.bash_profile

# start ssh-agent on login and ensure just one instance is running
SSH_ENV="$XDG_RUNTIME_DIR/ssh-agent.env"
if pgrep -u "$USER" ssh-agent >/dev/null; then
    pkill -u "$USER" ssh-agent >/dev/null
fi
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    ssh-agent -t 1h > "$SSH_ENV"
    # shellcheck source=/dev/null
    source "$SSH_ENV" >/dev/null
fi

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
    # shellcheck source=/dev/null
    . ~/.bashrc
fi

if [[ -d ~/.local/bin ]] ; then
    PATH=~/.local/bin:$PATH
fi
if [[ -d ~/.cargo/bin ]] ; then
    PATH=~/.cargo/bin:$PATH
fi

#if test -z "${XDG_RUNTIME_DIR}"; then
#    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
#    if ! test -d "${XDG_RUNTIME_DIR}"; then
#        mkdir "${XDG_RUNTIME_DIR}"
#        chmod 0700 "${XDG_RUNTIME_DIR}"
#    fi
#fi

if [ "$(tty)" = "/dev/tty1" ] ; then
    exec dbus-launch --exit-with-session sway
fi
