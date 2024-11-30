#!/usr/bin/env bash

selected=`cat ~/.dotfiles/cht-langs ~/.dotfiles/cht-cmds | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"

else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi

