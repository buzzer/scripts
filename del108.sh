#!/bin/bash
_DEVICE=$( mount | grep disk1 | awk '{print ($1)}')

if [ -z $_DEVICE ]; then
        echo "************************************************"
        echo "*                                              *"
        echo "*     Es ist keine CD im Laufwerk !!!          *"
        echo "*                                              *"
        echo "************************************************"
exit
fi

hdiutil unmount "$_DEVICE"
cdrdao blank --device IODVDServices --driver generic-mmc 

