#!/bin/bash

# OPEN TEST CASE FILE AND ITERATE THROUGH EACH LINE

file=$1
terminal=`tty`
exec < ../testCases/$file
row=1
while read line
do
	# CREATE ORACLES USING EXPECTED OUTPUT IN TEST CASE FILE
	if [ $row = 6 ]
	then 	
		cd ../oracles
		touch "ORACLE"$file
		echo $line >> "ORACLE"$file
		cd ../testCases
	fi
	row=`expr $row + 1`
done
exec < $terminal
