# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

if [[ -d ~/.local/bin ]] ; then
	PATH=~/.local/bin:$PATH
fi
if [[ -d ~/.cargo/bin ]] ; then
	PATH=~/.cargo/bin:$PATH
fi

#if test -z "${XDG_RUNTIME_DIR}"; then
#	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
#	if ! test -d "${XDG_RUNTIME_DIR}"; then
#		mkdir "${XDG_RUNTIME_DIR}"
#		chmod 0700 "${XDG_RUNTIME_DIR}"
#	fi
#fi

if [ "$(tty)" = "/dev/tty1" ] ; then
	exec sway
fi
