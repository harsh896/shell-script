#!/bin/bash

while getopts m: option
do
case "${option}"
in
m) METHOD=${OPTARG};;
esac
done


#Usage Fucntion
usage()
{
    echo -e "\n [ sh git-ssh.sh (or) URL as Given in Readme ] [-m METHOD] \n"
    echo -e " Here method value are clone, push & pull \n"
    echo -e " clone       Clone a repository into a new directory"
    echo -e " push        Update remote refs along with associated objects"
    echo -e " pull        Fetch from and integrate with another repository or a local branch"
    exit 1
}

if [[ $METHOD == 'clone' ]];
then
    read -e -p "Enter the SSH Key File: " SSH_KEY
    read -e -p "Enter the Git SSH Url: " GIT_SSH_URL

    GIT_SSH_COMMAND='ssh -i $SSH_KEY' git clone $GIT_SSH_URL
elif [[ $METHOD == 'push' ]];
then
    read -e -p "Enter the SSH Key File: " SSH_KEY
    read -e -p "Enter origin and branch name if you want to push specific branch: " ORIGIN_BRANCH
    
    GIT_SSH_COMMAND='ssh -i $SSH_KEY' git push $ORIGIN_BRANCH
elif [[ $METHOD == 'pull' ]];
then
    read -e -p "Enter the SSH Key File: " SSH_KEY

    GIT_SSH_COMMAND='ssh -i $SSH_KEY' git pull
else
    usage
fi
