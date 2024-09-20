#!/bin/bash

current_path=$(pwd)
root_path=$(pwd)
key=false
shabby_sword=false
legendary_sword=false
armor=false
coins=0
amulet=false

function game_loop {
    current_path=$(pwd)
    # echo $root_path
    # echo $current_path
    
    if [[ "$amulet" == false ]] && [[ "$key" == false ]] && [[ $PWD == "$root_path/Town_square/outskirts/cave/left" ]]; then
        echo "The door is locked.\n You do not have the key for it and you aren't strong enough to break it.\n Try coming back later."
        cd ..
    elif [[ "$amulet" == true ]] && [[ $PWD == "$root_path/Town_square/outskirts/cave/left" ]]; then
        echo "You broke the door, congratulations!"
    elif [[ "$key" == true ]] && [[ $PWD == "$root_path/Town_square/outskirts/cave/left" ]]; then
        echo "You have unlocked the door, congratulations!"
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/cave/left/armory" ]]; then
        armor=true
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/cave/front" ]]; then
        coins=$((coins+50))
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/cave/right" ]]; then
        coins=$((coins+50))
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/market/blacksmith" ]] && [[ "$coins" < 100 ]]; then
        echo "You see a blacksmith selling swords but you don't have anough money to buy one.\n Come back once you earn more (try searching the cave)"
        cd ..
    elif [[ $PWD == "$root_path/Town_square/outskirts/market/blacksmith" ]] && [[ "$coins" >= 100 ]]; then
        shabby_sword=true
        coins=0
    fi

    cat "${current_path}/story"
}

function custom_cd {
    builtin cd "$@" && game_loop
}

alias go='custom_cd'

go Town_square