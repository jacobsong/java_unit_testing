#!/bin/bash

# OPEN TEST CASE FILE AND ITERATE THROUGH EACH LINE

file=$1
terminal=`tty`
exec < ../testCases/$file
row=1
while read line
do
	# DETERMINE WHICH METHOD IS BEING TESTED
	if [ $row = 4 ]
	then 	
		methodName=$line
	fi
	row=`expr $row + 1`
done
exec < $terminal
echo $methodName
