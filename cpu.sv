import lc3b_types::*;

module cpu
(
	wishbone.master imem_wb,
	wishbone.master dmem_wb
);

/* Internal Signals - Instruction Memory*/
lc3b_word imem_address;

/* Internal Signals - Data Memory */
lc3b_word dmem_address;
lc3b_word mem_wdata;
lc3b_mem_wmask mem_byte_enable;

cpu_datapath cpu_d
(
	.clk(imem_wb.CLK),
	.imem_rdata(imem_wb.DAT_S),
	.imem_resp(imem_wb.ACK),
	.imem_retry(imem_wb.RTY),
	.imem_address(imem_address),
	.imem_action_stb(imem_wb.STB),
	.imem_action_cyc(imem_wb.CYC),
	.dmem_rdata(dmem_wb.DAT_S),
	.dmem_resp(dmem_wb.ACK),
	.dmem_retry(dmem_wb.RTY),
	.dmem_address(dmem_address),
	.dmem_wdata(mem_wdata),
	.dmem_action_stb(dmem_wb.STB),
	.dmem_action_cyc(dmem_wb.CYC),
	.dmem_write(dmem_wb.WE),
	.dmem_byte_enable(mem_byte_enable)
);

assign imem_wb.ADR = imem_address[15:4];
assign imem_wb.DAT_M = 128'b0;
assign imem_wb.SEL = 16'b0;
assign imem_wb.WE = 0; // imem doesn't support write operations

assign dmem_wb.ADR = dmem_address[15:4];

always_comb
begin
	for (int i = 0; i < 8; i++) begin
		if (i == dmem_address[3:1]) begin
			dmem_wb.SEL[i*2 +:2] = mem_byte_enable;
			dmem_wb.DAT_M[i*16 +:16] = mem_wdata;
		end
		else begin
			dmem_wb.SEL[i*2 +:2] = 2'b0;
			dmem_wb.DAT_M[i*16 +:16] = 16'b0;
		end
	end

end

endmodule: cpu