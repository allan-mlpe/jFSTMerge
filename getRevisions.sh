#!/bin/bash
projectLocation="/c/Users/Allan/Documents/mestrado/2017-1/TAES3/repo/django"

cd ..
scenariosLocation=$(pwd)

scenarioName=$1
left=$2
base=$3
right=$4


function buildScenario {

	echo "Getting left revision according to $left commit..."
	eval "git checkout -f $left ."
	cp -rf * $scenariosLocation/scenarios/$scenarioName/left

	echo "Getting base revision according to $base commit..."
	eval "git checkout -f $base ."
	cp -rf * $scenariosLocation/scenarios/$scenarioName/base

	echo "Getting right revision according to $right commit..."
	eval "git checkout -f $right ."
	cp -rf * $scenariosLocation/scenarios/$scenarioName/right

	echo "Creating .revisions file..."
	echo left >> $scenariosLocation/scenarios/$scenarioName/scenario.revisions
	echo base >> $scenariosLocation/scenarios/$scenarioName/scenario.revisions
	echo right >> $scenariosLocation/scenarios/$scenarioName/scenario.revisions

	echo "Merge scenario has built successfully in scenarios/$scenarioName!"	
}


#check if there is already a scenarios directory in parent directory
scenariosExists=$(ls -1 | grep scenarios)
if [ -z  "${scenariosExists//}" ]; then
	mkdir scenarios
fi

#check if there is a scenario with name passed in script call
scenarioExists=$(ls -1 scenarios/ | grep $scenarioName)
if [ -z  "${scenarioExists//}" ]; then
	mkdir scenarios/$scenarioName
	mkdir scenarios/$scenarioName/left/
	mkdir scenarios/$scenarioName/base/
	mkdir scenarios/$scenarioName/right/
else
	echo "ERROR: there is already a scenario named $scenarioName. Please enter other name to current scenario."
	#rm -f ./.git/index.lock
	exit 1
fi

cd $projectLocation
buildScenario