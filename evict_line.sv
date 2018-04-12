import lc3b_types::*;

module evict_line #(parameter width = 128)
(
	input [width-1:0] a,
	input [width-1:0] b,
	input [width-1:0] c,
	input [width-1:0] d,
	
	input valid_a,
	input valid_b,
	input valid_c,
	input valid_d,
	
	input [2:0] lru,
	
	output [width-1:0] f
);

always_comb
begin
	if (lru_out[0] == 1 && lru_out[1] == 1 && valid_a)
		f = a;
	else if (lru_out[0] == 1 && lru_out[1] == 0 && valid_b)
		f = b;
	else if (lru_out[0] == 0 && lru_out[2] == 1 && valid_c)
		f = c;
	else if (lru_out[0] == 0 && lru_out[2] == 0 && valid_d)
		f = d;
end

endmodule: evict_line