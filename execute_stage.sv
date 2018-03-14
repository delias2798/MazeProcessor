import lc3b_types::*;

module execute_stage
(
	input clk,
	input lc3b_offset9 offset9,
	input lc3b_offset11 offset11,
	input lc3b_word pc,
	input lc3b_word sr1,
	input lc3b_word sr2,
	input lc3b_offset8 offset8,
	input lc3b_word dest_out,
	
	/* Input Control Signals */
	input bradd2mux_sel,
	input lc3b_aluop aluop,
	input alumux_sel,

	output lc3b_word br_add_out,
	output lc3b_word bradd2mux_out,
	output lc3b_word alumux_out,
	output lc3b_word destmux_out
);

/* Internal Signals */
lc3b_word adj9_out;
lc3b_word adj11_out;
lc3b_word br_add2_out;
lc3b_word alu_out;
lc3b_word zext_s8_out;
lc3b_word dest_lfsh_out;

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
	.b(sr1),
	.f(bradd2mux_out)
);

alu arith_unit
(
	.aluop(aluop),
	.a(sr1),
	.b(sr2),
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

assign dest_lfsh_out = dest_out << 8;

mux2 destmux
(
	.sel(alumux_out[0]),
	.a(dest_out),
	.b(dest_lfsh_out),
	.f(destmux_out)
);

endmodule: execute_stage