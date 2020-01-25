#!/usr/bin/env bash
#
##   Criado por Eduardo Lopes
##   edufelopes@gmail.com
#
#
## Pos instalação da distribuição GNU/Linux Debian. O script:
## * Instala os programas utilizados pelo usuário
## * Configura as fontes e os icones do sistema 
#

## Variaveis
APT="apt install -y --no-install-suggests"

## Programas a serem instalados
ESSENCIAL="apt-transport-https network-manager curl gnupg xorg mtp-tools \
 jmtpfs pulseaudio pavucontrol bluetooth gdb gcc g++ make"

INTERFACE="openbox lxappearance lightdm lightdm-gtk-greeter arc-theme bc \
 compton nitrogen neofetch scrot plank arandr"

FONTES="fonts-cantarell ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu"

PROGRAMAS_BASICOS="htop chromium volumeicon-alsa galculator redshift \
 gthumb vlc meld evince freeplane conky terminator bash-completion \
 compton-conf telegram-desktop wicd wicd-curses docker.io gvfs-backends \
 keepassxc"

PROGRAMAS_TERCEIROS="geogebra-classic code"

XFCE4="xfce4-notes xfce4-appfinder xfce4-battery-plugin thunar thunar-volman"

LIBREOFFICE="libreoffice-writer libreoffice-calc libreoffice-l10n-pt-br \
 libreoffice-lightproof-pt-br libreoffice-gtk3 --no-install-recommends"

FIREFOX="-t unstable firefox firefox-l10n-pt-br"

atualizar()
{
  mv "$PWD/Debian/sources.list" "$PWD/Debian/preferences" "/etc/apt/"
  apt update && apt upgrade -y
}

interface()
{
  $APT "$ESSENCIAL $INTERFACE $FONTES $PROGRAMAS_BASICOS $XFCE4"
  $APT "$LIBREOFFICE"
  $APT "$FIREFOX"
}

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