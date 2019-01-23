#!/bin/bash

###############################
#   Criado por Eduardo Lopes  #
#   edufelopes@gmail.com      #
###############################

#####################################
#   Pos instalação da               #
#   distribuição GNU/Linux Debian   #
#####################################

## Variaveis
APT="apt install -y --no-install-suggests"

## Programas a serem instalados
ESSENCIAL="apt-transport-https network-manager deborphan curl gnupg xorg mtp-tools jmtpfs pulseaudio pavucontrol"
INTERFACE="openbox lxappearance lightdm lightdm-gtk-greeter arc-theme bc compton nitrogen neofetch scrot plank"
FONTES="fonts-cantarell ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-ubuntu-font-family"
PROGRAMAS_BASICOS="htop oxygencursor volumeicon-alsa galculator redshift gthumb vlc kate meld evince freeplane vim conky guake bash-completion compton-conf telegram-desktop"
PROGRAMAS_TERCEIROS="geogebra-classic atom code"
XFCE4="xfce4-notes xfce4-appfinder xfce4-panel xfce4-netload-plugin thunar thunar-volman"
LIBREOFFICE="libreoffice-writer libreoffice-calc --no-install-recommends"
FIREFOX="-t unstable firefox firefox-l10n-pt-br firefox-l10n-en-gb"

## Atualizar repositorios
atualizar()
{
  mv "$PWD/Debian/sources.list" "$PWD/Debian/preferences" "/etc/apt/"
  apt update && apt upgrade -y
}

## Instalar os programas necessários
interface()
{
  $APT "$ESSENCIAL $INTERFACE $FONTES $PROGRAMAS_BASICOS $XFCE4"
  $APT "$LIBREOFFICE"
  $APT "$FIREFOX"
}

## Programas de 3º da source.list
programas_terceiros()
{
  curl -sL "https://static.geogebra.org/linux/office@geogebra.org.gpg.key" | apt-key add -
  curl -sL "https://packages.microsoft.com/keys/microsoft.asc" | apt-key add -
  
  sed -i '16,19s/^#\ /\ /' "/etc/apt/sources.list"
  apt update
  $APT "$PROGRAMAS_TERCEIROS"
}

## Configuração final
confsys()
{
  mv -u "$PWD/icons/" "/usr/share/"
  mv -u "$PWD/fonts/" "/usr/local/share/fonts/"
  fc-cache "/usr/local/share/fonts/"
  
  apt autoremove -y && apt autoclean
  apt list --installed | grep -E lightdm && systemctl enable lightdm
}

if [[ "$EUID" -eq 0 ]];
then
  printf "Iniciando...\n"
  printf "Instalando programas para o funcionamento do sistema\n"
  printf "Esse processo pode demorar alguns minutos\n\n"
  sleep 3
  
  atualizar
  interface
  confsys
else
  printf "Necessita ser root para executar o script.\nAbortando...\n"
  exit
fi

printf "Pós instalação terminada com sucesso"
sync
exit
