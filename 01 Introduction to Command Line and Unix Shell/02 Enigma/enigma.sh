#!/bin/bash

#set -euo pipefail

# Stage 1
#echo "Enter a message:"
#read user

#pattern='^[A-Z ]+$'

#if [[ "$user" =~ $pattern ]];
#then
#	echo "This is a valid message!"
#else
#	echo "This is not a valid message!"
#fi

# Stage 2
#up_char_pattern='^[A-Z]$'
#digit_pattern='^[0-9]$'

#echo "Enter an uppercase letter:"
#read letter
#echo "Enter a key:"
#read key

#if ! [[ "$letter" =~ $up_char_pattern && "$key" =~ $digit_pattern ]]; then
#	echo "Invalid key or letter!"
#	exit 
#fi

function encrypt() {
	letter_code=$(printf "%d\n" "'$1")
	new_code=$(($letter_code + $2))
	if [[ $new_code -gt 90 ]]; then
		new_code=$(($new_code - 26))
	elif [[ $new_code -lt 65 ]]; then
		new_code=$(($new_code + 26))
	fi
	new_letter=$(printf "%b\n" "$(printf "\\%03o" "$new_code")")
	echo $new_letter
	}

# Stage 3
#command_pattern='^[de]$'
#message_pattern='^[A-Z ]+$'

#echo "Type 'e' to encrypt, 'd' to decrypt a message:"
#echo "Enter a command:"
#read user
#if ! [[ "$user" =~ $command_pattern ]]; then
#	echo "Invalid command!"
#	exit
#fi

#echo "Enter a message:"
#read message
#if ! [[ "$message" =~ $message_pattern ]]; then
#	echo "This is not a valid message!"
#	exit
#fi

#if [[ "$user" == 'e' ]]; then
#	echo "Encrypted message:"
#	key=3
#else
#	echo "Decrypted message:"
#	key=-3
#fi

#for ((i=1; i<=${#message}; i+=1));
#do
#	letter=$(echo "${message}" | cut -c $i)
#	if [[ "$letter" != ' ' ]]; then
#		new_letter=$(encrypt "$letter" "$key")
#	else
#		new_letter=' '
#	fi
#	new_message+=$new_letter
#done

#echo $new_message

# Stage 4
filename_pattern='^[A-Za-z.]+$'
message_pattern='^[A-Z ]+$'

function display_menu() {
	echo "0. Exit"
	echo "1. Create a file"
	echo "2. Read a file"
	echo "3. Encrypt a file"
	echo "4. Decrypt a file"
	echo "Enter an option:"
	}

function create_file() {
	echo "Enter the filename:"
	read filename
	if ! [[ $filename =~ $filename_pattern ]]; then
		echo "File name can contain letters and dots only!"
		return
	fi
	
	echo "Enter a message:"
	read message
	if ! [[ $message =~ $message_pattern ]]; then
		echo "This is not a valid message!"
		return
	fi

	echo "$message" > "$filename"
	echo "The file was created successfully!"
	}

function read_file() {
	echo "Enter the filename:"
	read filename
	if [[ "$(find -name $filename -type f)" == '' ]]; then
		echo "File not found!"
		return
	fi

	echo "File content:"
	cat $filename
	}

# Stage 5
function encrypt_file() {
	echo "Enter the filename:"
	read filename
	if [[ "$(find -name $filename -type f)" == '' ]]; then
		echo "File not found!"
		return
	fi
	encrypt_filename="$filename.enc"
	message=$(cat $filename)
	echo $message | tr "[A-Z]" "[D-ZA-C]" > $encrypt_filename
	rm $filename
	echo "Success"
	}

function decrypt_file() {
	echo "Enter the filename:"
	read filename
	if [[ "$(find -name $filename -type f)" == '' ]]; then
		echo "File not found!"
		return
	fi
	decrypt_filename=$(echo ${filename::-4})
	message=$(cat $filename)
	echo $message | tr "[D-ZA-C]" "[A-Z]" > $decrypt_filename
	rm $filename
	echo "Success"
	}

# Stage 6
function ssl_encrypt_file() {
	echo "Enter the filename:"
	read filename
	if [[ "$(find -name $filename -type f)" == '' ]]; then
		echo "File not found!"
		return
	fi
	encrypt_filename="$filename.enc"
	echo "Enter password:"
	read password
	openssl enc -aes-256-cbc -e -pbkdf2 -nosalt -in "$filename" -out "$encrypt_filename" -pass pass:"$password" &>/dev/null
	exit_code=$?
	if [[ $exit_code -ne 0 ]]; then
		echo "Fail"
	else
		rm $filename
        echo "Success"
	fi
	}

function ssl_decrypt_file() {
	echo "Enter the filename:"
	read filename
	if [[ "$(find -name $filename -type f)" == '' ]]; then
		echo "File not found!"
		return
	fi
	decrypt_filename=$(echo ${filename::-4})
	echo "Enter password:"
	read password
	openssl enc -aes-256-cbc -d -pbkdf2 -nosalt -in "$filename" -out "$decrypt_filename" -pass pass:"$password" &>/dev/null
	exit_code=$?
	if [[ $exit_code -ne 0 ]]; then
		echo "Fail"
	else
    	rm $filename
        echo "Success"
	fi
	}

echo "Welcome to the Enigma!"
echo
while true;
do
	display_menu
	read user
	case "$user" in
		0)
			echo "See you later!"
			exit
			;;
		1)
			create_file
			;;
		2)
			read_file
			;;
		3)
			ssl_encrypt_file
			;;
		4)
			ssl_decrypt_file
			;;
		*)
			echo "Invalid option!"
			;;
	esac
done
