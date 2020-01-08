#!/usr/bin/env bash
#
##   Criado por Eduardo Lopes
##   edufelopes@gmail.com
#
## Script para atualizar os arquivos deste repositório


shopt -s globstar

_REPO=$HOME/Documentos/Projetos/Vortex
_CONFIG=$HOME/.config

_OB=$_CONFIG/openbox
_REDSHIFT=$_CONFIG/redshift.conf
_YOUTUBE=$_CONFIG/youtube-dl
_BASH=$HOME/.bashrc
_NANO=$HOME/.nanorc
_SOURCE_LIST=/etc/apt/sources.list
_PREFERENCES=/etc/apt/preferences

_CP="cp --recursive --update"

for _file in $_OB $_SOURCE_LIST $_PREFERENCES
do
    $_CP $_file $_REPO/Debian/
done

for _file in $_BASH $_NANO $_REDSHIFT $_YOUTUBE
do
    if [[ "$_file" == "$HOME/.bashrc" ]] || [[ "$_file" == "$HOME/.nanorc" ]]
    then
        _new_file=$(echo $_file | sed 's/\.//')
        $_CP $_file $_REPO/Debian/config/${_new_file##*/}
    else
        $_CP $_file $_REPO/Debian/config/
    fi
done

cd $_REPO
git status
