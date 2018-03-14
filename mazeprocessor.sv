import lc3b_types::*;

module mazeprocessor
(
	wishbone.master pmem_wb
);

/* Wishbone from L1 Cache to Interconnect */
wishbone imem_interconnect(pmem_wb.CLK);
wishbone dmem_interconnect(pmem_wb.CLK);

/* Wishbone from CPU to L1 Cache*/
wishbone imem_wb(pmem_wb.CLK);
wishbone dmem_wb(pmem_wb.CLK);

interconnect wishbone_interconnect
(
	.clk(clk),
	.icache(imem_interconnect),
	.dcache(dmem_interconnect),
	.dram(pmem_wb)
);

cache l1_lcache
(
	.wb(imem_interconnect),
	.cpu_wb(imem_wb)
);

cache l1_dcache
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