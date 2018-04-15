import lc3b_types::*;

module write_back_stage
(
	input clk,
	input lc3b_word pc_br,
	input lc3b_word pc,
	input lc3b_word dmem_address,
	input lc3b_word dmem_wdata,
	input lc3b_word alu_out,
	input lc3b_reg dest_register,
	input lc3b_word new_pc_mem_wb_out,
	input lc3b_word predicted_pc_mem_wb_out,
	input branch_prediction_mem_wb_out,
	
	/* Input Control Signals */
	input lc3b_opcode opcode,
	input load_cc,
	input [2:0] regfilemux_sel,

	output lc3b_word write_data,
	output logic branch_enable,
	output logic control_flush,
	output lc3b_word new_pc_after_flush
);

/* Internal Signals */
lc3b_nzp gencc_out;
lc3b_nzp cc_out;
lc3b_byte mdrmux2_out;
lc3b_word mdrzext_out;
logic branch_signal;

mux2 #(.width(8)) mdrmux
(
	.sel(dmem_address[0]),
   .a(dmem_wdata[7:0]),
   .b(dmem_wdata[15:8]),
   .f(mdrmux2_out)
);

zext mdrzext
(
	.in(mdrmux2_out),
	.out(mdrzext_out)
);

mux8 regfilemux
(
	.sel(regfilemux_sel),
	.a(alu_out),
	.b(dmem_wdata),
	.c(pc),
	.d(pc_br),
	.e(mdrzext_out),
	.f(mdrzext_out),
	.g(mdrzext_out),
	.h(mdrzext_out),
	.o(write_data)
);

gencc gen_cc
(
	.in(write_data),
	.out(gencc_out)
);

register #(.width(3)) cc
(
	.clk,
   .load(load_cc),
   .in(gencc_out),
   .out(cc_out)
);

cc_comp cccomp
(
	.dest(dest_register),
	.cc_out(cc_out),
	.branch_enable(branch_signal)
);

/* Check if opcode is branch/jsr/jsrr/jmp/trap. */
assign branch_enable = (branch_signal && (opcode == op_br)) || (opcode == op_jmp) || (opcode == op_jsr) || (opcode == op_trap);
assign new_pc_after_flush = branch_enable ? new_pc_mem_wb_out : pc;

always_comb
begin
	control_flush = 0;
	if (branch_enable && (new_pc_mem_wb_out != predicted_pc_mem_wb_out))
		control_flush = 1;
		
	if (!branch_enable && (new_pc_mem_wb_out == predicted_pc_mem_wb_out) && branch_prediction_mem_wb_out)
		control_flush = 1;
end

endmodule: write_back_stage