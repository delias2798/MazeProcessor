import lc3b_types::*;

module l2_cache_datapath
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
	input data_sig,
	
	output logic [2:0] lru_out,
	output logic valid_out,
	output logic dirty_out,
	output logic [1:0] cline_and,
	output logic hit,
	output lc3b_data data_out,
	output lc3b_data pdata_out,
	output lc3b_word pmem_address
);

lc3b_l2_tag tag;
lc3b_l2_index index;
//lc3b_offset offset;

assign tag = mem_address[15:8];
assign index = mem_address[7:4];
//assign offset = mem_address[3:1];

logic valid0_out;
logic valid1_out;
logic valid2_out;
logic valid3_out;
logic valid_10_out;
logic valid_32_out;

logic dirty0_out;
logic dirty1_out;
logic dirty2_out;
logic dirty3_out;
logic dirty_10_out;
logic dirty_32_out;

lc3b_l2_tag tag0_out;
lc3b_l2_tag tag1_out;
lc3b_l2_tag tag2_out;
lc3b_l2_tag tag3_out;
lc3b_l2_tag tag_10_out;
lc3b_l2_tag tag_32_out;
lc3b_l2_tag tag_out;
logic comp0_out;
logic comp1_out;
logic comp2_out;
logic comp3_out;

logic cline0_and;
logic cline1_and;
logic cline2_and;
logic cline3_and;

lc3b_data data_in;
lc3b_data data0_out;
lc3b_data data1_out;
lc3b_data data2_out;
lc3b_data data3_out;
lc3b_data data_10_out;
lc3b_data data_32_out;
// lc3b_data cpu_data_out;

lc3b_word write_back_addr;

/* Valid Arrays */
l2_array #(.width(1)) valid0
(
	.clk(clk),
	.write(valid0_write),
	.index(index),
	.datain(valid_in),
	.dataout(valid0_out)
);

l2_array #(.width(1)) valid1
(
	.clk(clk),
	.write(valid1_write),
	.index(index),
	.datain(valid_in),
	.dataout(valid1_out)
);

l2_array #(.width(1)) valid2
(
	.clk(clk),
	.write(valid2_write),
	.index(index),
	.datain(valid_in),
	.dataout(valid2_out)
);

l2_array #(.width(1)) valid3
(
	.clk(clk),
	.write(valid3_write),
	.index(index),
	.datain(valid_in),
	.dataout(valid3_out)
);

/*
mux2 #(.width(1)) valid_mux10
(
	.sel(lru_out[1]),
	.a(valid1_out),
	.b(valid0_out),
	.f(valid_10_out)
);

mux2 #(.width(1)) valid_mux32
(
	.sel(lru_out[2]),
	.a(valid3_out),
	.b(valid2_out),
	.f(valid_32_out)
);

mux2 #(.width(1)) valid_mux
(
	.sel(lru_out[0]),
	.a(valid_32_out),
	.b(valid_10_out),
	.f(valid_out)
);
*/
assign valid_out = valid0_out & valid1_out & valid2_out & valid3_out;

/* LRU Array */
l2_array #(.width(3)) lru
(
	.clk(clk),
	.write(lru_write),
	.index(index),
	.datain(lru_in),
	.dataout(lru_out)
);

/* Dirty Arrays */
l2_array #(.width(1)) dirty0
(
	.clk(clk),
	.write(dirty0_write),
	.index(index),
	.datain(dirty_in),
	.dataout(dirty0_out)
);

l2_array #(.width(1)) dirty1
(
	.clk(clk),
	.write(dirty1_write),
	.index(index),
	.datain(dirty_in),
	.dataout(dirty1_out)
);

l2_array #(.width(1)) dirty2
(
	.clk(clk),
	.write(dirty2_write),
	.index(index),
	.datain(dirty_in),
	.dataout(dirty2_out)
);

l2_array #(.width(1)) dirty3
(
	.clk(clk),
	.write(dirty3_write),
	.index(index),
	.datain(dirty_in),
	.dataout(dirty3_out)
);

mux2 #(.width(1)) dirty_mux10
(
	.sel(lru_out[1]),
	.a(dirty1_out),
	.b(dirty0_out),
	.f(dirty_10_out)
);

mux2 #(.width(1)) dirty_mux32
(
	.sel(lru_out[2]),
	.a(dirty3_out),
	.b(dirty2_out),
	.f(dirty_32_out)
);

mux2 #(.width(1)) dirty_mux
(
	.sel(lru_out[0]),
	.a(dirty_32_out),
	.b(dirty_10_out),
	.f(dirty_out)
);

/* Tag Arrays */
l2_array #(.width(8)) tag0
(
	.clk(clk),
	.write(tag0_write),
	.index(index),
	.datain(tag),
	.dataout(tag0_out)
);

l2_array #(.width(8)) tag1
(
	.clk(clk),
	.write(tag1_write),
	.index(index),
	.datain(tag),
	.dataout(tag1_out)
);

l2_array #(.width(8)) tag2
(
	.clk(clk),
	.write(tag2_write),
	.index(index),
	.datain(tag),
	.dataout(tag2_out)
);

l2_array #(.width(8)) tag3
(
	.clk(clk),
	.write(tag3_write),
	.index(index),
	.datain(tag),
	.dataout(tag3_out)
);

comparator #(.width(8)) comp0
(
	.value0(tag0_out),
	.value1(tag),
	.out(comp0_out)
);

comparator #(.width(8)) comp1
(
	.value0(tag1_out),
	.value1(tag),
	.out(comp1_out)
);

comparator #(.width(8)) comp2
(
	.value0(tag2_out),
	.value1(tag),
	.out(comp2_out)
);

comparator #(.width(8)) comp3
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

/* Data Arrays 
cpudata cpu_data_cal
(
	.cpu(cpu_data),
	.data(data_out),
	.wmask(mem_byte_enable),
	.out(cpu_data_out)
); */

mux2 #(.width(128)) data_mux
(
	.sel(data_sig),
	.a(cpu_data),
	.b(pmem_data),
	.f(data_in)
);

l2_array data0
(
	.clk(clk),
	.write(data0_write),
	.index(index),
	.datain(data_in),
	.dataout(data0_out)
);

l2_array data1
(
	.clk(clk),
	.write(data1_write),
	.index(index),
	.datain(data_in),
	.dataout(data1_out)
);

l2_array data2
(
	.clk(clk),
	.write(data2_write),
	.index(index),
	.datain(data_in),
	.dataout(data2_out)
);

l2_array data3
(
	.clk(clk),
	.write(data3_write),
	.index(index),
	.datain(data_in),
	.dataout(data3_out)
);

mux4 #(.width(128)) cdata_mux
(
	.sel(cline_and),
	.a(data0_out),
	.b(data1_out),
	.c(data2_out),
	.d(data3_out),
	.f(data_out)
);

/* Address to Physical Memory*/
mux2 #(.width(128)) pdata_mux10
(
	.sel(lru_out[1]),
	.a(data1_out),
	.b(data0_out),
	.f(data_10_out)
);

mux2 #(.width(128)) pdata_mux32
(
	.sel(lru_out[2]),
	.a(data3_out),
	.b(data2_out),
	.f(data_32_out)
);

mux2 #(.width(128)) pdata_mux
(
	.sel(lru_out[0]),
	.a(data_32_out),
	.b(data_10_out),
	.f(pdata_out)
);

mux2 #(.width(8)) tag_mux10
(
	.sel(lru_out[1]),
	.a(tag1_out),
	.b(tag0_out),
	.f(tag_10_out)
);

mux2 #(.width(8)) tag_mux32
(
	.sel(lru_out[2]),
	.a(tag3_out),
	.b(tag2_out),
	.f(tag_32_out)
);

mux2 #(.width(8)) tag_mux
(
	.sel(lru_out[0]),
	.a(tag_32_out),
	.b(tag_10_out),
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

endmodule: l2_cache_datapath