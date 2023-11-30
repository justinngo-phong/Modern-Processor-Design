#!/bin/bash

# Configuration values
cacheSizes=(128 128 128 256 256 256 512 512 512 1024 1024 1024 2048 2048 2048) 
assocs=(4 8 16 4 8 16 4 8 16 4 8 16 4 8 16)

if [ -z "$1" ]; then
	echo "Usage: $0 <path_to_trace_folder>"
	exit 1
fi

trace_folder="$1"

# Change configuration in Cache.h
# Uncomment #define LRU and comment out #define LFU
sed -i 's/\/\/#define LRU/#define LRU/' Cache.h
sed -i '/^ *#define LFU/s/^#/\/\/#/' Cache.h

# Loop through configurations
echo "Workload: $trace_folder/531.deepsjeng_r_llc.mem_trace"
for i in "${!cacheSizes[@]}"; do
	cacheSize="${cacheSizes[$i]}"
	assoc="${assocs[$i]}"

	# Set configurations in Cache.c
	sed -i "s/const unsigned cache_size = [0-9]\+;/const unsigned cache_size = $cacheSize;/" Cache.c
	sed -i "s/const unsigned assoc = [0-9]\+;/const unsigned assoc = $assoc;/" Cache.c

	# Recompile
	printf "\nRecompiling\n"
	make clean
	make

	# Run tests with the specified format
	printf "\nRunning tests for cache_size = $cacheSize and assoc = $assoc\n"
	#./Main sample.mem_trace
	#if false; then
	echo "------------------------------"
	./Main "$trace_folder/531.deepsjeng_r_llc.mem_trace"
	echo "------------------------------"
	#fi
done

echo "Workload: $trace_folder/541.leela_r_llc.mem_trace"
for i in "${!cacheSizes[@]}"; do
	cacheSize="${cacheSizes[$i]}"
	assoc="${assocs[$i]}"

	# Set configurations in Cache.c
	sed -i "s/const unsigned cache_size = [0-9]\+;/const unsigned cache_size = $cacheSize;/" Cache.c
	sed -i "s/const unsigned assoc = [0-9]\+;/const unsigned assoc = $assoc;/" Cache.c

	# Recompile
	printf "\nRecompiling\n"
	make clean
	make

	# Run tests with the specified format
	printf "\nRunning tests for cache_size = $cacheSize and assoc = $assoc\n"
	#./Main sample.mem_trace
	#if false; then
	echo "------------------------------"
	./Main "$trace_folder/541.leela_r_llc.mem_trace"
	echo "------------------------------"
	#fi
done

echo "Workload: $trace_folder/548.exchange2_r_llc.mem_trace"
for i in "${!cacheSizes[@]}"; do
	cacheSize="${cacheSizes[$i]}"
	assoc="${assocs[$i]}"

	# Set configurations in Cache.c
	sed -i "s/const unsigned cache_size = [0-9]\+;/const unsigned cache_size = $cacheSize;/" Cache.c
	sed -i "s/const unsigned assoc = [0-9]\+;/const unsigned assoc = $assoc;/" Cache.c

	# Recompile
	printf "\nRecompiling\n"
	make clean
	make

	# Run tests with the specified format
	printf "\nRunning tests for cache_size = $cacheSize and assoc = $assoc\n"
	#./Main sample.mem_trace
	#if false; then
	echo "------------------------------"
	./Main "$trace_folder/548.exchange2_r_llc.mem_trace"
	echo "------------------------------"
	#fi
done
