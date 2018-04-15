import lc3b_types::*;

module btb
(
  input clk,
  input lc3b_word read_pc,

  input lc3b_word write_pc,
  input lc3b_word write_data,
  input taken,
	input write,
	
  output hit,
  output lc3b_word predicted_pc
);

lc3b_btb_tag tag;
lc3b_index index;

lc3b_btb_tag tag_in;
lc3b_index index_in;

assign tag = read_pc[15:4];
assign index = read_pc[3:1];

assign tag_in = write_pc[15:4];
assign index_in = write_pc[3:1];

logic tag0_write;
logic tag1_write;
logic tag2_write;
logic tag3_write;

logic valid0_write;
logic valid1_write;
logic valid2_write;
logic valid3_write;

logic valid_in;

logic valid0_out;
logic valid1_out;
logic valid2_out;
logic valid3_out;

lc3b_btb_tag tag0_out;
lc3b_btb_tag tag1_out;
lc3b_btb_tag tag2_out;
lc3b_btb_tag tag3_out;

logic data0_write;
logic data1_write;
logic data2_write;
logic data3_write;
logic lru_write;

lc3b_word data0_out;
lc3b_word data1_out;
lc3b_word data2_out;
lc3b_word data3_out;

logic comp0_out;
logic comp1_out;
logic comp2_out;
logic comp3_out;

logic valid0_and;
logic valid1_and;
logic valid2_and;
logic valid3_and;

logic [1:0] pc_and;
logic [2:0] lru_in;
logic [2:0] lru_out;
logic [2:0] rlru_in;
logic [2:0] rlru_out;

/* Tag Arrays */
btb_array #(.width(12)) tag0
(
	.clk(clk),
	.write(tag0_write),
	.index(index),
  .index_in(index_in),
	.datain(tag_in),
	.dataout(tag0_out)
);

btb_array #(.width(12)) tag1
(
	.clk(clk),
	.write(tag1_write),
	.index(index),
  .index_in(index_in),
	.datain(tag_in),
	.dataout(tag1_out)
);

btb_array #(.width(12)) tag2
(
	.clk(clk),
	.write(tag2_write),
	.index(index),
  .index_in(index_in),
	.datain(tag_in),
	.dataout(tag2_out)
);

btb_array #(.width(12)) tag3
(
	.clk(clk),
	.write(tag3_write),
	.index(index),
  .index_in(index_in),
	.datain(tag_in),
	.dataout(tag3_out)
);

/* Valid Arrays */
btb_array #(.width(1)) valid0
(
	.clk(clk),
	.write(valid0_write),
	.index(index),
  .index_in(index_in),
	.datain(valid_in),
	.dataout(valid0_out)
);

btb_array #(.width(1)) valid1
(
	.clk(clk),
	.write(valid1_write),
	.index(index),
  .index_in(index_in),
	.datain(valid_in),
	.dataout(valid1_out)
);

btb_array #(.width(1)) valid2
(
	.clk(clk),
	.write(valid2_write),
	.index(index),
  .index_in(index_in),
	.datain(valid_in),
	.dataout(valid2_out)
);

btb_array #(.width(1)) valid3
(
	.clk(clk),
	.write(valid3_write),
	.index(index),
  .index_in(index_in),
	.datain(valid_in),
	.dataout(valid3_out)
);

/* Data Arrays */
btb_array #(.width(16)) data0
(
	.clk(clk),
	.write(data0_write),
	.index(index),
  .index_in(index_in),
	.datain(write_data),
	.dataout(data0_out)
);

btb_array #(.width(16)) data1
(
	.clk(clk),
	.write(data1_write),
	.index(index),
  .index_in(index_in),
	.datain(write_data),
	.dataout(data1_out)
);

btb_array #(.width(16)) data2
(
	.clk(clk),
	.write(data2_write),
	.index(index),
  .index_in(index_in),
	.datain(write_data),
	.dataout(data2_out)
);

btb_array #(.width(16)) data3
(
	.clk(clk),
	.write(data3_write),
	.index(index),
  .index_in(index_in),
	.datain(write_data),
	.dataout(data3_out)
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

assign valid0_and = comp0_out & valid0_out;
assign valid1_and = comp1_out & valid1_out;
assign valid2_and = comp2_out & valid2_out;
assign valid3_and = comp3_out & valid3_out;
assign hit = valid0_and | valid1_and | valid2_and | valid3_and;

always_comb
begin
	if (comp0_out)
		pc_and = 2'b00;
	else if (comp1_out)
		pc_and = 2'b01;
	else if (comp2_out)
		pc_and = 2'b10;
	else
		pc_and = 2'b11;
end

mux4 #(.width(16)) pc_out
(
  .sel(pc_and),
  .a(data0_out),
  .b(data1_out),
  .c(data2_out),
  .d(data3_out),
  .f(predicted_pc)
);

/* LRU Array */
btb_lru_array #(.width(3)) lru
(
	.clk(clk),
  .rwrite(hit),
	.write(taken),
	.index(index),
  .index_in(index_in),
  .rdatain(rlru_in),
	.datain(lru_in),
  .rdataout(rlru_out),
	.dataout(lru_out)
);

always_comb
begin
  rlru_in = rlru_out;
  // Update lru at read_pc
  if (comp0_out == 1) begin
    rlru_in[0] = 0;
    rlru_in[1] = 0;
  end
  else if (comp1_out == 1) begin
    rlru_in[0] = 0;
    rlru_in[1] = 1;
  end
  else if (comp2_out == 1) begin
    rlru_in[0] = 1;
    rlru_in[2] = 0;
  end
  else if (comp3_out == 1) begin
    rlru_in[0] = 1;
    rlru_in[2] = 1;
  end

	lru_in = lru_out;
	tag0_write = 1'b0;
	tag1_write = 1'b0;
	tag2_write = 1'b0;
	tag3_write = 1'b0;
	valid0_write = 1'b0;
	valid1_write = 1'b0;
	valid2_write = 1'b0;
	valid3_write = 1'b0;
	data0_write = 1'b0;
	data1_write = 1'b0;
	data2_write = 1'b0;
	data3_write = 1'b0;
	valid_in = 1;
  
  // Update lru at write
  if (taken && write) begin
	  if (lru_out[0] == 1 && lru_out[1] == 1)
	  begin
		 tag0_write = 1;
		 valid0_write = 1;
		 data0_write = 1;
		 lru_in[0] = 0;
		 lru_in[1] = 0;
	  end
	  else if (lru_out[0] == 1 && lru_out[1] == 0)
	  begin
		 tag1_write = 1;
		 valid1_write = 1;
		 data1_write = 1;
		 lru_in[0] = 0;
		 lru_in[1] = 1;
	  end
	  else if (lru_out[0] == 0 && lru_out[2] == 1)
	  begin
		 tag2_write = 1;
		 valid2_write = 1;
		 data2_write = 1;
		 lru_in[0] = 1;
		 lru_in[2] = 0;
	  end
	  else
	  begin
		 tag3_write = 1;
		 valid3_write = 1;
		 data3_write = 1;
		 lru_in[0] = 1;
		 lru_in[2] = 1;
	  end
	end
end

endmodule: btb
