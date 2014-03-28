#!/bin/bash

# CREATE EMPTY REPORT.TXT FILE
cd ../reports
touch report.txt
cd ../

# GET TEST CASE FILE LIST
cd ./testCases
testCaseList=`ls -v | grep "testCase"`

# ITERATE THROUGH EACH FILE IN TESTCASELIST
for file in $testCaseList
do
	# OPEN EACH FILE AND ITERATE THROUGH EACH LINE
	terminal=`tty`
	exec < $file
	row=1
	while read line
	do
		# GATHER TEST CASE INFORMATION
		case $row in
		[1]) testNum=$line;;
		[2]) requirements=$line;;
		[3]) component=$line;;
		[4]) methodName=$line;;
		[5]) inputs=$line;;
		[6]) expectedOut=$line;;
		esac
		row=`expr $row + 1`
	done
	exec < $terminal
	# WRITE THE INFORMATION TO REPORT.TXT
	cd ../reports
	echo $testNum >> report.txt
	echo $requirements >> report.txt
	echo $component >> report.txt
	echo "METHOD NAME: "$methodName >> report.txt
	echo "INPUT: "$inputs | sed 's/,/, /g' >> report.txt
	echo "EXPECTED OUTPUT: "$expectedOut >> report.txt
	echo "ACTUAL OUTPUT: " `cat ../temp/"OUT"$file` >> report.txt
	# DETERMINE IF OUTPUT AND ORACLES MATCH
	diff -q ../temp/"OUT"$file ../oracles/"ORACLE"$file
	if [ $? = 0 ]
	then
		result="PASS"
	else
		result="FAIL"
	fi
	echo "RESULT: "$result >> report.txt
	echo "" >> report.txt
	cd ../testCases
done


