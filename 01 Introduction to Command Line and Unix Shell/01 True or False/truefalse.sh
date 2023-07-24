#!/usr/bin/env bash

set -euo pipefail

# Stage 1
echo "Welcome to the True or False Game!"
curl -so ID_card.txt http://127.0.0.1:8000/download/file.txt
#cat ./ID_card.txt

# Stage 2
username=$(head -n 1 ID_card.txt | cut -d ' ' -f 2 | sed 's/^.//' | sed 's/..$//')
password=$(head -n 1 ./ID_card.txt | cut -d ' ' -f 4 | sed 's/^.//' | sed 's/..$//')
message=$(curl -sc cookie.txt http://127.0.0.1:8000/login --user $username:$password)
#echo "Login message: $message"

# Stage 3
#game=$(curl -s --cookie cookie.txt http://127.0.0.1.:8000/game)
#echo "Response: $game"

# Stage 4
function display_menu() {
        echo "0. Exit"
        echo "1. Play a game"
        echo "2. Display scores"
        echo "3. Reset scores"
        echo "Enter an option:"
    }

# Stage 5      
function game() {
        echo "What is your name?"
        read player_name
        RANDOM=4096
        expressions=("Perfect!" "Awesome!" "You are a genius!" "Wow!" "Wonderful!")
        correct=0
        while true;
        do
                item=$(curl -s --cookie cookie.txt http://127.0.0.1:8000/game)
                question=$(python3 -c "data=$item; print(data.get('question'))")
                answer=$(python3 -c "data=$item; print(data.get('answer'))")
                echo
                echo $question
                echo "True or False?"
                read user_answer
                if [ $user_answer == $answer ]; then
                        correct=$(($correct+1))
                        idx=$((RANDOM % 5))
                        echo ${expressions[$idx]}
                        continue
                else
                        echo "Wrong answer, sorry!"
                        echo "$player_name you have $correct correct answer(s)."
                        echo "Your score is $(($correct * 10)) points."
            		echo "User: $player_name, Score: $(($correct * 10)), Date: $(date +%F)" >> scores.txt
            		break
                fi
        done
        }

# Stage 6
function display_scores() {
	if [ "$(find -name "scores.txt" -type f)" == '' ]; then
        echo "File not found or no scores in it!"
	else
		echo "Player scores"
		cat scores.txt
	fi
	}

function reset_scores() {
	if [ "$(find -name "scores.txt" -type f)" == '' ]; then
		echo "File not found or no scores in it!"
	else
		rm scores.txt
		echo "File deleted successfully!"
	fi
	}

while true;
do
        display_menu
        read user
        case "$user" in
                0)
                        echo "See you later!"
                        break
                        ;;
                1)
                        game
                        ;;
                2)
                        display_scores
                        ;;
                3)
                        reset_scores
                        ;;
                *)
                        echo "Invalid option!"
                        ;;
        esac
done
