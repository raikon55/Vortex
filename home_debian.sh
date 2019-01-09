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
    mkdir -p "$HOME/.local/share" "$HOME/.config"

    # Mover os arquivos de configuração para os locais certos
    mv "$PWD/Debian/config/bashrc" "$HOME/.bashrc"
    mv "$PWD/Debian/config/firewall_netfilter.sh" "$HOME/.local/share"
    mv -u "$PWD/Debian/config/" "$PWD/Debian/openbox" "$HOME/.config/"

    # Ler os arquivos conky no diretorio, renomea-los e move-los para a home
    ls $PWD | egrep "Conky" | while read ANTIGO ;
    do
        NOVO=$(echo .${ANTIGO} | tr 'A-Z' 'a-z')
        mv "$PWD/$ANTIGO" "$HOME/$NOVO"
    done
}

eclipse()
{
    # Pegar a versão mais recente do eclipse
    LINK="eclipse.c3sl.ufpr.br/technology/epp/downloads/release"
    [[ $(curl -s "eclipse.c3sl.ufpr.br/technology/epp/downloads/release/") =~ 20[0-9]{2}-[0-9]{2} ]] && VERSAO=$BASH_REMATCH
    NOME="eclipse-cpp-$VERSAO-linux-gtk-$(arch).tar.gz"

    # Baixar e instalar o eclipse em $HOME/Documentos
    curl -s --connect-timeout 15 --output "$NOME" "$LINK/$VERSAO/R/$NOME"

    mkdir -p "$HOME/Documentos/Eclipse"
    tar -zxf "$NOME" -C "$HOME/Documentos/Eclipse"
}

# TO DO
#ferramentas()
#{
#    LOGISIM="ufpr.dl.sourceforge.net/project/circuit/2.7.x/2.7.1/logisim-generic-2.7.1.jar"
#    curl $LOGISIM --output "logisim.jar"
#}

if [[ "$EUID" -eq 0 ]];
then
    printf "Não execute este script como root..."
    exit 1
else
    printf "Configurando a home do $USER"
    conf && eclipse
fi
