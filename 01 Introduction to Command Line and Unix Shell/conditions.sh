#!usr/bin/env/bash

echo "Practicing conditions"
echo

#read words
#if [ "$words" -ge 500 -a "$words" -le 1000 ]; then
#	echo "Good Job!"
#else
#	echo "Revise the essay"
#fi

case "$1" in

	"")
		echo "No"
		;;
	1)
		echo "1"
		;;
	2)
		echo "2"
		;;
	3)
		echo "3"
		;;
	*)
		echo "Unknown number '$1'."
		;;
esac


answers=("a" "d" "c" "a" "a")
score=0

for (( i = 0; i < 5; i++));
do
	case "$1" in

		${answers[i]})
			((score++))
			;;
		"-"|"--")
			;;
		*)
			((score--))
			;;
	esac
	shift 1
done

echo "Total score is: $score"
