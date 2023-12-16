#!/usr/bin/env bash

PLAYBOOK_PATH='{{ path }}'
USER_NAME=$(whoami)

if [ ! -f "$PLAYBOOK_PATH" ]; then
  echo "playbook not found at the expected location: $PLAYBOOK_PATH"
  exit 0
fi

ansible_output=$(ansible-playbook --list-tags $PLAYBOOK_PATH)
plain_tags=$(ansible-playbook --list-tags $PLAYBOOK_PATH | grep "TASK TAGS" | sed 's/,//g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/TASK TAGS://g')
plain_tags="$plain_tags all" # add all option to the list

selected=$(for tag in $plain_tags; do echo $tag; done | fzf)

if [ -z "$selected" ]; then
  echo "no tag selected"
  exit 0
fi

echo "selected: $selected | running with user: $USER_NAME"
ansible-playbook --ask-become-pass --extra-vars "user=$USER_NAME" $PLAYBOOK_PATH --tags $selected
