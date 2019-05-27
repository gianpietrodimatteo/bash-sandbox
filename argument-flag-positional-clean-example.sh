#!/bin/bash

while [ ! $# -eq 0 ]
do
	case "$1" in
		--help | -h)
			echo helpmenu
			exit
			;;
		--take-over-world | -t)
			echo secretopt
			exit
			;;
	esac
	shift
done