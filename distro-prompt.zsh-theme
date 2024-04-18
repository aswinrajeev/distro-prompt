#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# 
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[yellow]%}(%{$fg[yellow]%}%{$fg[green]%} %b%{$fg[yellow]%})%{$reset_color%}"

OS=$(uname -or)

case $OS in
    *Darwin*) ICON="" ;;
    *Android*) ICON="" ;;
    *microsoft*) ICON="" ;;
    *BSD*) 
      DISTRO=$(uname -s)
      case $DISTRO in
        *FreeBSD*) ICON="" ;;
        *OpenBSD*) ICON="" ;;
      esac
    ;;
    *Linux*) 
      DISTRO=$(awk -F= '/^ID=/ {print $2}' /etc/os-release 2> /dev/null | sed 's/"//g')
      case $DISTRO in
        arch|archarm) ICON="" ;;
        void) ICON="" ;;
        centos) ICON="" ;;
        ubuntu) ICON="" ;;
        fedora) ICON="" ;;
        alpine) ICON="" ;;
        artix) ICON="" ;;
        gentoo) ICON="" ;;
        debian) ICON="" ;;
        linuxmint) ICON="" ;;
        manjaro) ICON="" ;;
        pop) ICON="" ;;
        parrot) ICON="" ;;
        kali) ICON="" ;;
        guix) ICON="" ;;
        nixos) ICON="" ;;
        endeavouros) ICON="" ;;
        deepin) ICON="" ;;
        archlabs) ICON="" ;;
        almalinux) ICON="" ;;
        raspbian) ICON="" ;;
        rhel) ICON="" ;;
        slackware) ICON="" ;;
        zorin) ICON="" ;;
        elementary) ICON="" ;;
        solus) ICON="" ;;
        rocky) ICON="" ;;
        opensuse*) ICON="" ;;
        *) ICON="" ;;
      esac
      ;;
    *) ICON="" ;;
esac


PROMPT="%B%{$fg[grey]%} $ICON % %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[white]%}%c%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "
ROMPT+="\$vcs_info_msg_0_ "
