import lc3b_types::*;

module evict_line #(parameter width = 128)
(
	input valid_a,
	input valid_b,
	input valid_c,
	input valid_d,

	input dirty_a,
	input dirty_b,
	input dirty_c,
	input dirty_d,

	input [2:0] lru,
	output logic [1:0] line
);

always_comb
begin
	if (lru[0] && lru[1] && lru[2])
	begin
		if(valid_a && dirty_a)
			line = 2'b00;
		else if (valid_b && dirty_b)
			line = 2'b01;
		else if (valid_c && dirty_c)
			line = 2'b10;
		else
			line = 2'b11;
	end

	else if (lru[0] && lru[1] && !lru[2])
	begin
		if(valid_a && dirty_a)
			line = 2'b00;
		else if (valid_b && dirty_b)
			line = 2'b01;
		else if (valid_d && dirty_d)
			line = 2'b11;
		else
			line = 2'b10;
	end

	else if (lru[0] && !lru[1] && lru[2])
	begin
		if(valid_b && dirty_b)
			line = 2'b01;
		else if (valid_a && dirty_a)
			line = 2'b00;
		else if (valid_c && dirty_c)
			line = 2'b10;
		else
			line = 2'b11;
	end

	else if (lru[0] && !lru[1] && !lru[2])
	begin
		if(valid_b && dirty_b)
			line = 2'b01;
		else if (valid_a && dirty_a)
			line = 2'b00;
		else if (valid_d && dirty_d)
			line = 2'b11;
		else
			line = 2'b10;
	end

	else if (!lru[0] && lru[1] && lru[2])
	begin
		if(valid_c && dirty_c)
			line = 2'b10;
		else if (valid_d && dirty_d)
			line = 2'b11;
		else if (valid_a && dirty_a)
			line = 2'b00;
		else
			line = 2'b01;
	end

	else if (!lru[0] && lru[1] && !lru[2])
	begin
		if(valid_d && dirty_d)
			line = 2'b11;
		else if (valid_c && dirty_c)
			line = 2'b10;
		else if (valid_a && dirty_a)
			line = 2'b00;
		else
			line = 2'b01;
	end

	else if (!lru[0] && !lru[1] && lru[2])
	begin
		if(valid_c && dirty_c)
			line = 2'b10;
		else if (valid_d && dirty_d)
			line = 2'b11;
		else if (valid_b && dirty_b)
			line = 2'b01;
		else
			line = 2'b00;
	end

	else
	begin
		if(valid_d && dirty_d)
			line = 2'b11;
		else if (valid_c && dirty_c)
			line = 2'b10;
		else if (valid_b && dirty_b)
			line = 2'b01;
		else
			line = 2'b00;
	end

end

endmodule: evict_line
