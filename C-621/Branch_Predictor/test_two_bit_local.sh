#!/bin/bash

# Configuration values
localPredictorSizes=(2048 2048 4096 8192 16384 32768 65536)
localCounterBits=(1 2 2 2 2 2 2)

# Loop through configurations
for i in "${!localPredictorSizes[@]}"; do
	printf "\nRecompiling\n"
	localPredictorSize="${localPredictorSizes[$i]}"
	localCounterBit="${localCounterBits[$i]}"

	if [ -z "$1" ]; then
		echo "Usage: $0 <path_to_trace_folder>"
		exit 1
	fi

	trace_folder="$1"

	# Set configurations in Branch_Predictor.c
	sed -i "s/const unsigned localPredictorSize = [0-9]\+;/const unsigned localPredictorSize = $localPredictorSize;/" Branch_Predictor.c
	sed -i "s/const unsigned localCounterBits = [0-9]\+;/const unsigned localCounterBits = $localCounterBit;/" Branch_Predictor.c

	# Recompile
	make clean
	make

	# Run tests with the specified format
	printf "\nRunning tests for localPredictorSize = $localPredictorSize, localCounterBits = $localCounterBit\n"
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
