import lc3b_types::*;

module mazeprocessor
(
	wishbone.master imem_wb,
	wishbone.master dmem_wb
);

cpu c
(
	.imem_wb(imem_wb),
	.dmem_wb(dmem_wb)
);

endmodule: mazeprocessor