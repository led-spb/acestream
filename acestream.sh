#!/bin/bash

ACEHOME="`dirname \"$0\"`"
ACECHROOT="androidfs"

function start() { 
  mount -t proc proc $ACEHOME/$ACECHROOT/proc
  mount -t sysfs sysfs $ACEHOME/$ACECHROOT/sys
  mount -o bind /dev $ACEHOME/$ACECHROOT/dev

  chroot --userspec=pi $ACEHOME/$ACECHROOT /system/bin/sh -c "cd /system/data/data/org.acestream.engine/files ; /system/bin/acestream.sh start.py" 2>&1
}

function stop() {
  umount $ACEHOME/$ACECHROOT/dev
  umount $ACEHOME/$ACECHROOT/sys
  umount $ACEHOME/$ACECHROOT/proc
}



case "$1" in 
   "start")
       start
       ;;
   "stop")
       stop
       ;;
esac
