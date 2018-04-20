import lc3b_types::*;

module mazeprocessor
(
	wishbone.master pmem_wb
);

/* Wishbone from L1 Cache to Interconnect */
wishbone stream_interconnect(pmem_wb.CLK);
wishbone evict_interconnect(pmem_wb.CLK);

/* Wishbone from Eviction Write Buffer to L2 */
wishbone eviction_wb_interconnect(pmem_wb.CLK);

/* Wishbone from L2 Cache to Stream Buffer */
wishbone stream_wb_interconnect(pmem_wb.CLK);

/* Wishbone from L2 Cache to Interconnect */
wishbone l2_interconnect(pmem_wb.CLK);

/* Wishbone from L1 Cache to Interconnect */
wishbone imem_interconnect(pmem_wb.CLK);
wishbone dmem_interconnect(pmem_wb.CLK);

/* Wishbone from CPU to L1 Cache*/
wishbone imem_wb(pmem_wb.CLK);
wishbone dmem_wb(pmem_wb.CLK);

pmem_interconnect pmem_interconnect
(
	.clk(pmem_wb.CLK),
	.evict(evict_interconnect),
	.stream(stream_interconnect),
	.pmem(pmem_wb)
);

eviction_wb eviction_wb 
(
	.wb(evict_interconnect),
	.cpu_wb(eviction_wb_interconnect)
);

stream_wb stream_wb 
(
	.wb(stream_interconnect),
	.cpu_wb(stream_wb_interconnect)
);

l2_cache l2_cache
(
	.wb(eviction_wb_interconnect),
	.stream_wb(stream_wb_interconnect),
	.cpu_wb(l2_interconnect)
);

wb_interconnect wb_interconnect
(
	.clk(pmem_wb.CLK),
	.icache(imem_interconnect),
	.dcache(dmem_interconnect),
	.l2(l2_interconnect)
);

l1_cache l1_lcache
(
	.wb(imem_interconnect),
	.cpu_wb(imem_wb)
);

l1_cache l1_dcache
(
	.wb(dmem_interconnect),
	.cpu_wb(dmem_wb)
);

cpu c
(
	.imem_wb(imem_wb),
	.dmem_wb(dmem_wb)
);

endmodule: mazeprocessor