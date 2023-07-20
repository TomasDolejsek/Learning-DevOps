#!/usr/bin/env bash


# Stage 1
#echo "Welcome to the True or False Game!"
#curl -so ID_card.txt http://127.0.0.1:8000/download/file.txt
#cat ./ID_card.txt


# Stage 2
echo "Welcome to the True or False Game!"
username=$(head -n 1 ./log.txt | cut -d ' ' -f 2 | sed 's/^.//' | sed 's/..$//')
echo $username
password=$(head -n 1 ./log.txt | cut -d ' ' -f 4 | sed 's/^.//' | sed 's/.$//')
echo $password
curl -sc cookies.txt http://127.0.0.1:8000/login
echo "Login message: $(grep login cookies.txt)"
