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
ERRO="printf %b 'Ops...\nAlgo não saiu como esperado\n'"

## Programas a serem instalados
ESSENCIAL="xorg mtp-tools jmtpfs pulseaudio pavucontrol"
INTERFACE="openbox thunar thunar-volman lxappearance lightdm lightdm-gtk-greeter arc-theme bc compton nitrogen neofetch plank"
FONTES="ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-ubuntu-font-family"
PROGRAMAS_BASICOS="kate meld evince atom freeplane vim conky guake bash-completion compton-conf telegram-desktop geogebra-classic"
XFCE4="xfce4-notes xfce4-appfinder"
LIBREOFFICE="libreoffice-writer libreoffice-calc --no-install-recommends"
FIREFOX="-t unstable firefox firefox-l10n-pt-br firefox-l10n-en-gb"

## Atualizar repositorios
atualizar()
{
    mv "$PWD/Debian/sources.list" "$PWD/Debian/preferences" "/etc/apt/"

    apt update && apt upgrade -y
    apt install apt-transport-https deborphan curl gnupg -y
    curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add
    curl -sL https://static.geogebra.org/linux/office@geogebra.org.gpg.key | apt-key add
}

## Instalar básico
essencial()
{
    $APT $ESSENCIAL

	if [[ $?  -eq "0" ]];
    then
        sleep 1
   	else
       	$ERRO
       	exit 1
   	fi
}

## Instalar Openbox
interface()
{
	$APT $INTERFACE

	if [[ $? -eq "0" ]];
    then
        sleep 1
   	else
       	$ERRO
       	exit 1
   	fi
}

## Instalar fontes
fontes()
{
    $APT $FONTES

    if [[ $? -eq "0" ]];
    then
        sleep 1
	else
    	$ERRO
    	exit 1
	fi
}

## Instalar programas
programas()
{
    $APT $PROGRAMAS_BASICOS
    $APT $XFCE4
    $APT $LIBREOFFICE
    $APT $FIREFOX

	if [[ $? -eq "0" ]];
    then
		sleep 1
    else
        $ERRO
        exit 1
    fi
}

## Configuração final
confsys()
{
    mv -u "$PWD/icons/*" "/usr/share/icons/"
    mv -u "$PWD/fonts/*" "/usr/share/fonts/"
    fc-cache "/usr/share/fonts/"

    apt autoremove && apt autoclean
	apt list --installed | egrep lightdm && systemctl enable lightdm
    apt update && apt install -f
}

if [[ "$EUID" -eq 0 ]];
then
    printf "Iniciando...\n"
    sleep 3
    printf %b "Instalando programas para o funcionamento do sistema
            Esse processo pode demorar alguns minutos\n"
    (
        atualizar
        essencial
        interface
        fontes
        programas
        confsys
    ) 2>pos_debian.log 1>/dev/null
else
    printf %b "Necessita ser root para executar o script.\nAbortando..."
    exit
fi

printf %b "Pós instalação terminada com sucesso"
sync
exit
