# Project 2: Implementing Cache Replacement Policy and evaluating its performance using AI Workloads 
## Team members 
Justin Ngo, Vamsi Kolla

## Project Description
This project is a comprehensive introduction to cache replacement policy. There
are two policies: Least Recently Used (LRU) and Least Frequently Used (LFU). 
Their performances will be evaluated using AI workloads.

## To make and run
1. make clean
2. make
3. ./Main {trace-file-name}.mem_trace

## Bash scripts to test all configurations against AI workloads
1. Download all AI workloads in a folder
2. There are two scripts, one for LRU and one for LFU: test_lru.sh and test_lfu.sh.
3. Run by: 
```./test_lru.sh <trace-folder-directory>```
4. If you want to save the output at the same time, do:
```./test_lru.sh <trace-folder-directory> | tee output_lru.txt```

## Comparing LRU and LFU output .txt files
1. There is a Python script to compare the two .txt output file: compare.py
2. To run it, do: ```python compare.py```
