import lc3b_types::*;

module fetch_stage
(
	input clk,
	input lc3b_data imem_rdata,
	input lc3b_word new_pc,
	input branch_enable,
	input mem_stall,
	input imem_resp,
	output lc3b_word imem_address,
	output logic imem_action_stb,
	output logic imem_action_cyc,
	output lc3b_word pc_plus2_out,
	output lc3b_word imem_rdata_out
);

/* Control Signals */
logic load_pc;
logic imem_stall;

assign load_pc = !mem_stall & imem_resp;
assign imem_action_cyc = load_pc;
assign imem_action_stb = load_pc;

/* Internal Signals */
lc3b_word pc_in;

mux2 pc_mux
(
	.sel(branch_enable),
	.a(pc_plus2_out),
	.b(new_pc),
	.f(pc_in)
);

plus2 pc_plus2
(
	.in(imem_address),
	.out(pc_plus2_out)
);

register pc_regsiter
(
	.clk(clk),
	.load(load_pc),
	.in(pc_in),
	.out(imem_address)
);

mux8 imem_rdata_mux
(
	.sel(imem_address[3:1]),
	.a(imem_rdata[15:0]),
	.b(imem_rdata[31:16]),
	.c(imem_rdata[47:32]),
	.d(imem_rdata[63:48]),
	.e(imem_rdata[79:64]),
	.f(imem_rdata[95:80]),
	.g(imem_rdata[111:96]),
	.h(imem_rdata[127:112]),
	.o(imem_rdata_out)
);

endmodule: fetch_stage