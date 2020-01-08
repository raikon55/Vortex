#!/usr/bin/env bash
#
##   Criado por Eduardo Lopes
##   edufelopes@gmail.com
#
## Configuração de usuário da distribuição GNU/Linux Debian. O script:
## * Instala a IDE Eclipse
## * Configura o papel de parede da área de trabalho
## * Configura a home do usuário
#

_CURL="curl -s --connect-timeout 15 --output"

## Mover os arquivos de configuração para seus devidos lugares
conf_home()
{
  local _conf_files _antigo _rc _novo
  _conf_files="$PWD/Debian/config"
  
  # Diretorios existem?
  [[ ! -d "$HOME/.local/share" ]] mkdir -p "$HOME/.local/share"
  [[ ! -d "$HOME/.config" ]] mkdir -p "$HOME/.config" 
  
  for _rc in $(find $_config_files -name "*rc")
  do
    mv "$_rc" "$HOME/.${_rc##*/}"
  done

  mv "$_conf_files/firewall_netfilter.sh" "$HOME/.local/share"
  mv "$_config_files/{redshift.conf,youtube-dl}" "$HOME/.config"

  # Conky1 -> .conky1
  for _antigo in $(find . -name "Conky*")
  do
    _novo=$(echo ."${_antigo##*/}" | tr '[:upper:]' '[:lower:]')
    mv "$PWD/$_antigo" "$HOME/$_novo"
  done
}

set_wallpaper()
{
  local _wallpaper="https://memeworld.funnyjunk.com/comments/I+have+like+500+or+more+wallpapers+in+my+wg+_cfeaa5d8714f2385d56d1562d016130a.jpg"

  $_CURL "$HOME/Imagens/wallpaper.jpg" "$_wallpaper"
  nitrogen --set-auto "$HOME/Imagens/wallpaper.jpg"
}

install_eclipse()
{
  local _link _versao _nome
  # Pegar a versão mais recente do eclipse
  _link="eclipse.c3sl.ufpr.br/technology/epp/downloads/release"
  [[ $(curl -s "$_link") =~ 20[0-9]{2}-[0-9]{2} ]] && _versao="$BASH_REMATCH"
  _nome="eclipse-cpp-$_versao-linux-gtk-$(arch).tar.gz"
  
  # Baixar e instalar o eclipse em $HOME/Documentos
  $_CURL "$_nome" "$_link/$_versao/R/$_nome"
  [[ ! -d "$HOME/Documentos/Eclipse" ]] && mkdir -p "$HOME/Documentos/Eclipse"
  tar --gunzip --extract --file="$_nome" --directory="$HOME/Documentos/Eclipse"
}

if [[ "$EUID" -eq 0 ]];
then
  printf "Não execute este script como root..."
  exit 1
else
  printf %b "Configurando a home do $USER"
  conf_home
  set_wallpaper
  install_eclipse
fi
