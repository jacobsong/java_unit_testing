#!/bin/bash

# STORE THE RESULT INTO A FILE IN THE TEMP FOLDER

testCase=$1
output=$2

cd ../temp
touch "OUT"$testCase
echo $output >> "OUT"$testCase
cd ../testCases
