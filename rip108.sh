#!/bin/bash
######################################################
#
#This Software is released under the GNU Public Licese
#It is originally written by Roman Klesel
#You can contact me by mail: roman.klesel@my-mail.ch
####################################################

# This first variables are ment to be adjusted by users

_READ_SUBCHANNEL_DATA=FALSE
_USE_RAW_MODE_BY_DEFAULT=FALSE
_REPOSITORY_ROOT_DIR=$(echo "$HOME""/download/")
_DEVICE="IODVDServices"
_DRIVER="generic-mmc"

# Here ends the USer section

_DATE=$(date '+%m_%d_%H-%M')
_BSD_DEVICE=$( mount | grep disk1 | awk '{print ($1)}')

# Check if CD is in the drive

if [ -z $_BSD_DEVICE ]; then
	echo "************************************************"
	echo "*                                              *"
	echo "*     Es ist keine CD im Laufwerk !!!          *"
	echo "*                                              *"
	echo "************************************************"
exit
fi

# Change to the repository

if [ ! -d $_REPOSITORY_ROOT_DIR ]; then
	mkdir $_REPOSITORY_ROOT_DIR
fi

cd "$_REPOSITORY_ROOT_DIR"

# Gather options for burning

_OPTIONS=$(echo "--device" "$_DEVICE" "--driver" "$_DRIVER")

if [ "$_USE_RAW_MODE_BY_DEFAULT" = "TRUE" ] || [ "$_READ_SUBCHANNEL_DATA" = "TRUE" ]; then
	_OPTIONS=$(echo "$_OPTIONS" "--read-raw")

	if [ "$_READ_SUBCHANNEL_DATA" = "TRUE" ]; then
		_OPTIONS=$(echo "$_OPTIONS" "--read-subchan rw_raw")
	fi
fi

# Figure out the CD name

if [ -z  "$1" ]; then
	_CDNAME=$( mount | grep disk1 | awk '{print ($3)}' | awk 'BEGIN {FS="/"};{ print($3)}')
else
	_CDNAME="$1"
fi

if [ $_CDNAME = "CD" ]; then
	_CDNAME=$(echo "CD""$_DATE")
fi


if [ -d "$_CDNAME" ]; then
	_CDNAME=$( echo "$_CDNAME""$_DATE")
fi

#Create and change to the pProject dir

mkdir  "$_CDNAME"
cd "$_CDNAME"

#Now get to the real buisness

hdiutil unmount "$_BSD_DEVICE"

echo cdrdao read-cd "$_OPTIONS" "$_CDNAME".toc | bash

if [ "$?" != 0 ]; then

	if [ "$_USE_RAW_MODE_BY_DEFAULT" = "TRUE" ]; then

		echo "*************************************************"
		echo "*                                               *"
		echo "*     Die CD kann nicht gelesen werden !!       *"
		echo "*                                               *"
		echo "*************************************************"
		
		exit

	fi

	echo "******************************************************"
	echo "*                                                    *"
	echo "*       Das Lesen der CD ist gescheitert !           *"
	echo "* Ich versuche es gleich nochmal im RAW Modus !      *"
	echo "*                                                    *"
	echo "******************************************************"

	cdrdao read-cd --device IODVDServices --driver generic-mmc --read-subchan rw_raw --read-raw "$_CDNAME".toc

fi
    
