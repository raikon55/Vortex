#!/bin/bash
#####################################
#   Pos instalação da               #
#   distribuição GNU/Linux Debian   #
#####################################

## Variaveis
APT="apt install -y --no-install-suggests"
ERRO="printf %b 'Ops...\nAlgo não saiu como esperado\n'"

## Atualizar repositorios
atualizar() {
    mv "$PWD/Debian/sources.list" "/etc/apt/"
    mv "$PWD/Debian/preferences" "/etc/apt/"

    # Subshell
    (
        apt update && apt upgrade -y 2>/dev/null
        apt install deborphan curl -y 2>/dev/null
        curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add
        curl -sL https://static.geogebra.org/linux/office@geogebra.org.gpg.key | apt-key add
    )

    essencial
    return 0
}

## Instalar básico
essencial() {

    $APT xorg mtp-tools jmtpfs pulseaudio pavucontrol 2>/dev/null
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
interface() {

	$APT openbox thunar thunar-volman lxappearance lightdm lightdm-gtk-greeter arc-theme bc compton nitrogen neofetch plank 2>/dev/null
	if [[ $? -eq "0" ]];
    then
		printf %b "Interface gráfica instalada\n"
        sleep 1
        fontes
   	else
       	$ERRO
       	exit 1
   	fic

}

## Instalar fontes
fontes() {

    $APT ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-ubuntu-font-family 2>/dev/null
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
programas() {

	$APT kate evince atom geogebra freeplane vim conky guake bash-completion 2>/dev/null
    $APT libreoffice-writer libreoffice-calc --no-install-recommends 2>/dev/null
    $APT -t unstable firefox=63.0.3-1 2>/dev/null
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
confsys() {

    mkdir -p "$HOME/.themes" "$HOME/.icons"
    mv "$PWD/icons/*" "$HOME/.themes/"
    mv "$PWD/fonts/*" "$HOME/.icons/"

    cd "Debian/"
    for tmp in "$PWD/config";
    do
        mv -r "$PWD/$tmp" "$HOME/.config";
    done

    apt autoremove && apt autoclean
	apt list --installed | egrep lightdm && systemctl enable lightdm
    apt update && apt install -f
}

if [[ "$USER" = "root" ]];
then
    printf "Wait..."
    sleep 3
    time nohup atualizar
else
    printf %b "Necessita ser um super usuário para executar o script.\nAbortando..."
    exit 0
fi

printf %b "Pos instalação terminada com sucesso"
sync
exit
