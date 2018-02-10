#!/bin/bash -xe

## Script pós instalação GNU/Linux Debian

## Variaveis
APT="apt install -y --no-install-suggests"
ERRO="printf %b 'Ops...\nAlgo não saiu como esperado\n'"

## Atualizar repositorios
atualizar() {
    mv "$PWD/{sources.list,preferences}" "/etc/apt/"
    apt update && apt upgrade -y
    apt install aptitude deborphan -y >/dev/null
}

## Instalar básico
essencial() {

    $APT xorg-server xorg-xinit xorg-apps gvfs-mtp xserver-xorg-video-intel pulseaudio pavucontrol libx264 -y >/dev/null
	if [[ $?  -eq "0" ]];
    then
		printf %b "Xorg, drivers de video e pulseaudio instalados"
        sleep 1
        interface()
   	else
       	$ERRO
       	exit 1
   	fi
}

## Instalar Openbox
interface() {

	$APT openbox oblogout thunar thunar-volman lxappearance lightdm lightdm-gtk-greeter arc-icon-theme bc compton nitrogen neofetch git plank >/dev/null
	if [[ $? -eq "0" ]];
    then
		printf %b "Interface gráfica instalada\n"
        sleep 1
        fontes()
   	else
       	$ERRO
       	exit 1
   	fi

}

## Instalar fontes
fontes() {

	$APT ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-droid ttf-gentium ttf-liberation ttf-ubuntu-font-family
    if [[ $? -eq "0" ]];
    then
   		printf %b "Fontes instaladas"
        sleep 1
        programas()
	else
    	$ERRO
    	exit 1
	fi
}

## Instalar programas
programas() {

	$APT kate evince atom geogebra freeplane firefox vim conky guake bash-completion
    $APT libreoffice-writer libreoffice-calc --no-install-recommends
	if [[ $? -eq "0" ]];
    then
		printf %b "Programas instalados"
		sleep 1
		confsys()
    else
        $ERRO
        exit 1
    fi
}

## Configuração final
confsys() {

    mkdir "$HOME/.themes" "$HOME/.icons"

    mv "$PWD/openbox" "$HOME/.config/"
    mv "$PWD/icons/*" "$HOME/.themes/"
    mv "$PWD/fonts/*" "$HOME/.icons/"

    apt autoremove && apt autoclean
	apt list --installed | egrep lightdm && systemctl enable lightdm
    aptitude update
}

#####################################
#   Pos instalação da               #
#   distribuição GNU/Linux Debian   #
#####################################

if [[ "$USER" = "root" ]];
then
    printf "Wait..."
    sleep 3
    atualizar()
else
    printf %b "Necessita ser um super usuário para executar o script.\nAbortando..."
    exit 0
fi

printf %b "Pos instalação terminada com sucesso"

sync
exit
