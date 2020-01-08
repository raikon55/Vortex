#!/usr/bin/env bash
#!/usr/bin/env bash
#
##   Criado por Eduardo Lopes
##   edufelopes@gmail.com
#
## Converte arquivos de áudio para o format .ogg



find . -type f -iname "$1" -exec bash -c '{\
    _name="{}" ;\
    ffmpeg -i "$_name" -c:a libvorbis -vn "${_name%.*}.ogg" ;\
    }'\
    {} \;
