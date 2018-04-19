import lc3b_types::*;

module eviction_wb_datapath
(
	input clk,
	input lc3b_word mem_address,
	input lc3b_data cpu_data,
	input lc3b_data pmem_data,
	input lc3b_word mem_byte_enable,
	
	input valid0_write,
	input valid1_write,
	input valid2_write,
	input valid3_write,
	input valid_in,
	input dirty0_write,
	input dirty1_write,
	input dirty2_write,
	input dirty3_write,
	input dirty_in,
	input tag0_write,
	input tag1_write,
	input tag2_write,
	input tag3_write,
	input data0_write,
	input data1_write,
	input data2_write,
	input data3_write,
	input lru_write,
	input [2:0] lru_in,
	input pmem_addr_sig,
	input out_data_sel,
	
	output logic [2:0] lru_out,
	output logic [1:0] cline_and,
	output logic hit,
	output lc3b_data data_out,
	output lc3b_data pdata_out,
	output lc3b_word pmem_address,
	output logic valid0_out,
	output logic valid1_out,
	output logic valid2_out,
	output logic valid3_out,
	output logic dirty0_out,
	output logic dirty1_out,
	output logic dirty2_out,
	output logic dirty3_out,
	output logic [1:0] line,
	output logic [1:0] ow_line
);

lc3b_evict_tag tag;
//lc3b_offset offset;

assign tag = mem_address[15:4];
//assign offset = mem_address[3:1];

lc3b_evict_tag tag0_out;
lc3b_evict_tag tag1_out;
lc3b_evict_tag tag2_out;
lc3b_evict_tag tag3_out;
lc3b_evict_tag tag_10_out;
lc3b_evict_tag tag_32_out;
lc3b_evict_tag tag_out;
logic comp0_out;
logic comp1_out;
logic comp2_out;
logic comp3_out;

logic cline0_and;
logic cline1_and;
logic cline2_and;
logic cline3_and;

lc3b_data cdata_out;
lc3b_data data0_out;
lc3b_data data1_out;
lc3b_data data2_out;
lc3b_data data3_out;
lc3b_data data_10_out;
lc3b_data data_32_out;

lc3b_word write_back_addr;

/* Valid Arrays */
eviction_wb_array #(.width(1)) valid0
(
	.clk(clk),
	.write(valid0_write),
	.datain(valid_in),
	.dataout(valid0_out)
);

eviction_wb_array #(.width(1)) valid1
(
	.clk(clk),
	.write(valid1_write),
	.datain(valid_in),
	.dataout(valid1_out)
);

eviction_wb_array #(.width(1)) valid2
(
	.clk(clk),
	.write(valid2_write),
	.datain(valid_in),
	.dataout(valid2_out)
);

eviction_wb_array #(.width(1)) valid3
(
	.clk(clk),
	.write(valid3_write),
	.datain(valid_in),
	.dataout(valid3_out)
);

/* Dirty Arrays */
eviction_wb_array #(.width(1)) dirty0
(
	.clk(clk),
	.write(dirty0_write),
	.datain(dirty_in),
	.dataout(dirty0_out)
);

eviction_wb_array #(.width(1)) dirty1
(
	.clk(clk),
	.write(dirty1_write),
	.datain(dirty_in),
	.dataout(dirty1_out)
);

eviction_wb_array #(.width(1)) dirty2
(
	.clk(clk),
	.write(dirty2_write),
	.datain(dirty_in),
	.dataout(dirty2_out)
);

eviction_wb_array #(.width(1)) dirty3
(
	.clk(clk),
	.write(dirty3_write),
	.datain(dirty_in),
	.dataout(dirty3_out)
);

/* LRU Array */
eviction_wb_array #(.width(3)) lru
(
	.clk(clk),
	.write(lru_write),
	.datain(lru_in),
	.dataout(lru_out)
);

/* Tag Arrays */
eviction_wb_array #(.width(12)) tag0
(
	.clk(clk),
	.write(tag0_write),
	.datain(tag),
	.dataout(tag0_out)
);

eviction_wb_array #(.width(12)) tag1
(
	.clk(clk),
	.write(tag1_write),
	.datain(tag),
	.dataout(tag1_out)
);

eviction_wb_array #(.width(12)) tag2
(
	.clk(clk),
	.write(tag2_write),
	.datain(tag),
	.dataout(tag2_out)
);

eviction_wb_array #(.width(12)) tag3
(
	.clk(clk),
	.write(tag3_write),
	.datain(tag),
	.dataout(tag3_out)
);

comparator #(.width(12)) comp0
(
	.value0(tag0_out),
	.value1(tag),
	.out(comp0_out)
);

comparator #(.width(12)) comp1
(
	.value0(tag1_out),
	.value1(tag),
	.out(comp1_out)
);

comparator #(.width(12)) comp2
(
	.value0(tag2_out),
	.value1(tag),
	.out(comp2_out)
);

comparator #(.width(12)) comp3
(
	.value0(tag3_out),
	.value1(tag),
	.out(comp3_out)
);

assign cline0_and = comp0_out & valid0_out;
assign cline1_and = comp1_out & valid1_out;
assign cline2_and = comp2_out & valid2_out;
assign cline3_and = comp3_out & valid3_out;
assign hit = cline0_and | cline1_and | cline2_and | cline3_and;

always_comb
begin
	if (cline0_and)
		cline_and = 2'b00;
	else if (cline1_and)
		cline_and = 2'b01;
	else if (cline2_and)
		cline_and = 2'b10;
	else
		cline_and = 2'b11;
end

eviction_wb_array data0
(
	.clk(clk),
	.write(data0_write),
	.datain(cpu_data),
	.dataout(data0_out)
);

eviction_wb_array data1
(
	.clk(clk),
	.write(data1_write),
	.datain(cpu_data),
	.dataout(data1_out)
);

eviction_wb_array data2
(
	.clk(clk),
	.write(data2_write),
	.datain(cpu_data),
	.dataout(data2_out)
);

eviction_wb_array data3
(
	.clk(clk),
	.write(data3_write),
	.datain(cpu_data),
	.dataout(data3_out)
);

mux4 #(.width(128)) cdata_mux
(
	.sel(cline_and),
	.a(data0_out),
	.b(data1_out),
	.c(data2_out),
	.d(data3_out),
	.f(cdata_out)
);

mux2 #(.width(128)) out_data_mux
(
	.sel(out_data_sel),
	.a(cdata_out),
	.b(pmem_data),
	.f(data_out)
);

/* Address to Physical Memory*/
evict_line evict_data
(
	.valid_a(valid0_out),
	.valid_b(valid1_out),
	.valid_c(valid2_out),
	.valid_d(valid3_out),
	.dirty_a(dirty0_out),
	.dirty_b(dirty1_out),
	.dirty_c(dirty2_out),
	.dirty_d(dirty3_out),
	.lru(lru_out),
	.line(line)
);

overwrite_line overwrite_data
(
	.valid_a(valid0_out),
	.valid_b(valid1_out),
	.valid_c(valid2_out),
	.valid_d(valid3_out),
	.dirty_a(dirty0_out),
	.dirty_b(dirty1_out),
	.dirty_c(dirty2_out),
	.dirty_d(dirty3_out),
	.lru(lru_out),
	.line(ow_line)
);

mux4 #(.width(128)) evict_data_mux
(
	.sel(line),
	.a(data0_out),
	.b(data1_out),
	.c(data2_out),
	.d(data3_out),
	.f(pdata_out)
);

mux4 #(.width(12)) evict_tag_mux
(
	.sel(line),
	.a(tag0_out),
	.b(tag1_out),
	.c(tag2_out),
	.d(tag3_out),
	.f(tag_out)
);

assign write_back_addr = {tag_out, 4'b0000};

mux2 #(.width(16)) pmem_addr_mux
(
	.sel(pmem_addr_sig),
	.a(mem_address),
	.b(write_back_addr),
	.f(pmem_address)
);

endmodule: eviction_wb_datapath