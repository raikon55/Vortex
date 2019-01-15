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
    CONF_FILES="$PWD/Debian/config"

    mkdir -p "$HOME/.local/share" "$HOME/.config"

    # Mover os arquivos de configuração para os locais certos
    ls $CONF_FILES | egrep "*rc" | while read RC ;
    do
        mv "$CONF_FILES/$RC" "$HOME/.${RC}"
    done

    mv "$CONF_FILES/vim" "$HOME/.vim" && mkdir "$HOME/.vim/temp"
    mv "$PWD/$CONF_FILES/firewall_netfilter.sh" "$HOME/.local/share"

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
    [[ $(curl -s "$LINK") =~ 20[0-9]{2}-[0-9]{2} ]] && VERSAO=$BASH_REMATCH
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
