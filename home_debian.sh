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
    mv "$PWD/Debian/config/bashrc" "$HOME/.bashrc"
    mv "$PWD/Debian/config/firewall_netfilter.sh" "$HOME/.local/share"

    mv -u "$PWD/Debian/config/*" "$PWD/Debian/openbox" "$HOME/.config/"

    ls "$PWD/Conky*" | while [[ read ANTIGO ]];
    do
        NOVO=$(echo .${ANTIGO} | tr 'A-Z' 'a-z')
        mv "$PWD/$ANTIGO" "$HOME/$NOVO"
    done
}

eclipse()
{
    LINK="eclipse.c3sl.ufpr.br/technology/epp/downloads/release"
    [[ $(curl -s "eclipse.c3sl.ufpr.br/technology/epp/downloads/release/") =~ 20[0-9]{2}-[0-9]{2} ]] && VERSAO=$BASH_REMATCH
    NOME="$LINK/$VERSAO/R/eclipse-cpp-$VERSAO-linux-gtk-$(arch).tar.gz"

    curl -s --connect-timeout 15 --output "$NOME" "$LINK/$VERSAO/R/$NOME"

    mkdir "$HOME/Documentos/Eclipse"
    tar -zxf "$NOME" -C "$HOME/Documentos/Eclipse"
}

# TO DO
#ferramentas()
#{
#    LOGISIM="ufpr.dl.sourceforge.net/project/circuit/2.7.x/2.7.1/logisim-generic-2.7.1.jar"
#    curl $LOGISIM --output "logisim.jar"
#}

if [[ "$EUID" -eq 0]];
then
    printf "Não execute este script como root..."
    exit 1
else
    printf "Configurando a home do $USER"
    conf
fi
