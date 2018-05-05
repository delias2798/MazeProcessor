# Maze Processor

## Introduction

As a capstone project, we incorporated the concepts learnt in ECE 411 to design a pipelined microprocessor. Our task for this machine problem was to design a 5-stage pipelined processor that supported the LC3b Instruction Set Architecture(ISA) and to incorporate features that helped our processor to efficiently run the test codes without compromising our processor's frequency.

## Project overview

The processor consists of 5-stages in its pipeline, namely: Instruction Fetch, Instruction Decode, Execute, Memory Access and Write Back. The processor also contains a cache hierarchy with a split L1 cache and a unified L2 cache. It also performs hazard detection (control, structural and data) as well as incorporates data forwarding and branch prediction.

## Design description

### Overview

The datapath contains registers between each stage to provide instruction-level parallelism in a single processor. Following are the stages of the pipeline with their respective functionality:

#### Fetch Stage

We read the instruction from the memory whose address is specified by the program counter. It also contains a branch prediction unit which assists in predicting which way a branch will go before it is known definitively.

#### Decode Stage

We decode the instruction and access the register file for the registers used in the instruction. Our pipeline is controlled by using a read-only control memory which is propagated through the different stage registers and is accessed in the decode stage.

#### Execute Stage

All arithmetic calculations for each LC3b instruction happens in the execute stage. The execute stage also contains a data forwarding unit which receives values from the memory stage as well as the write back stage.

#### Memory Stage

The memory stage accesses the memory in the case of a load, store and trap instruction. It also generates a stall signal when it waits for a response from memory as well as houses a forwarding unit that gets data from the write back stage.

#### Write Back Stage

The final stage is the write back stage, which commits the values to the register unit as well as resolves the branches and sets the program counter in the case of a mis-prediction.

### Advanced design options

#### Tournament Branch Prediction

We incorporated a tournament branch predictor which tried to guess which way a branch will be resolved. It uses a selector to choose the prediction outcome of either a local or a global branch predictor. The global prediction unit is based on gshare where the history table is indexed by xor of branch PC and outcome of last four branches. The local prediction unit is indexed by 6 LSBs of branch PC. We use a 2-bit prediction scheme in both the local and global history table so that prediction only changes if it gets mispredicted twice. On branch resolution, the selector is updated based on the prediction correctness of the two predictors.

#### 4-way Branch Target Buffer

We used a 4-way branch target buffer to store the predicted target of a program counter based on previous outcomes. In case of a branch taken prediction by the tournament predictor and a hit in BTB, the predicted PC is loaded into the next PC. It is updated on branch resolution if the branch is resolved to be taken.

#### 4-Way Set Associative Unified L2 Cache

We decided to use a 4-way set associative write-back cache with a pseudo-LRU policy for our unified L2 cache. Our cache had 16 sets, with each line of size 128 bits, the size of our wishbone, which made the size of our L2 cache 1kB. Our split L1 cache connected to the L2 cache used an interconnect which gave priority to the instructions and serviced data requests when the instructions were being read from the L1 instruction cache. Our decision to use only 16 sets was taken keeping in mind that a larger cache size could potentially reduce our frequency.

#### 4-Way Fully Associative Victim Cache

We modified the eviction write buffer to a victim cache so that it stored non-dirty evicted entries in L2 as well. The victim cache is a fully-associative 4-way unit that is designed to decrease conflict misses in L2. It gets populated when data is evicted from L2. If data needs to be evicted from L2, victim cache stores the evicted line. If the victim cache is full then it first evicts the least recently used data to physical memory before storing the evicted data from L2. Otherwise, it stores the evicted L2 data in an empty slot. On a miss in L2, victim cache is looked up. If it's a hit then the data is sent back to L2 with only one cycle penalty. Otherwise, physical memory is accessed to send the data to L2.

#### Hardware Prefetching

We added a hardware prefetcher in between our L2 cache and physical memory. The responsibility of this unit is to perform sequential prefetching and fetch instructions before they are needed. We use a stream buffer based on one block lookahead (OBL) prefetch which initiates a prefetch for line i+1 whenever the line i is accessed and results in a cache miss. Using a stream buffer, also prevents cache pollution by storing prefetched data in a separate buffer. We use a scheduler to service either the hardware prefetcher request or the victim cache request. The priority is given to victim cache and only when there is no request from victim cache, request from prefetcher is served.

#### Memory Stage Leapfrogging

We modified our CPU pipeline to allow independent instructions to jump past the memory stage when there is a data cache miss. This required us to add a unit in the execute stage which looked at the condition codes and forwarded an instruction directly to write-back stage if there is a stall due to memory stage. We also modified our forwarding unit to account for register updates in case of a leapfrogged instruction.

## Conclusion

Our processor managed to run all the test codes successfully with a frequency of 105.4 MHz. All in all, we were quite happy with our processor's performance.
