import lc3b_types::*;

module tournament_bht
(
	input clk,
	input lc3b_word read_pc,

	input lc3b_word write_pc,
	input taken,
	input write,
	input control_flush,
	input unchosen_pred,

	output prediction
);

lc3b_global_bht_pattern_index index;
lc3b_global_bht_pattern_index index_in;
lc3b_global_bht_pattern_index history_in;
lc3b_global_bht_pattern_index history_out;

logic [1:0] pattern_in;
logic [1:0] rpattern_out;
logic [1:0] pattern_out;

global_bht_history_register #(.width(4)) history_table
(
	.clk(clk),
	.write(write),
	.datain(history_in),
	.dataout(history_out)
);

assign index = history_out ^ read_pc[4:1];
assign index_in = history_out ^ write_pc[4:1];

global_bht_pattern_array #(.width(2)) pattern_table
(
	.clk(clk),
	.write(write),
	.index(index),
	.index_in(index_in),
	.datain(pattern_in),
	.rdataout(rpattern_out),
	.dataout(pattern_out)
);

// 0 - Local Taken, 1 - Global Taken
assign prediction = rpattern_out[1];

always_comb
begin
	pattern_in = pattern_out;
	history_in = history_out;
	// Set history and pattern on write
	if (write) begin
		history_in = {history_out[2:0], taken};
		
		if (control_flush && (taken == unchosen_pred)) begin
			if (pattern_out == 2'b00)
				pattern_in = 2'b01;
			else if (pattern_out == 2'b01)
				pattern_in = 2'b10;
			else if (pattern_out == 2'b10)
				pattern_in = 2'b01;
			else if (pattern_out == 2'b11 && !taken)
				pattern_in = 2'b10;
		end
		
		if (!control_flush && (taken != unchosen_pred)) begin
			if (pattern_out == 2'b01)
				pattern_in = 2'b00;
			else if (pattern_out == 2'b10)
				pattern_in = 2'b11;
		end
		
	end
end

endmodule: tournament_bht