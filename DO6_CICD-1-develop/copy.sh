#!/bin/bash

scp ./src/cat/s21_cat ./src/grep/s21_grep fernandg@192.168.1.103:/home/fernandg
if [ $? -ne 0 ]; then
	echo "ERROR with copy files!"
	exit 1
else
	echo "Files copied to wm2"
fi

ssh fernandg@192.168.1.103 <<EOF
	echo 123qweasdzxc | sudo -S mv s21_cat s21_grep /usr/local/bin
EOF

if [ -f /usr/local/bin/s21_cat ] && [ -f /usr/local/bin/s21_grep ]; then
	echo "Files found in /usr/local/bin"
	exit
else
	echo "Files not found"
	exit 1
fi

exit
