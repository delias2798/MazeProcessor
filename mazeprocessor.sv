import lc3b_types::*;

module mazeprocessor
(
	wishbone.master pmem_wb
);

/* Wishbone from Eviction Write Buffer to L2 */
wishbone eviction_wb_interconnect(pmem_wb.CLK);

/* Wishbone from L2 Cache to Interconnect */
wishbone l2_interconnect(pmem_wb.CLK);

/* Wishbone from L1 Cache to Interconnect */
wishbone imem_interconnect(pmem_wb.CLK);
wishbone dmem_interconnect(pmem_wb.CLK);

/* Wishbone from CPU to L1 Cache*/
wishbone imem_wb(pmem_wb.CLK);
wishbone dmem_wb(pmem_wb.CLK);

eviction_wb eviction_wb 
(
	.wb(pmem_wb),
	.cpu_wb(eviction_wb_interconnect)
);

l2_cache l2_cache
(
	.wb(eviction_wb_interconnect),
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