#!/usr/bin/env bash

SCRIPT_NAME="ansible-playbook-run"
REPO_URL="https://raw.githubusercontent.com/atm1020/ansible-playbook-run/main/ansible-playbook-run.sh"
TMP_FILE="/tmp/$SCRIPT_NAME"

green='\033[0;32m'
clear='\033[0m'

function check_command {
  command=$1
  if ! command -v $command &> /dev/null
  then
      echo -e "$command could not be found, please install $command"
      exit 0
  fi
}

while getopts p: flag
do
    case "${flag}" in
        p) PATH_TO_PLAYBOOK=${OPTARG};;
    esac
done

echo "Installing $SCRIPT_NAME ..."

check_command "fzf"
check_command "ansible-playbook"

if [ -z "$PATH_TO_PLAYBOOK" ]; then
  read -p "enter the path to your playbook: " PATH_TO_PLAYBOOK
fi

ansible-playbook --syntax-check $PATH_TO_PLAYBOOK || exit

curl -s $REPO_URL | sed "s|{{ path }}|$PATH_TO_PLAYBOOK|g" > $SCRIPT_NAME > $TMP_FILE
sudo mv $TMP_FILE /usr/local/bin/$SCRIPT_NAME
sudo chmod +x /usr/local/bin/$SCRIPT_NAME

echo -e "\n${green}$SCRIPT_NAME installed successfully!${clear}"
