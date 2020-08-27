#!/usr/bin/env bash
#
##   Criado por raikon55
##   edufelopes@gmail.com
#
## Script simples para backup em HD externo
## Manterá uma pasta home compactada no HD
#
##

if [[ -d "$1" ]]; then

    _BACKUP_NAME="backup-${1%%/*}-$(date +%d-%m-%Y).tar.xz"
    _BACKUP_DIR="${_BACKUP_NAME%%.*}"

    if [[ ! -f "$_BACKUP_NAME" ]]; then
        mkdir -p "$_BACKUP_DIR"
        rsync --recursive --archive --verbose -zz --perms --times --progress "$1" "$_BACKUP_DIR"
    else
        rsync --recursive --archive --verbose -zz --perms --times --delete --update --progress "$1" "$_BACKUP_DIR"
    fi

    tar --create --file "${_BACKUP_NAME}" --preserve-permissions --xz "${_BACKUP_DIR#*/}"
else
    printf "Informe um diretorio valido"
    exit
fi
