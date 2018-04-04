import lc3b_types::*;

module decode_stage
(
	input clk,
	input lc3b_word instruction,
	input lc3b_reg write_register,
	input lc3b_word write_data,
	input load_regfile,
	
	input hazard_stall,
	
	output lc3b_offset8 offset8,
	output lc3b_offset9 offset9,
	output lc3b_offset11 offset11,
	output lc3b_control_word ctrl,
	output lc3b_reg sr1_in,
	output lc3b_reg sr2_in,
	output lc3b_reg dest,
	output lc3b_word sr1_out,
	output lc3b_word sr2_out,
	output lc3b_word sr2mux_out,
	output lc3b_word dest_out
);

/* Control Signals */
logic [1:0] sr2mux_sel;

/* Internal Signals*/
lc3b_opcode opcode;

lc3b_offset4 offset4;
lc3b_offset5 offset5;
lc3b_offset6 offset6;

lc3b_word zext4_out;
lc3b_word sext5_out;
lc3b_word sext6_out;
lc3b_word adj6_out;

lc3b_control_word ctrl_out;

ir inst_reg
(
	.in(instruction),
	.opcode(opcode),
	.dest(dest),
	.src1(sr1_in),
	.src2(sr2_in),
	.offset4(offset4),
	.offset5(offset5),
	.offset6(offset6),
	.offset8(offset8),
	.offset9(offset9),
	.offset11(offset11)
);

control_rom ctrl_r
(
	.opcode(opcode),
	.dest_register(instruction[11:9]),
	.ir4(instruction[4]),
	.ir5(instruction[5]),
	.ir11(instruction[11]),
	.ctrl(ctrl_out)
);

/* Insert a NOP */
assign ctrl = hazard_stall ? 1'b0 : ctrl_out;

assign sr2mux_sel = ctrl.sr2mux_sel;

regfile reg_file
(
	.clk(clk),
	.load(load_regfile),
	.dest(write_register),
	.data_in(write_data),
	.src_a(sr1_in),
	.src_b(sr2_in),
	.src_c(dest),
	.reg_a(sr1_out),
	.reg_b(sr2_out),
	.reg_c(dest_out)
);

zext #(.width(4)) zext4
(
	.in(offset4),
	.out(zext4_out)
);

sext #(.width(5)) sext5
(
	.in(offset5),
	.out(sext5_out)
);

sext #(.width(6)) sext6
(
	.in(offset6),
	.out(sext6_out)
);

adj #(.width(6)) adj6
(
	.in(offset6),
	.out(adj6_out)
);

mux4 sr2mux
(
	.sel(sr2mux_sel),
	.a(adj6_out),
	.b(sext6_out),
	.c(sext5_out),
	.d(zext4_out),
	.f(sr2mux_out)
);

endmodule: decode_stage