#!/bin/bash

# Configuration values
localHistoryTableSizes=(2048 4096 4096)
globalPredictorSizes=(8192 8192 16384)
choicePredictorSizes=(8192 8192 16384)

# Loop through configurations
for i in "${!localHistoryTableSizes[@]}"; do
	printf "\nRecompiling\n"
	localHistoryTableSize="${localHistoryTableSizes[$i]}"
	globalPredictorSize="${globalPredictorSizes[$i]}"
	choicePredictorSize="${choicePredictorSizes[$i]}"

	# Set configurations in Branch_Predictor.c
	sed -i "s/const unsigned localHistoryTableSize = [0-9]\+;/const unsigned localHistoryTableSize = $localHistoryTableSize;/" Branch_Predictor.c
	sed -i "s/const unsigned globalPredictorSize = [0-9]\+;/const unsigned globalPredictorSize = $globalPredictorSize;/" Branch_Predictor.c
	sed -i "s/const unsigned choicePredictorSize = [0-9]\+;/const unsigned choicePredictorSize = $choicePredictorSize;/" Branch_Predictor.c

	# Recompile
	make clean
	make

	# Run tests with the specified format
	printf "\nRunning tests for localHistoryTableSize = $localHistoryTableSize, globalPredictorSize = $globalPredictorSize, choicePredictorSize = $choicePredictorSize\n"
	echo "------------------------------"
	echo "Workload: trace_folder/531.deepsjeng_r_branches.cpu_trace"
	./Main trace_folder/531.deepsjeng_r_branches.cpu_trace
	echo "------------------------------"
	echo "Workload: trace_folder/541.leela_r_branches.cpu_trace"
	./Main trace_folder/541.leela_r_branches.cpu_trace
	echo "------------------------------"
	echo "Workload: trace_folder/548.exchange2_r_branches.cpu_trace"
	./Main trace_folder/548.exchange2_r_branches.cpu_trace
	echo "------------------------------"
done
