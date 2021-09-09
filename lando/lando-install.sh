#!/bin/bash

#Checking latest version of lando
latest=$(curl --silent "https://api.github.com/repos/lando/lando/releases" | grep -Po '"tag_name": "\K.*?(?=")' | head -n1)


if [ -f /usr/local/bin/lando ]
then
    current_version=$(lando version)
    echo -e "\n\033[0;33mLando already installed. Checking Version\033[0m"
    echo -e "Existing Version = $current_version \n"
    if [[ $latest == $current_version ]]
    then
        echo -e "\n\033[0;32mAlready the latest version!!!!!!!!!!\033[0m"
    else
        echo -e "\033[0;33m...................Updating Lando...................\033[0m"
        rm lando-stable.deb
        wget https://files.devwithlando.io/lando-stable.deb
        sudo dpkg -i lando-stable.deb
        echo -e "\033[0;32m...................Updating Completed...................\033[0m"
    fi
else
    if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 1 ];
    then
        echo -e "\033[0;32m...................Installing Lando...................\033[0m \n"
        rm lando-stable.deb
        wget https://files.devwithlando.io/lando-stable.deb
        sudo dpkg -i lando-stable.deb >> /dev/null
        echo -e "\n\033[0;32mLando Installed!!!!!!!!!!\033[0m"
        rm lando-stable.deb
    else
        echo -e "\033[0;31m...................Docker is not installed in your system. Please install it before you run this script...................\033[0m \n"
    fi
    
fi 
