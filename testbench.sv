module testbench;

timeunit 1ns;
timeprecision 1ns;

logic clk;

initial clk = 0;
always #5 clk = ~clk;

wishbone imem(clk);
wishbone dmem(clk);

magic_memory mem(
	.ifetch(imem.slave),
	.memory(dmem.slave)
);

mazeprocessor processor(
	.imem_wb(imem.master),
	.dmem_wb(dmem.master)
);

endmodule : testbench