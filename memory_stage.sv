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

	/* Control Signals */
	input [1:0] newpcmux_sel,
	input lc3b_opcode opcode,
	input [1:0] mem_ack_counter,

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

memory_stall m_stall
(
	.clk(clk),
	.load_ex_mem(load_ex_mem),
	.mem_ack_counter(mem_ack_counter),
	.dmem_resp(dmem_resp),
	.opcode(opcode),
	.dest_out(dest_out),
	.alu_out(alu_out),
	.dmem_rdata_out(dmem_rdata_out),
	.dmem_action_stb(dmem_action_stb),
	.dmem_action_cyc(dmem_action_cyc),
	.dmem_write(dmem_write),
	.dmem_byte_enable(dmem_byte_enable),
	.dmem_wdata(dmem_wdata),
	.mem_stall(mem_stall),
	.dmem_address(dmem_address)
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
	.o(dmem_rdata_out)
);

mux4 newpcmux
(
	.sel(newpcmux_sel),
	.a(pc_j_out),
	.b(pc_br_out),
	.c(dmem_rdata_out),
	.d(dmem_rdata_out),
	.f(pc_out)
);

endmodule: memory_stage