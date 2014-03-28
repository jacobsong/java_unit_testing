#!/bin/bash

# OPEN TEST CASE FILE AND ITERATE THROUGH EACH LINE

file=$1
terminal=`tty`
exec < ../testCases/$file
row=1
while read line
do
	# DETERMINE WHICH INPUT(S) IS BEING TESTED
	if [ $row = 5 ]
	then
		oldIFS=$IFS
		IFS=','
		for param in $line
		do
			inputList="$inputList'$param',"
		done
		IFS=$oldIFS
	fi
	row=`expr $row + 1`
done
exec < $terminal
echo $inputList
