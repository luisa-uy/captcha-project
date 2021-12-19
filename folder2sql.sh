#!/bin/bash

folder=$1
IFS=$'\n'

filelist=$(ls $folder  | grep -v txt$ |  sed -e 's/.png$//g')

printf "%s\n" "INSERT INTO bloque (path_imagen, imagen, texto) VALUES" 
for i in $filelist; do 
	printf "(\'%s\',\'%s\',\'%s\'),\n" \
		"$i" \
		"$(base64 "$folder/$i.png")" \
		"$(head -1 "$folder/$i.txt")"
done
