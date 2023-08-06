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

# Stage 2
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

# Stage 5
function display_file_menu () {
	echo "---------------------------------------------------------------------"
	echo "| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |"
	echo "---------------------------------------------------------------------"
	}

function file_actions () {
	while true; do
		display_file_menu
		read user_choice
		case $user_choice in
			0) 
				return
				;;
			1)
				rm "$fd"
				echo "$fd has been deleted."
				return
				;;
			2)
				echo "Enter the new file name:"
				read new_filename
				mv "$fd" "$new_filename"
				echo "$fd has been renamed as $new_filename"
				return
				;;
			3)
				chmod 666 "$fd"
				echo "Permissions have been updated."
				ls -l "$fd"
				return
				;;
			4)
				chmod 664 "$fd"
				echo "Permissions have been updated."
				ls -l "$fd"
				return
				;;
		esac			
	done
	}

# Stage 4
function fd_actions() {
	if [[ $(find -type d -name "$fd") ]]; then
		cd "$fd"
	else
		file_actions
	fi
	}

# Stage 3
function fd_operations() {
	while true; do
		echo -e "\nThe list of files and directories:"
		display_fdmenu
		read fd
		case $fd in
			0) 
				return
				;;
			'up')
				cd ..
				continue
				;;
			*)
				if echo "${arr[@]}" | grep -wq "$fd"; then
					fd_actions
				else
					echo "Invalid input!"
				fi
				;;
		esac
	done			
	}

# Stage 6
function executables() {
	echo "Enter an executable name:"
	read ex_name
	location=$(echo $(which "$ex_name"))
	if ! [[ $location ]]; then
		echo -e "\nThe executable with that name does not exist!"
		return		
	fi
	echo -e "\nLocated in: $location"
	echo -e "\nEnter arguments:"
	read args
	echo $(${ex_name} ${args})
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
			executables
			;;
		*)
			echo -e "\nInvalid option!"
			;;
	esac
done
