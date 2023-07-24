#!/bin/env/ bash

for i in {1..5} 
do
	echo $i
done

seq -s " | " 4


i=1
while [ $i -le 3 ]
do
	echo "I is $i"
	i=$(($i+1))
done


i=1
while true;
do
	if [ $i -gt 5 ];
	then
		break
	fi
	echo "I is $i"
	i=$(($i+1))
done
