def parse_hit_rates(filename):
	hit_rates = [[0,0,0] for _ in range(15)]

	with open(filename, 'r') as file:
		lines = file.readlines()
		len_file = len(lines)

	config_idx = -1
	workload_idx = 0
	i = 0

	while i < len_file and config_idx < 15:
		line = lines[i]

		if "Recompiling" in line:
			config_idx += 1
		elif "Hit rate" in line:
			hit_rate = line.strip().split(':')[1].strip()
			hit_rate = float(hit_rate.rstrip("%"))
			hit_rates[config_idx][workload_idx] = hit_rate
			workload_idx += 1
			if workload_idx >= 3:
				workload_idx = 0
		
		i += 1

	#print(hit_rates)
	return hit_rates


if __name__ == "__main__":
	file1 = "./output_lru.txt"
	file2 = "./output_lfu.txt"

	lru_hit_rates = parse_hit_rates(file1)
	lfu_hit_rates = parse_hit_rates(file2)
	
	cache_sizes = []

	for i in range(7,12):
		temp = [2**i] * 3
		cache_sizes += temp

	assocs = [4, 8, 16] * 5
	print(cache_sizes, assocs)

	for i in range(15):
		print("Configuration: Cache Size = {}, Assoc = {}".format(cache_sizes[i], assocs[i]))
		print("----------------------------------------------------------------")

		print("Workload: /531.deepsjeng_r_llc.mem_trace")
		lru_rate = lru_hit_rates[i][0]
		lfu_rate = lfu_hit_rates[i][0]
		print("LRU hit rate: {}, LFU hit rate: {}".format(lru_rate,lfu_rate))
		if lru_rate > lfu_rate:
			print("LRU better")
		elif lfu_rate > lru_rate:
			print("LFU better")
		else:
			print("Same hit rate")
		print("\n")

		print("Workload: /541.leela_r_llc.mem_trace")
		lru_rate = lru_hit_rates[i][1]
		lfu_rate = lfu_hit_rates[i][1]
		print("LRU hit rate: {}, LFU hit rate: {}".format(lru_rate,lfu_rate))
		if lru_rate > lfu_rate:
			print("LRU better")
		elif lfu_rate > lru_rate:
			print("LFU better")
		else:
			print("Same hit rate")
		print("\n")
		
		print("Workload: /548.exchange2_r_llc.mem_trace")
		lru_rate = lru_hit_rates[i][2]
		lfu_rate = lfu_hit_rates[i][2]
		print("LRU hit rate: {}, LFU hit rate: {}".format(lru_rate,lfu_rate))
		if lru_rate > lfu_rate:
			print("LRU better")
		elif lfu_rate > lru_rate:
			print("LFU better")
		else:
			print("Same hit rate")
		print("\n")
