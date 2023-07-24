#!/usr/bin/env bash

set -euo pipefail

# Stage 1
#echo "Enter a message: "
#read user

#pattern='^[A-Z ]+$'

#if [[ "$user" =~ $pattern ]];
#then
#	echo "This is a valid message!"
#else
#	echo "This is not a valid message!"
#fi

# Stage 2
up_letter_pattern='^[A-Z]+$'
digit_pattern='^[0-9]$'

echo "Enter an uppercase letter:"
read letter
echo "Enter a key:"
read key

if ! [[ "$letter" =~ $up_letter_pattern && "$key" =~ $digit_pattern ]]; then
	echo "Invalid key or letter!"
	exit 
fi

letter_code=$(printf "%d\n" "'$letter")
new_code=$(($letter_code + $key))
if [[ $new_code -gt 90 ]]; then
	new_code=$(($new_code - 26))
fi

echo $letter_code
echo $new_code
new_letter=$(printf "%b\n" "$(printf "\\%03o" "$new_code")")
echo $new_letter

