#!/usr/bin/env bash


# Stage 1
#echo "Welcome to the True or False Game!"
#curl -so ID_card.txt http://127.0.0.1:8000/download/file.txt
#cat ./ID_card.txt


# Stage 2
echo "Welcome to the True or False Game!"
username=$(head -n 1 ./log.txt)
echo $username
#password=tail -n 1 ./ID_card.txt
#curl -sc cookies.txt http://127.0.0.1:8000/login
