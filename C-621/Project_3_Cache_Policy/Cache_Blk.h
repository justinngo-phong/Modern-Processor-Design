#ifndef __CACHE_BLK_H__
#define __CACHE_BLK_H__

#define __STDC_FORMAT_MACROS
#include <inttypes.h> // uint64_t

#include <stdbool.h>

typedef struct Cache_Block
{
    uint64_t tag;

    bool valid; // Is this block valid?
    bool dirty; // Has this block been modified?

    uint64_t when_touched; // The last time this block is referenced.
    uint64_t frequency; // How many times this block is referenced.

    uint32_t set; // Which set this block belongs to?
    uint32_t way; // Which way (within this set) belongs to?

    // Advanced Features
    uint64_t PC; // Which instruction that brings in this block?
    int core_id; // Which core the instruction is running on.

	// Signature-based Hit Indicator variables
	bool outcome; // Determines whether the signature has been re-referenced after insertion.
	unsigned signature_m; // The signature of each instruction, which is hashed by the instruction's PC.
}Cache_Block;

#endif
