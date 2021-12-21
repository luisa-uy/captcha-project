#!/bin/bash

IFS=$'\n'

array2sql () {
	args=($@)

	printf "%s\n" "${args[0]}"
	
	for i in "${args[@]:1:${#args[@]}-2}"; do 
		printf "%s,\n" $i
	done

	printf "%s;\n" "${args[@]: -1:1}"
}

bloque_conocido () {
	
	bloq=('INSERT INTO bloque (path_imagen, texto, imagen) VALUES') 
	for i in $filelist; do 
		bloq=(${bloq[@]} \
			"$(printf "(\'%s\',\'%s\',\'data:image/png;base64,%s\'),\n" \
				"$i" \
				"$(head -1 "$folder/$i.txt")" \
				"$(base64 -w0 "$folder/$i.png")"
			)"
		)
	done

	array2sql ${bloq[@]}
}

bloque_por_conocer () {

	id=3000
	bloq=("INSERT INTO bloque (id, path_imagen, imagen) VALUES")
	intento=('INSERT INTO intento (fecha_hora, texto, bloque_id) VALUES')

	for i in $filelist; do 
		bloq=(${bloq[@]} \
			"$(printf "(%s,\'%s\',\'data:image/png;base64,%s\')\n" \
				$id \
				"$i" \
				"$(base64 -w0 "$folder/$i.png")" \
			)"
		)
		for j in $(cat $folder/$i.txt); do
			intento=(${intento[@]} \
				$(printf "(\'%s\',\'%s\',%s)" \
					"$(date)" \
					"$j" \
					$id
				)
			)
		done
		id=$(expr $id + 1)
	done

 	array2sql ${bloq[@]}
 	array2sql ${intento[@]}

}

folder=$1

filelist=$(ls $folder  | grep -v txt$ |  sed -e 's/.png$//g')

bloque_por_conocer $filelist

