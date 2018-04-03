import lc3b_types::*;

module l1_cache
(
	wishbone.master wb,
	wishbone.slave cpu_wb
);

/* declare internal signals */
logic valid0_write;
logic valid1_write;
logic valid_in;
logic dirty0_write;
logic dirty1_write;
logic dirty_in;
logic tag0_write;
logic tag1_write;
logic data0_write;
logic data1_write;
logic lru_write;
logic lru_in;
logic pmem_addr_sig;
logic data_sig;
logic lru_out;
logic dirty_out;
logic cline0_and;
logic cline1_and;
logic hit;
lc3b_word mem_address;
lc3b_word pmem_address;

assign mem_address = {cpu_wb.ADR, 4'b0000};
assign wb.ADR = pmem_address[15:4];
assign wb.SEL = 16'hFFFF;

l1_cache_datapath cache_d
(
	.clk(wb.CLK),
	.mem_address(mem_address),
	.cpu_data(cpu_wb.DAT_M),
	.pmem_data(wb.DAT_S),
	.mem_byte_enable(cpu_wb.SEL),
	.valid0_write(valid0_write),
	.valid1_write(valid1_write),
	.valid_in(valid_in),
	.dirty0_write(dirty0_write),
	.dirty1_write(dirty1_write),
	.dirty_in(dirty_in),
	.tag0_write(tag0_write),
	.tag1_write(tag1_write),
	.data0_write(data0_write),
	.data1_write(data1_write),
	.lru_write(lru_write),
	.lru_in(lru_in),
	.pmem_addr_sig(pmem_addr_sig),
	.data_sig(data_sig),
	.lru_out(lru_out),
	.dirty_out(dirty_out),
	.cline0_and(cline0_and),
	.cline1_and(cline1_and),
	.hit(hit),
	.data_out(cpu_wb.DAT_S),
	.pdata_out(wb.DAT_M),
	.pmem_address(pmem_address)
);

l1_cache_control cache_c
(
	.clk(wb.CLK),
	.valid0_write(valid0_write),
	.valid1_write(valid1_write),
	.valid_in(valid_in),
	.dirty0_write(dirty0_write),
	.dirty1_write(dirty1_write),
	.dirty_in(dirty_in),
	.tag0_write(tag0_write),
	.tag1_write(tag1_write),
	.data0_write(data0_write),
	.data1_write(data1_write),
	.lru_write(lru_write),
	.lru_in(lru_in),
	.pmem_addr_sig(pmem_addr_sig),
	.data_sig(data_sig),
	.lru_out(lru_out),
	.dirty_out(dirty_out),
	.cline0_and(cline0_and),
	.cline1_and(cline1_and),
	.hit(hit),
	.cpu_action_stb(cpu_wb.STB),
	.cpu_action_cyc(cpu_wb.CYC),
	.cpu_write(cpu_wb.WE),
	.cpu_resp(cpu_wb.ACK),
	.cpu_retry(cpu_wb.RTY),
	.mem_action_stb(wb.STB),
	.mem_action_cyc(wb.CYC),
	.mem_write(wb.WE),
	.mem_resp(wb.ACK),
	.mem_retry(wb.RTY)
);

endmodule: l1_cache
