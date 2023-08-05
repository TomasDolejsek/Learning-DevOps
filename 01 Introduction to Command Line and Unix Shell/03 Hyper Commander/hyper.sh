#! /usr/bin/bash

# Stage 1
function display_menu() {
	echo
	echo "------------------------------"
	echo "| Hyper Commander            |"
	echo "| 0: Exit                    |"
	echo "| 1: OS info                 |"
	echo "| 2: User info               |"
	echo "| 3: File and Dir operations |"
	echo "| 4: Find Executables        |"
	echo "------------------------------"	
	}

# Stage 2 + 3
function display_fdmenu() {
	arr=(*)
	for item in "${arr[@]}"; do
  		if [[ -f "$item" ]]; then
    			echo "F $item"
  		elif [[ -d "$item" ]]; then
    			echo "D $item"
  		fi
	done
	echo
	echo "---------------------------------------------------"
	echo "| 0 Main menu | 'up' To parent | 'name' To select |"
	echo "---------------------------------------------------"
	}

function fd_operations() {
	while true; do
		echo -e "\nThe list of files and directories:"
		display_fdmenu
		read user
		case $user in
			0) 
				return
				;;
			'up')
				echo "Not implemented!"
				;;
			
			*)
				if echo "${arr[@]}" | grep -wq "$user"; then
   					echo "Not implemented!"
				else
					echo "Invalid input!"
				fi
				;;
		esac
	done			
	}

echo "Hello $USER!"
while true; do
	display_menu
	read user
	case $user in
		0) 
			echo -e "\nFarewell!"
		   	exit
		   	;;
		1)
			echo -e "\n$(uname -no)"
			;;
		2)
			echo -e "\n$(whoami)"
			;;
		3)
			fd_operations
			;;
		4)
			echo -e "\nNot implemented!"
			;;
		*)
			echo -e "\nInvalid option!"
			;;
	esac
done
