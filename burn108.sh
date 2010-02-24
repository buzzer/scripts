#!/bin/bash

if [ -z  "$1" ]; then
        echo "************************************************"
        echo "*                                              *"
        echo "*     Welchs Iimage soll ich brennen ?         *"
        echo "*                                              *"
        echo "************************************************"
	echo 
	echo 
        echo " Es stehen folgende Images zur Verfuegung:   "
	echo
	echo

	cd ~/download

	PS3=" Welches soll ich brennen ? : "
	select i in $(ls -1 ) ; do

		echo 
		echo "OK, dann brenne ich $i"	
		echo

		cd $i
		cdrdao write -n --device IODVDServices --driver generic-mmc "$i".toc
		break
	done
else

	cd ~/download/"$1"
	cdrdao write -n --device IODVDServices --driver generic-mmc "$1".toc
fi

