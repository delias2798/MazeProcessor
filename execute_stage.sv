import lc3b_types::*;

module execute_stage
(
	input clk,
	input lc3b_offset9 offset9,
	input lc3b_offset11 offset11,
	input lc3b_word pc,
	input lc3b_word alu_ex_mem_out,
	input lc3b_word pc_br_ex_mem_out,
	input lc3b_word pc_ex_mem_out,
	input lc3b_word write_data,
	input lc3b_word sr1,
	input lc3b_word sr2,
	input lc3b_word sr2mux_out,
	input lc3b_offset8 offset8,
	input lc3b_word dest_out,
	
	/* Input Control Signals */
	input [1:0] sr1_forward_sel,
	input [1:0] sr2_forward_sel,
	input pc_forward_sel,
	input dest_forward_sel,
	input bradd2mux_sel,
	input lc3b_aluop aluop,
	input sr2mux_sel,
	input alumux_sel,

	output lc3b_word br_add_out,
	output lc3b_word bradd2mux_out,
	output lc3b_word alumux_out,
	output lc3b_word destmux_out
);

/* Internal Signals */
lc3b_word pc_forward_mux_out;
lc3b_word sr1_forward_mux_out;
lc3b_word sr2_forward_mux_out;
lc3b_word adj9_out;
lc3b_word adj11_out;
lc3b_word br_add2_out;
lc3b_word alu_out;
lc3b_word zext_s8_out;
lc3b_word sr2mux2_out;

mux2 pc_forwardmux
(
	.sel(pc_forward_sel),
	.a(pc_br_ex_mem_out),
	.b(pc_ex_mem_out),
	.f(pc_forward_mux_out)
);

mux4 sr1_forward
(
	.sel(sr1_forward_sel),
	.a(sr1),
	.b(write_data),
	.c(alu_ex_mem_out),
	.d(pc_forward_mux_out),
	.f(sr1_forward_mux_out)
);

mux4 sr2_forward
(
	.sel(sr2_forward_sel),
	.a(sr2),
	.b(write_data),
	.c(alu_ex_mem_out),
	.d(pc_forward_mux_out),
	.f(sr2_forward_mux_out)
);

adj #(.width(9)) adj9
(
	.in(offset9),
	.out(adj9_out)
);

adj #(.width(11)) adj11
(
	.in(offset11),
	.out(adj11_out)
);

br_add bradd
(
	.offset9(adj9_out),
	.pc(pc),
	.out(br_add_out)
);

br_add bradd2
(
	.offset9(adj11_out),
	.pc(pc),
	.out(br_add2_out)
);

mux2 bradd2mux
(
	.sel(bradd2mux_sel),
	.a(br_add2_out),
	.b(sr1_forward_mux_out),
	.f(bradd2mux_out)
);

mux2 sr2mux2
(
	.sel(sr2mux_sel),
	.a(sr2_forward_mux_out),
	.b(sr2mux_out),
	.f(sr2mux2_out)
);

alu arith_unit
(
	.aluop(aluop),
	.a(sr1_forward_mux_out),
	.b(sr2mux2_out),
	.f(alu_out)
);

zext_s zext_s8
(
	.in(offset8),
	.out(zext_s8_out)
);

mux2 alumux
(
	.sel(alumux_sel),
	.a(alu_out),
	.b(zext_s8_out),
	.f(alumux_out)
);

mux2 dest_forwardmux
(
	.sel(dest_forward_sel),
	.a(dest_out),
	.b(write_data),
	.f(destmux_out)
);

endmodule: execute_stage