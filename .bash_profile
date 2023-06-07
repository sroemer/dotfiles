#!/bin/bash
# /etc/skel/.bash_profile

# set and create XDG_RUNTIME_DIR if needed
if [[ -z "${XDG_RUNTIME_DIR}" ]]; then
    export XDG_RUNTIME_DIR="/tmp/xdg-runtime-dir-${UID}"
    if ! [[ -d "${XDG_RUNTIME_DIR}" ]]; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

# start gpg-agent on login (replacing ssh-agent)
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export SSH_AUTH_SOCK
gpgconf --launch gpg-agent

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
    # shellcheck source=/dev/null
    . ~/.bashrc
fi

# extend path with local bin directories
if [[ -d ~/.local/nodejs/bin ]] ; then
    PATH=~/.local/nodejs/bin:$PATH
fi
if [[ -d ~/.cargo/bin ]] ; then
    PATH=~/.cargo/bin:$PATH
fi
if [[ -d ~/.local/bin/appimages ]] ; then
    PATH=~/.local/bin/appimages:$PATH
fi
if [[ -d ~/.local/bin ]] ; then
    PATH=~/.local/bin:$PATH
fi

# use input method 'ibus'
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# start sway if we are running on first terminal
if [ "$(tty)" = "/dev/tty1" ] ; then
    exec dbus-launch --exit-with-session sway
fi
