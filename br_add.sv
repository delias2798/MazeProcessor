import lc3b_types::*;

module br_add
(
	input lc3b_word offset9,
	input lc3b_word pc,
	
	output lc3b_word out
);

assign out = pc + offset9;

endmodule : br_add