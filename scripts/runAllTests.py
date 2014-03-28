#!/usr/bin/python
import sys
import commands
import os

# CLEAR OUT TEMP, REPORTS, AND ORACLES FOLDER BEFORE RUNNING
print commands.getoutput('bash clearFiles.sh')

# COMPILE ALL SOURCE FILES IN SRC FOLDER
print commands.getoutput('javac -cp ../lib/* ../src/java/*.java')

# GET THE LIST OF TESTCASE FILES AND PUT INTO TESTCASELIST
testCaseList = commands.getoutput('bash getTestCases.sh')
testCaseList = testCaseList.split("\n")

# ITERATE THROUGH EACH FILE IN TESTCASELIST IF IT IS NOT EMPTY
if len(testCaseList) > 1 and len(testCaseList[0]) > 0:
	for testCase in testCaseList:
		# GRAB THE METHOD BEING TESTED
		methodName = commands.getoutput('bash getMethodName.sh ' + testCase)
		# GRAB THE INPUT(S) BEING TESTED
		inputList = commands.getoutput('bash getInputs.sh ' + testCase)
		# CREATE ORACLES
		commands.getoutput('bash createOracle.sh ' + testCase)
		# SPLIT THE INPUT LIST IF THERE ARE MULTIPLE INPUTS
		inputList = inputList.split(",")
		# CONSTRUCT THE JAVA COMMAND WITH THE METHOD AND INPUT(S)
		javaCMD = "java src.java." + methodName + "Driver"
		for param in inputList:
			javaCMD = javaCMD + " " + param
		# RUN THE JAVA COMMAND
		os.chdir("../")
		output = commands.getoutput(javaCMD)
		os.chdir("./scripts")
		print testCase + ".........." + "COMPLETED"
		# SAVE THE OUTPUT OF THE JAVA COMMAND INTO A FILE IN TEMP
		commands.getoutput('bash storeOutput.sh ' + testCase + " " + "'"+output+"'")

	# USE FILES IN TEMP TO WRITE A REPORT.TXT FILE
	commands.getoutput('bash createReport.sh')
	print "\nCheck reports folder for testing report"
	# CONVERT THE TXT FILE TO AN HTML FILE AND OPEN IT
	print "Launching Firefox...\n"
	commands.getoutput('groovy htmlParser.groovy ../reports/report.txt ../reports/report.html')
else:
	print "There are no test cases to run...\n"

