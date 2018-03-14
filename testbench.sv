module testbench;

timeunit 1ns;
timeprecision 1ns;

logic clk;

initial clk = 0;
always #5 clk = ~clk;

wishbone pmem(clk);

/*
magic_memory mem(
	.ifetch(imem.slave),
	.memory(dmem.slave)
);
*/

physical_memory pm (pmem);

mazeprocessor processor(pmem);

endmodule : testbench