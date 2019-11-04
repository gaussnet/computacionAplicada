#/bin/bash

function mostrar_menu(){
	clear
	echo "1) Serie de Fibonacci"
	echo "2) Mostrar un número en forma invertida"
	echo "3) Evaluar si es palíndromo"
	echo "4) Mostrar cantidad de lineas de un archivo de texto"
	echo "5) Mostrar 5 números de forma ordenada"
	echo "6) Mostrar cuantos archivos de cada tipo contiene un directorio"
	echo "7) Salir saludando"
	echo "---------------------------------------------------------------"

}

#Punto 7
function salir_saludando(){
	NOMBRE=$1
	echo "Chau $NOMBRE"
	sleep 2
}

#Punto 1
function fibonacci(){
	#Primer valor
	A=0
	#Segundo valor
	B=1

	echo -n "Ingrese un número: "
	read VAR1

	echo "La serie de Fibonacci es: "

	for (( i=0; i<VAR1; i++ ))
	do
		echo -n "$A "
		FIB=$((A + B))
		A=$B
		B=$FIB
	done

	echo
}

#Punto 2
function mostrar_num_invertido(){
	echo -n "Ingrese un número: "
	read VAR1
	if echo "$VAR1"|egrep -q '^\-?[0-9]+$'; then
		echo "$VAR1"|rev
	else
		echo "No es un número"
	fi
}

#Punto 3
function es_palindromo(){
	LEN=0
	I=1
	read -p "Ingrese una cadena: " STR
	LEN=`echo $STR | wc -m`
	LEN=`expr $LEN - 1`
	if [ ! $LEN -eq 0 ]; then
    	MITAD=`expr $LEN / 2`
    	while [ $I -le $MITAD ]; do
        	C1=`echo $STR|cut -c$I`
        	C2=`echo $STR|cut -c$LEN`
        	if [ $C1 != $C2 ]; then
            	echo "La cadena no es capicua"
        	fi
        	I=`expr $I + 1`
        	LEN=`expr $LEN - 1`
    	done
    	echo "La cadena es capicua"
	else
    	echo "ERROR: La cadena ingresada es incorrecta"
	fi
}

#Punto 4
function mostrar_cant_lineas(){
	echo -n "ingrese nombre de archivo: "
	read NOMBRE_ARCH
	if test -f "$NOMBRE_ARCH"; then
		echo `wc -l $NOMBRE_ARCH|awk '{print $1}'`
	else
		echo "Archivo incorrecto"
	fi
	
}

#Punto 5
function mostrar_num_ordenados(){
	echo "Ingrese 5 números"
	for (( i=0; i<=4; i++ ))
	do
		read -p "Ingrese valor $((i+1)): " VALOR
		arreglo[$i]=${VALOR}
	done

	ordenado=($(for i in "${arreglo[@]}"; do echo $i; done | sort))
	echo "${ordenado[@]}"
}

#Punto 6
function cant_arch_tipo(){
	echo -n "Ingrese path directorio: "
	read NOMBRE_DIR
	if [ -d "$NOMBRE_DIR" ]; then
		cd "$NOMBRE_DIR"
		echo "Archivos regulares: " `find . -maxdepth 1 -type f|wc -l`
		echo "Directorios: " `find . -maxdepth 1 -type d|wc -l`
		echo "Link simbólicos: " `find . -maxdepth 1 -type l|wc -l`
		echo "Pipes: " `find . -maxdepth 1 -type p|wc -l`
		echo "Archivos de caracteres: " `find . -maxdepth 1 -type c|wc -l`
		echo "Archivos de bloque: " `find . -maxdepth 1 -type b|wc -l`
		echo "Sockets: " `find . -maxdepth 1 -type s|wc -l`
	else
		echo "No existe directorio"
	fi
}
 

#--- Principal ----
OPCION=0

mostrar_menu
while true; do
	read -p "Ingrese una opción: " OPCION
	case $OPCION in
		1) fibonacci;;
		2) mostrar_num_invertido;;
		3) es_palindromo;;
		4) mostrar_cant_lineas;;
		5) mostrar_num_ordenados;;
		6) cant_arch_tipo;;
		7) salir_saludando `whoami`
			break;;
		*) echo "Opción incorrecta";;
	esac
done
exit 0


	
