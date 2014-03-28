#!/bin/bash

# CLEAR OUT TEMP, REPORTS, AND ORACLES FOLDER

clear
echo "Clearing temp, reports, oracles and compiled class files..."
rm 2>/dev/null ../temp/*
rm 2>/dev/null -r ../reports/*
rm 2>/dev/null -r ../oracles/*
cd ../src
ls | grep -v java | xargs rm 2>/dev/null #Remove everything but uncompiled .java files

