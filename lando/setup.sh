#!/bin/bash
lando_url="https://raw.githubusercontent.com/harshH-addweb/shell-script/main/ubuntu/lando-setup.sh"

#Color Variables
reset='\033[0m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

#Bold Colors
Breset='\033[0m'
Bred='\033[1;31m'
Bgreen='\033[1;32m'
Byellow='\033[1;33m'
Bblue='\033[1;34m'
Bmagenta='\033[1;35m'
Bcyan='\033[1;36m'

#Usage Fucntion
usage()
{
    echo -e "\n ${red}Please enter a valid entry ${Bred}[yes/no]${reset}"
    exit 1
}

read -e -p "Are you doing setup for the first time [yes]/no: " -i "yes" first_setup


if [ $first_setup == 'yes' ];
then
    import_db=yes
    read -e -p "Enter the Database file name: " db_name
    
    
    # Check whether lando is installed or not
    if [ -f /usr/local/bin/lando ];
    then
        # Lando Start & DB import
        echo -e "\n${green} ........Lando Start & DB import........${reset} \n"
        lando rebuild -y
        lando db-import $db_name
    else
        # Installing Lando
        sudo apt-get install curl -y
        /bin/bash -c "$(curl -sL $lando_url)"

        # Lando Start & DB import
        echo -e "\n${green} ........Lando Start & DB import........${reset} \n"
        lando rebuild -y
        lando db-import $db_name
    fi

elif [ $first_setup == 'no' ];
then
    read -e -p "Do you want to Import Database [yes]/no: " -i "yes" import_db
    read -e -p "Do you want to Export Database yes/[no]: " -i "no" export_db

    if [ $import_db == 'yes' ] && [ $export_db == 'yes' ];
    then
        read -e -p "Enter the Database file name: " db_name
        
        # Exporting Database
        echo -e "\n${cyan} ........Exporting Database........${reset} \n"
        lando db-export

        # Lando Restarting & Importing Database
        echo -e "\n${yellow} ........Lando Restarting & Importing Database........${reset} \n"
        lando rebuild -y
        lando db-import $db_name

    elif [ $import_db == 'yes' ] && [ $export_db == 'no' ];
    then
        read -e -p "Enter the Database file name: " db_name

        # Lando Restarting & Importing Database
        echo -e "\n${yellow} ........Lando Restarting & Importing Database........${reset} \n"
        lando rebuild -y
        lando db-import $db_name

    elif [ $import_db == 'no' ] && [ $export_db == 'yes' ];
    then
        # Exporting Database
        echo -e "\n${cyan} ........Exporting Database........${reset} \n"
        lando db-export
    elif [ $import_db == 'no' ] && [ $export_db == 'no' ];
    then
        echo -e "\nYou haven't choosen to import db but you can import it later but running ${Bmagenta}lando db-import <file-path>${reset} in your terminal.\n"
        echo -e "\nYou also haven't choosen for db backup but you can backup db by running ${Bmagenta}lando db-export${reset} in your terminal.\n"
    else
        usage
    fi  
else
    usage
fi


lando info --format table
