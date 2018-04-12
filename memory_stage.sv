import lc3b_types::*;

module memory_stage
(
	input clk,
	input load_ex_mem,
	input lc3b_word alu_out,
	input lc3b_word pc_br_out,
	input lc3b_word pc_j_out,
	input lc3b_data dmem_rdata,
	input lc3b_word dest_out,
	input dmem_resp,
	input lc3b_word write_data,
	input lc3b_reg dest_register,
	
	/* Control Signals */
	input [1:0] newpcmux_sel,
	input lc3b_opcode opcode,
	input dest_mem_forward_sel,
	input control_flush,

	output lc3b_word pc_out,
	output lc3b_word dmem_address,
	output lc3b_word dmem_wdata,
	output logic dmem_action_stb,
	output logic dmem_action_cyc,
	output logic dmem_write,
	output lc3b_word dmem_rdata_out,
	output lc3b_mem_wmask dmem_byte_enable,
	output logic mem_stall
);

/* Internal Signals */
lc3b_word dmem_data_out;
lc3b_word dest_forward_mux_out;
lc3b_word dest_lfsh_out;
lc3b_word destmux_out;

lc3b_word perf_count_data;
lc3b_word dmem_rdata_inter;
logic perf_count_sel;

mux2 dest_forwardmux
(
	.sel(dest_mem_forward_sel),
	.a(dest_out),
	.b(write_data),
	.f(dest_forward_mux_out)
);

assign dest_lfsh_out = dest_forward_mux_out << 8;

mux2 destmux
(
	.sel(alu_out[0]),
	.a(dest_forward_mux_out),
	.b(dest_lfsh_out),
	.f(destmux_out)
);

memory_stall m_stall
(
	.clk(clk),
	.load_ex_mem(load_ex_mem),
	.dmem_resp(dmem_resp),
	.opcode(opcode),
	.dest_out(destmux_out),
	.alu_out(alu_out),
	.dmem_data_out(dmem_data_out),
	.control_flush(control_flush),
	.dest_register(dest_register),
	.dmem_action_stb(dmem_action_stb),
	.dmem_action_cyc(dmem_action_cyc),
	.dmem_write(dmem_write),
	.dmem_byte_enable(dmem_byte_enable),
	.dmem_wdata(dmem_wdata),
	.mem_stall(mem_stall),
	.dmem_address(dmem_address),
	.perf_count_sel(perf_count_sel),
	.perf_count_data(perf_count_data)
);

mux8 dmem_rdata_mux
(
	.sel(dmem_address[3:1]),
	.a(dmem_rdata[15:0]),
	.b(dmem_rdata[31:16]),
	.c(dmem_rdata[47:32]),
	.d(dmem_rdata[63:48]),
	.e(dmem_rdata[79:64]),
	.f(dmem_rdata[95:80]),
	.g(dmem_rdata[111:96]),
	.h(dmem_rdata[127:112]),
	.o(dmem_rdata_inter)
);

mux2 perf_count
(
	.sel(perf_count_sel),
	.a(dmem_rdata_inter),
	.b(perf_count_data),
	.f(dmem_rdata_out)
);

register dmem_data
(
	.clk(clk),
	.load(dmem_resp),
	.in(dmem_rdata_inter),
	.out(dmem_data_out)
);

mux4 newpcmux
(
	.sel(newpcmux_sel),
	.a(pc_j_out),
	.b(pc_br_out),
	.c(dmem_rdata_inter),
	.d(dmem_rdata_inter),
	.f(pc_out)
);

endmodule: memory_stage