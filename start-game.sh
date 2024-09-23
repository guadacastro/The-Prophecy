#!/bin/bash

current_path=$(pwd)
root_path=$(pwd)
key=false
shabby_sword=false
legendary_sword=false
armor=false
coins=0
coins_front=true
coins_right=true
amulet=false

function game_loop {
    current_path=$(pwd)

    cat "${current_path}/.story"
    
    if [[ "$amulet" == false ]] && [[ "$key" == false ]] && [[ $PWD == "$root_path/Town_square/outskirts/cave/left" ]]; then
        echo "The door is locked.
You do not have the key for it and you aren't strong enough to break it.
Try coming back later."
        cd ..
    elif [[ "$amulet" == true ]] && [[ $PWD == "$root_path/Town_square/outskirts/cave/left" ]]; then
        echo "You broke the door, congratulations!"
    elif [[ "$key" == true ]] && [[ $PWD == "$root_path/Town_square/outskirts/cave/left" ]]; then
        echo "You have unlocked the door, congratulations!"
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/cave/left/armory" ]]; then
        armor=true
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/cave/front" ]] && [[ "$coins_front" == true ]]; then
        echo "You find a bunch of coins (50)!"
        coins=$((coins+50))
        coins_front=false
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/cave/right" ]] && [[ "$coins_right" == true ]]; then
        echo "You find a bunch of coins (50)!"
        coins=$((coins+50))
        coins_right=false
    fi

    if [[ $PWD == "$root_path/Town_square/outskirts/market/blacksmith" ]] && [[ "$coins" -lt 100 ]]; then
        echo "You don't have enough money.
Come back once you earn more (try searching the cave on the outskirts)"
        cd ..
    elif [[ $PWD == "$root_path/Town_square/outskirts/market/blacksmith" ]] && [[ "$coins" -ge 100 ]]; then
        echo "Ultimately, you decide to buy it.
It is good to have a self-defense tool.
(shabby sword obtained)"
        shabby_sword=true
        coins=$((coins-100))
    fi
    
    if [[ $PWD == "$root_path/Town_square/forest/narrow-path/meadow" ]]; then
        echo "TODO"
        amulet=true
    fi

    if [[ $PWD == "$root_path/Town_square/forest/wide-path" ]] && [[ "$shabby_sword" == false ]]; then
        echo "Unfortunately, you couldn't fight him with bare fists.
You died.
You go back to the start (you can keep your stuff)"
        go "${root_path}/Town_square"
    elif [[ $PWD == "$root_path/Town_square/forest/wide-path" ]] && [[ "$shabby_sword" == true ]]; then
    echo "After a couple minutes of struggle you managed to kill him! 
Wait, there's something shiny on his body.
It's a legendary sword!
Without hesitation you decide to take it.
(legendary sword obtained)"
        legendary_sword=true
    fi

    if [[ $PWD == "$root_path/Town_square/mountains/gorge" ]] && [[ "$legendary_sword" == false ]]; then 
        echo "You see a Wyvern in front of you but you don't have a strong enough weapon to fight it.
You died.
You go back to the start (you can keep your stuff)"
        go "${root_path}/Town_square"
    elif [[ $PWD == "$root_path/Town_square/mountains/gorge" ]] && [[ "$legendary_sword" = true ]]; then 
        echo "You kill the Wyvern.
You find that it was guarding some type of a key and decide to take it. (it might be helpful somewhere in the cave)"
        key=true
    fi

    if [[ $PWD == "$root_path/Town_square/castle" ]] && ([[ "$legendary_sword" = false ]] || [[ "$armor" = false ]]); then
        echo "His breath turns you to ashes immediately.
Perhaps your equipment is not strong enough.
You died.
You go back to the start (you can keep your stuff)"
        go "${root_path}/Town_square"
    elif [[ $PWD == "$root_path/Town_square/castle" ]] && [[ "$legendary_sword" = true ]] && [[ "$armor" = true ]]; then
        echo "You grip your sword, dodging flames as his claws tear the earth.
You can feel the heat of his breath as he spews fire, narrowly missing you...

...You leap over his tail, dodging another strike, and see your chance. 
With one final thrust, manage to defeat him. 
The dragon collapses. 
Exhausted but victorious, you stand over his fallen body, the battle won."
    fi 

}

function custom_cd {
    builtin cd "$@" && game_loop
}

alias go='custom_cd'

go Town_square