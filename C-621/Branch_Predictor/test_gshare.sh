#!/bin/bash

# Configuration values
globalPredictorSizes=(8192 16384 32768 65536)

# Loop through configurations
for i in "${!globalPredictorSizes[@]}"; do
	printf "\nRecompiling\n"
	globalPredictorSize="${globalPredictorSizes[$i]}"
	if [ -z "$1" ]; then
		echo "Usage: $0 <path_to_trace_folder>"
		exit 1
	fi

	trace_folder="$1"

	# Set configurations in Branch_Predictor.c
	sed -i "s/const unsigned globalPredictorSize = [0-9]\+;/const unsigned globalPredictorSize = $globalPredictorSize;/" Branch_Predictor.c

	# Recompile
	make clean
	make

	# Run tests with the specified format
	printf "\nRunning tests for globalPredictorSize = $globalPredictorSize\n"
	echo "------------------------------"
	echo "Workload: $trace_folder/531.deepsjeng_r_branches.cpu_trace"
	./Main "$trace_folder/531.deepsjeng_r_branches.cpu_trace"
	echo "------------------------------"
	echo "Workload: $trace_folder/541.leela_r_branches.cpu_trace"
	./Main "$trace_folder/541.leela_r_branches.cpu_trace"
	echo "------------------------------"
	echo "Workload: $trace_folder/548.exchange2_r_branches.cpu_trace"
	./Main "$trace_folder/548.exchange2_r_branches.cpu_trace"
	echo "------------------------------"
done
