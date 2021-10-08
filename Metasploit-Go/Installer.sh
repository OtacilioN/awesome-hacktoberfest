#!/bin/bash

RED="\e[31m"
LIME="\e[32m"
ENDCOLOR="\e[0m"

  echo -e "${LIME} #_Metasploit Framework Installer for all Linux By FxFournn@adialamsyahardi.com_# ${ENDCOLOR}"
  echo -e "${LIME} Github: https://github.com/adialamsyahardi ${ENDCOLOR}"
    sleep 2
    
    set -eu -o pipefail # Gagal saat Error , debug all lines

  echo -e "${LIME} Download File Instalasi ${ENDCOLOR}"
    wget https://downloads.metasploit.com/data/releases/metasploit-latest-linux-x64-installer.run
    wget https://downloads.metasploit.com/data/releases/metasploit-latest-linux-x64-installer.run.sha1
  echo $(cat metasploit-latest-linux-x64-installer.run.sha1)'  'metasploit-latest-linux-x64-installer.run > metasploit-latest-linux-x64-installer.run.sha1

  sudo -n true
      test $? -eq 0 || exit 1 echo -e "${RED} pastiin kamu punya hak root ${ENDCOLOR}"

  echo -e "${LIME} Proses Instalasi Package 1 ${ENDCOLOR}"
      while read -r p ; do shasum $p ; done < <(cat << "EOF"
    metasploit-latest-linux-x64-installer.run.sha1
EOF
)
    sleep 1

  echo -e "${LIME} Proses Instalasi Package 2 ${ENDCOLOR}"
      while read -r p ; do chmod +x $p ; done < <(cat << "EOF"
    ./metasploit-latest-linux-x64-installer.run
EOF
)
    sleep 1

  echo -e "${LIME} Proses Instalasi terakhir ${ENDCOLOR}"
  echo -e "${LIME} Ctrl+C Untuk membatalkan ${ENDCOLOR}"
  echo -e "${LIME} \n ${ENDCOLOR}"
    sleep 3

    sudo ./metasploit-latest-linux-x64-installer.run
