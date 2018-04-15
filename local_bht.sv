import lc3b_types::*;

module local_bht
(
	input clk,
	input lc3b_word read_pc,

	input lc3b_word write_pc,
	input taken,
	input write,

	output prediction
);

lc3b_local_bht_pattern_index index;
lc3b_local_bht_pattern_index index_in;

logic [1:0] pattern_in;
logic [1:0] rpattern_out;
logic [1:0] pattern_out;

assign index = read_pc[6:1];
assign index_in = write_pc[6:1];

local_bht_pattern_array #(.width(2)) pattern_table
(
	.clk(clk),
	.write(write),
	.index(index),
	.index_in(index_in),
	.datain(pattern_in),
	.rdataout(rpattern_out),
	.dataout(pattern_out)
);

// 0 - Not Taken, 1 - Taken
assign prediction = rpattern_out[1];

always_comb
begin
	pattern_in = pattern_out;
	// Set pattern on write
	if (write) begin
		if (pattern_out == 2'b00 && taken)
			pattern_in = 2'b01;
		else if (pattern_out == 2'b01 && taken)
			pattern_in = 2'b10;
		else if (pattern_out == 2'b01 && !taken)
			pattern_in = 2'b00;
		else if (pattern_out == 2'b10 && taken)
			pattern_in = 2'b11;
		else if (pattern_out == 2'b10 && !taken)
			pattern_in = 2'b01;
		else if (pattern_out == 2'b11 && !taken)
			pattern_in = 2'b10;
	end
end

endmodule: local_bht