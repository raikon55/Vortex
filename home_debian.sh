#!/bin/bash

###############################
#   Criado por Eduardo Lopes  #
#   edufelopes@gmail.com      #
###############################

#####################################
#   Configuração de usuário da      #
#   distribuição GNU/Linux Debian   #
#####################################

## Mover os arquivos de configuração para seus devidos lugares
conf()
{
  local _conf_files _antigo _rc _novo
  _conf_files="$PWD/Debian/config"
  
  mkdir -p "$HOME/.local/share" "$HOME/.config"
  
  # Mover os arquivos de configuração para os locais certos
  ls "$_conf_files" | grep -E "rc" | while read _rc ;
  do
    mv "$_conf_files/$_rc" "$HOME/.${_rc}"
  done
  
  mv "$_conf_files/vim" "$HOME/.vim" && mkdir -p "$HOME/.vim/temp"
  mv "$PWD/$_conf_files/firewall_netfilter.sh" "$HOME/.local/share"
  
  # Ler os arquivos conky no diretorio, renomea-los e move-los para a home
  ls $PWD | grep -E "Conky" | while read _antigo ;
  do
    _novo=$(echo .${_antigo} | tr 'A-Z' 'a-z')
    mv "$PWD/$_antigo" "$HOME/$_novo"
  done
}

eclipse()
{
  local _link _versao _nome
  # Pegar a versão mais recente do eclipse
  _link="eclipse.c3sl.ufpr.br/technology/epp/downloads/release"
  [[ $(curl -s "$_link") =~ 20[0-9]{2}-[0-9]{2} ]] && _versao=$BASH_REMATCH
  _nome="eclipse-cpp-$_versao-linux-gtk-$(arch).tar.gz"
  
  # Baixar e instalar o eclipse em $HOME/Documentos
  curl -s --connect-timeout 15 --output "$NOME" "$_link/$_versao/R/$_nome"
  mkdir -p "$HOME/Documentos/Eclipse"
  tar -zxf "$_nome" -C "$HOME/Documentos/Eclipse"
}

if [[ "$EUID" -eq 0 ]];
then
  printf "Não execute este script como root..."
  exit 1
else
  printf %b "Configurando a home do $USER"
  conf && eclipse
fi
