<<<<<<< HEAD
#!/bin/bash
#####################################
#   Pos instalação da               #
#   distribuição GNU/Linux Debian   #
#####################################
=======
#!/bin/bash -xe

## Script pós instalação GNU/Linux Debian
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa

## Variaveis
APT="apt install -y --no-install-suggests"
ERRO="printf %b 'Ops...\nAlgo não saiu como esperado\n'"

## Atualizar repositorios
atualizar() {
<<<<<<< HEAD
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
=======
    mv "$PWD/{sources.list,preferences}" "/etc/apt/"
    apt update && apt upgrade -y
    apt install aptitude deborphan -y >/dev/null
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
}

## Instalar básico
essencial() {

<<<<<<< HEAD
    $APT xorg mtp-tools jmtpfs pulseaudio pavucontrol 2>/dev/null
=======
    $APT xorg-server xorg-xinit xorg-apps gvfs-mtp xserver-xorg-video-intel pulseaudio pavucontrol libx264 -y >/dev/null
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
	if [[ $?  -eq "0" ]];
    then
		printf %b "Xorg, drivers de video e pulseaudio instalados"
        sleep 1
<<<<<<< HEAD
        interface
=======
        interface()
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
   	else
       	$ERRO
       	exit 1
   	fi
}

## Instalar Openbox
interface() {

<<<<<<< HEAD
	$APT openbox thunar thunar-volman lxappearance lightdm lightdm-gtk-greeter arc-theme bc compton nitrogen neofetch plank 2>/dev/null
=======
	$APT openbox oblogout thunar thunar-volman lxappearance lightdm lightdm-gtk-greeter arc-icon-theme bc compton nitrogen neofetch git plank >/dev/null
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
	if [[ $? -eq "0" ]];
    then
		printf %b "Interface gráfica instalada\n"
        sleep 1
<<<<<<< HEAD
        fontes
   	else
       	$ERRO
       	exit 1
   	fic
=======
        fontes()
   	else
       	$ERRO
       	exit 1
   	fi
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa

}

## Instalar fontes
fontes() {

<<<<<<< HEAD
    $APT ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-ubuntu-font-family 2>/dev/null
=======
	$APT ttf-anonymous-pro ttf-bitstream-vera ttf-dejavu ttf-droid ttf-gentium ttf-liberation ttf-ubuntu-font-family
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
    if [[ $? -eq "0" ]];
    then
   		printf %b "Fontes instaladas"
        sleep 1
<<<<<<< HEAD
        programas
=======
        programas()
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
	else
    	$ERRO
    	exit 1
	fi
}

## Instalar programas
programas() {

<<<<<<< HEAD
	$APT kate evince atom geogebra freeplane vim conky guake bash-completion 2>/dev/null
    $APT libreoffice-writer libreoffice-calc --no-install-recommends 2>/dev/null
    $APT -t unstable firefox=63.0.3-1 2>/dev/null
=======
	$APT kate evince atom geogebra freeplane firefox vim conky guake bash-completion
    $APT libreoffice-writer libreoffice-calc --no-install-recommends
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
	if [[ $? -eq "0" ]];
    then
		printf %b "Programas instalados"
		sleep 1
<<<<<<< HEAD
		confsys
=======
		confsys()
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
    else
        $ERRO
        exit 1
    fi
}

## Configuração final
confsys() {

<<<<<<< HEAD
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

=======
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

>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
if [[ "$USER" = "root" ]];
then
    printf "Wait..."
    sleep 3
<<<<<<< HEAD
    time nohup atualizar
=======
    atualizar()
>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
else
    printf %b "Necessita ser um super usuário para executar o script.\nAbortando..."
    exit 0
fi

printf %b "Pos instalação terminada com sucesso"
<<<<<<< HEAD
=======

>>>>>>> 296eb7c269b46b1724f8493a80f1d870da8c77aa
sync
exit
