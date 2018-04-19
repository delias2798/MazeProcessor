import lc3b_types::*;

module eviction_wb
(
	wishbone.master wb,
	wishbone.slave cpu_wb
);

/* declare internal signals */
logic valid0_write;
logic valid1_write;
logic valid2_write;
logic valid3_write;
logic valid_in;
logic dirty0_write;
logic dirty1_write;
logic dirty2_write;
logic dirty3_write;
logic dirty_in;
logic tag0_write;
logic tag1_write;
logic tag2_write;
logic tag3_write;
logic data0_write;
logic data1_write;
logic data2_write;
logic data3_write;
logic lru_write;
logic [2:0] lru_in;
logic pmem_addr_sig;
logic [2:0] lru_out;
logic [1:0] cline_and;
logic hit;
lc3b_word mem_address;
lc3b_word pmem_address;

logic valid0_out;
logic valid1_out;
logic valid2_out;
logic valid3_out;
logic dirty0_out;
logic dirty1_out;
logic dirty2_out;
logic dirty3_out;
logic out_data_sel;

logic [1:0] line;
logic [1:0] ow_line;

assign mem_address = {cpu_wb.ADR, 4'b0000};
assign wb.ADR = pmem_address[15:4];
assign wb.SEL = 16'hFFFF;

eviction_wb_datapath cache_d
(
	.clk(wb.CLK),
	.mem_address(mem_address),
	.cpu_data(cpu_wb.DAT_M),
	.pmem_data(wb.DAT_S),
	.mem_byte_enable(cpu_wb.SEL),
	.valid0_write(valid0_write),
	.valid1_write(valid1_write),
	.valid2_write(valid2_write),
	.valid3_write(valid3_write),
	.valid_in(valid_in),
	.dirty0_write(dirty0_write),
	.dirty1_write(dirty1_write),
	.dirty2_write(dirty2_write),
	.dirty3_write(dirty3_write),
	.dirty_in(dirty_in),
	.tag0_write(tag0_write),
	.tag1_write(tag1_write),
	.tag2_write(tag2_write),
	.tag3_write(tag3_write),
	.data0_write(data0_write),
	.data1_write(data1_write),
	.data2_write(data2_write),
	.data3_write(data3_write),
	.lru_write(lru_write),
	.lru_in(lru_in),
	.pmem_addr_sig(pmem_addr_sig),
	.out_data_sel(out_data_sel),
	.lru_out(lru_out),
	.cline_and(cline_and),
	.hit(hit),
	.data_out(cpu_wb.DAT_S),
	.pdata_out(wb.DAT_M),
	.pmem_address(pmem_address),
	.valid0_out(valid0_out),
	.valid1_out(valid1_out),
	.valid2_out(valid2_out),
	.valid3_out(valid3_out),
	.dirty0_out(dirty0_out),
	.dirty1_out(dirty1_out),
	.dirty2_out(dirty2_out),
	.dirty3_out(dirty3_out),
	.line(line),
	.ow_line(ow_line)
);

eviction_wb_control cache_c
(
	.clk(wb.CLK),
	.valid0_write(valid0_write),
	.valid1_write(valid1_write),
	.valid2_write(valid2_write),
	.valid3_write(valid3_write),
	.valid_in(valid_in),
	.dirty0_write(dirty0_write),
	.dirty1_write(dirty1_write),
	.dirty2_write(dirty2_write),
	.dirty3_write(dirty3_write),
	.dirty_in(dirty_in),
	.tag0_write(tag0_write),
	.tag1_write(tag1_write),
	.tag2_write(tag2_write),
	.tag3_write(tag3_write),
	.data0_write(data0_write),
	.data1_write(data1_write),
	.data2_write(data2_write),
	.data3_write(data3_write),
	.lru_write(lru_write),
	.lru_in(lru_in),
	.pmem_addr_sig(pmem_addr_sig),
	.out_data_sel(out_data_sel),
	.lru_out(lru_out),
	.cline_and(cline_and),
	.line(line),
	.ow_line(ow_line),
	.hit(hit),
	.valid0_out(valid0_out),
	.valid1_out(valid1_out),
	.valid2_out(valid2_out),
	.valid3_out(valid3_out),
	.dirty0_out(dirty0_out),
	.dirty1_out(dirty1_out),
	.dirty2_out(dirty2_out),
	.dirty3_out(dirty3_out),
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

endmodule: eviction_wb
