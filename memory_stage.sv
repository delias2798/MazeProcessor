import lc3b_types::*;

module memory_stage
(
	input clk,
	input lc3b_word alu_out,
	input lc3b_word pc_br_out,
	input lc3b_word pc_j_out,
	input lc3b_data dmem_rdata,
	input lc3b_word dest_out,
	input dmem_resp,

	/* Control Signals */
	input mem_addr_mux_sel,
	input [1:0] newpcmux_sel,
	input lc3b_opcode opcode,

	output lc3b_word pc_out,
	output lc3b_word dmem_address,
	output lc3b_word dmem_wdata,
	output logic dmem_action_stb,
	output logic dmem_action_cyc,
	output logic dmem_write,
	output lc3b_mem_wmask dmem_byte_enable
);

/* Internal Signals */
lc3b_word dmem_rdata_out;

/* Assign Values */
always_comb
begin
	dmem_action_cyc = 0;
	dmem_action_stb = 0;
	
	if ((opcode == op_ldr) || (opcode == op_str) || (opcode == op_ldb) || (opcode == op_stb) || (opcode == op_trap))
	begin
		dmem_action_cyc = 1;
		dmem_action_stb = 1;
	end
	
	// Write Signal
	if ((opcode == op_stb) || (opcode == op_str))
		dmem_write = 1;
	else
		dmem_write = 0;

	// Mem Byte Enable Signal
	if ((opcode == op_stb) && (dmem_address[0] == 1))
		dmem_byte_enable = 2'b10;
	else if ((opcode == op_stb) && (dmem_address[0] == 0))
		dmem_byte_enable = 2'b01;
	else
		dmem_byte_enable = 2'b11;
	
	dmem_wdata = dest_out;
end

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

mux2 mem_addr_mux
(
	.sel(mem_addr_mux_sel),
	.a(alu_out),
	.b(dmem_rdata_out),
	.f(dmem_address)
);

endmodule: memory_stage