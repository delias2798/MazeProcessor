import lc3b_types::*;

module l1_cache_datapath
(
	input clk,
	input lc3b_word mem_address,
	input lc3b_data cpu_data,
	input lc3b_data pmem_data,
	input lc3b_word mem_byte_enable,
	
	input valid0_write,
	input valid1_write,
	input valid_in,
	input dirty0_write,
	input dirty1_write,
	input dirty_in,
	input tag0_write,
	input tag1_write,
	input data0_write,
	input data1_write,
	input lru_write,
	input lru_in,
	input pmem_addr_sig,
	input data_sig,
	
	output logic lru_out,
	output logic dirty_out,
	output logic cline0_and,
	output logic cline1_and,
	output logic hit,
	output lc3b_data data_out,
	output lc3b_data pdata_out,
	output lc3b_word pmem_address
);

lc3b_tag tag;
lc3b_index index;
//lc3b_offset offset;

assign tag = mem_address[15:7];
assign index = mem_address[6:4];
//assign offset = mem_address[3:1];

logic valid0_out;
logic valid1_out;

logic dirty0_out;
logic dirty1_out;

lc3b_tag tag0_out;
lc3b_tag tag1_out;
lc3b_tag tag_out;
logic comp0_out;
logic comp1_out;

lc3b_data data_in;
lc3b_data data0_out;
lc3b_data data1_out;
lc3b_data cpu_data_out;

lc3b_word write_back_addr;

/* Valid Arrays */
array #(.width(1)) valid0
(
	.clk(clk),
	.write(valid0_write),
	.index(index),
	.datain(valid_in),
	.dataout(valid0_out)
);

array #(.width(1)) valid1
(
	.clk(clk),
	.write(valid1_write),
	.index(index),
	.datain(valid_in),
	.dataout(valid1_out)
);

/* LRU Array */
array #(.width(1)) lru
(
	.clk(clk),
	.write(lru_write),
	.index(index),
	.datain(lru_in),
	.dataout(lru_out)
);

/* Dirty Arrays */
array #(.width(1)) dirty0
(
	.clk(clk),
	.write(dirty0_write),
	.index(index),
	.datain(dirty_in),
	.dataout(dirty0_out)
);

array #(.width(1)) dirty1
(
	.clk(clk),
	.write(dirty1_write),
	.index(index),
	.datain(dirty_in),
	.dataout(dirty1_out)
);

mux2 #(.width(1)) dirty_mux
(
	.sel(lru_out),
	.a(dirty0_out),
	.b(dirty1_out),
	.f(dirty_out)
);

/* Tag Arrays */
array #(.width(9)) tag0
(
	.clk(clk),
	.write(tag0_write),
	.index(index),
	.datain(tag),
	.dataout(tag0_out)
);

array #(.width(9)) tag1
(
	.clk(clk),
	.write(tag1_write),
	.index(index),
	.datain(tag),
	.dataout(tag1_out)
);

comparator comp0
(
	.value0(tag0_out),
	.value1(tag),
	.out(comp0_out)
);

comparator comp1
(
	.value0(tag1_out),
	.value1(tag),
	.out(comp1_out)
);

assign cline0_and = comp0_out & valid0_out;
assign cline1_and = comp1_out & valid1_out;
assign hit = cline0_and | cline1_and;

/* Data Arrays */
cpudata cpu_data_cal
(
	.cpu(cpu_data),
	.data(data_out),
	.wmask(mem_byte_enable),
	.out(cpu_data_out)
);

mux2 #(.width(128)) data_mux
(
	.sel(data_sig),
	.a(cpu_data_out),
	.b(pmem_data),
	.f(data_in)
);

array data0
(
	.clk(clk),
	.write(data0_write),
	.index(index),
	.datain(data_in),
	.dataout(data0_out)
);

array data1
(
	.clk(clk),
	.write(data1_write),
	.index(index),
	.datain(data_in),
	.dataout(data1_out)
);

mux2 #(.width(128)) cdata_mux
(
	.sel(cline0_and),
	.a(data1_out),
	.b(data0_out),
	.f(data_out)
);

mux2 #(.width(128)) pdata_mux
(
	.sel(lru_out),
	.a(data0_out),
	.b(data1_out),
	.f(pdata_out)
);

/* Address to Physical Memory*/
mux2 #(.width(9)) tag_mux
(
	.sel(lru_out),
	.a(tag0_out),
	.b(tag1_out),
	.f(tag_out)
);

assign write_back_addr = {tag_out, index, 4'b0000};

mux2 #(.width(16)) pmem_addr_mux
(
	.sel(pmem_addr_sig),
	.a(mem_address),
	.b(write_back_addr),
	.f(pmem_address)
);

endmodule: l1_cache_datapath