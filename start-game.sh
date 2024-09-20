#!/bin/bash

current_path=$(pwd)
root_path=$(pwd)
key=false
shabby_sword=false
legendary_sword=false
armour=false
coins=0
amulet=false

function game_loop {
    current_path=$(pwd)
    echo $root_path
    echo $current_path
    # cat "${current_path}/story"
    
    if ["$amulet" == false] || [[$PWD == "{$root_path}/Town_square/outskirts/cave/left"]]; then
        echo "The door is locked.
        You do not have the key for it and you aren't strong enough to break it.
        Try coming back later."
    fi   
}

function custom_cd {
    builtin cd "$@" && game_loop
}

alias go='custom_cd'

go Town_square