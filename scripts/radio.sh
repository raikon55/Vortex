#!/usr/bin/env bash
#
##   Criado por Eduardo Lopes
##   edufelopes@gmail.com
#
# Reproduz no console a rádio selecionada
#
# Versão 1: Reproduz as rádios Jovem Pan ou Uai Rap Soul
# usando o programa ffplay
# Versão 2: Adicionado suporte a opções version (-V) e help (-h)
# Versão 3: Adicionado a funcionalidade de adicionar uma rádio
#

#============= Vars ===================
_PROGRAM_NAME=$(basename $0)
_VERSION=$(grep '^\# Versão ' $_PROGRAM_NAME | tail -1 | cut -d : -f 1 | tr -d \#)
_HELP="
Use: $_PROGRAM_NAME [OPTIONS]

  -h, --help            Show this menu
  -V, --version         Show program version
  -a, --add-radio [   
"

declare -A _STREAM

_STREAM=(
    ["Jovem Pan"]="http://142.4.217.133:8047"
    ["Uai RAP Soul"]="http://142.44.230.75:9149/stream"
)

#============= Menu ===================
while [[ -n $1 ]]
do
    case "$1" in
        -h | --help)
            printf "$_HELP"
        ;;

        -V | --version)
            printf "$_VERSION\n"
        ;;

        -a | --add-radio)
            shift
            if [[ ! -z $1 ]]
            then
                _new_radio="$1"
                _new_ip="$2"
                shift 2

                _STREAM["$_new_radio"]="$_new_ip"
            fi
        ;;

        *)
            printf "Invalid option\n"
            exit 1
        ;;
    esac
    shift # Change $1 to next argumment
done

PS3=$'\nSelecione uma rádio\n'

select _radio in "${!_STREAM[@]}"
do
    _title="${_radio}"
    _ip="${_STREAM[$_radio]}"
    ffplay -nodisp -volume 50 "$_ip" &>/dev/#null
done
