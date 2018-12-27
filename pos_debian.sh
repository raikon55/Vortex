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
LOG_ERR="2>pos_debian.log 1>/dev/null"

## Atualizar repositorios
atualizar()
{
    mv "$PWD/Debian/sources.list" "$PWD/Debian/preferences" "/etc/apt/"

    # Subshell
    (
        apt update && apt upgrade -y
        apt install deborphan curl gnupg -y
        curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add $LOG_ERR
        curl -sL https://static.geogebra.org/linux/office@geogebra.org.gpg.key | apt-key add $LOG_ERR
    ) &>/dev/null

    essencial
    return 0
}

## Instalar básico
essencial()
{

    $APT xorg mtp-tools jmtpfs pulseaudio pavucontrol $LOG_ERR
	if [[ $?  -eq "0" ]];
    then
		printf %b "Xorg, drivers de video e pulseaudio instalados"
        sleep 1
        interface
   	else
       	$ERRO
       	exit 1
   	fi
}

## Instalar Openbox
interface()
{

	$APT openbox thunar thunar-volman lxappearance lightdm lightdm-gtk-greeter arc-theme bc compton nitrogen neofetch plank $LOG_ERR
	if [[ $? -eq "0" ]];
    then
		printf %b "Interface gráfica instalada\n"
        sleep 1
        fontes
   	else
       	$ERRO
       	exit 1
   	fi
}

## Instalar fontes
fontes()
{

    $APT ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-ubuntu-font-family $LOG_ERR
    if [[ $? -eq "0" ]];
    then
   		printf %b "Fontes instaladas"
        sleep 1
        programas
	else
    	$ERRO
    	exit 1
	fi
}

## Instalar programas
programas()
{

    (
        $APT kate evince atom geogebra freeplane vim conky guake bash-completion
        $APT libreoffice-writer libreoffice-calc --no-install-recommends
        $APT -t unstable firefox firefox-l10n-pt-br firefox-l10n-en-gb
    ) &>/dev/null
	if [[ $? -eq "0" ]];
    then
		printf %b "Programas instalados"
		sleep 1
		confsys
    else
        $ERRO
        exit 1
    fi
}

## Configuração final
confsys()
{

    mv -u "$PWD/icons/*" "/usr/share/themes/"
    mv -u "$PWD/fonts/*" "/usr/share/icons/"

    (
        apt autoremove && apt autoclean
    	apt list --installed | egrep lightdm && systemctl enable lightdm
        apt update && apt install -f
    ) &>/dev/null
}

if [[ "$EUID" -eq 0 ]];
then
    printf "Iniciando..."
    sleep 3
    atualizar
else
    printf %b "Necessita ser um super usuário para executar o script.\nAbortando..."
    exit
fi

printf %b "Pos instalação terminada com sucesso"
sync
exit
