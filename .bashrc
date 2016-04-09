# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) # for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@salamanderCoals: \W $ '
fi
unset color_prompt force_color_prompt

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\]\u@\h\[\033[01;32m\] \W\[\033[00;33m\]$(__git_ps1)\[\033[01;32m\] \$\[\033[00m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Don't use until you know you only get what you're looking for.
#function grepkill {
#    ps aux | grep $1 ; kill -0 `ps aux | grep $1 | cut -d' ' -f5`
#}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ..='cd .. ; pwd; ls'
    alias ...='cd ../..; pwd; ls'
    alias ....='cd ../../..; pwd; ls'
    alias caedm='ssh bpl5@ssh.et.byu.edu'
    alias magic='ssh magiccvs'
    alias clr='clear'
    alias topmem="ps aux | awk '{print \$2, \$4, \$11}' | sort -k2rn | head -n 10 | column -t"
function watchmem() {
    watch -n 0.1 "ps aux | awk '{print \$2, \$4, \$11}' | sort -k2rn | head -n 10 | column -t"
# | sort -k2rn | head -n 10 | column -t
}
    alias watchmem=watchmem #'watch -n 0.1 '\''ps aux | awk "{print $2, $4, $11}"'\'''
#| awk '"'"'{print $2, $4, $11}'"'"' | sort -k2rn | head -n 10 | column -t'
    alias sl='sl -e'
    alias tilde='find . -name "*~" -type f -delete'
    alias gitilde='git rm -rf *~'
    alias matlab_root='cd /usr/local/MATLAB/R2014a'
    alias test='echo $1 '
    alias dictAdd='echo '$1' >> /usr/share/myspell/dicts/en_GB.dic'
    alias ldiff='latexdiff -t CTRADITIONAL '$1' '$2' > diff.tex'
    alias cvsource='cd /usr/include/opencv2'
# >> /usr/share/myspell/dicts/test"
#    alias
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

source /opt/ros/indigo/setup.bash
#source ~/catkin_ws/devel/setup.bash
#source ~/sim_ws/devel/setup.bash
source ~/joy_magicc_ws/devel/setup.bash
export EDITOR='subl'

export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
export HISTFILESIZE=
export HISTSIZE=

export HISTFILE=~/.bash_eternal_history

~/.scripts/clean_bash_history

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

PERL_MB_OPT="--install_base \"/home/lewis/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lewis/perl5"; export PERL_MM_OPT;

export PATH=$PATH:/usr/bin/gcc-arm-none-eabi-4_7-2014q2/bin
export ROS_HOSTNAME=localhost
export ROS_MASTER_URI=http://localhost:11311
export PATH=/opt/gcc-arm-none-eabi-4_7-2014q2/bin:$PATH

export LD_LIBRARY_PATH=/usr/local/cuda-7.0/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda-6.5/lib64:$LD_LIBRARY_PATH

export PATH="$PATH:/usr/local/cuda-6.5/bin"
export GAZEBO_MODEL_DATABASE_URI=http://old.gazebosim.org/models

rmTrash() {
    if [ "$#" -eq 0 ]; then
        echo "Can't rm with no args"
        return
    fi
 # ls "$@"
    cp -r --backup=t "$@" $HOME/.local/share/Trash/files
    rm "$@"
}

alias rmv=rmTrash
