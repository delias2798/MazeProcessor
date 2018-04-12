import lc3b_types::*;

module evict_line #(parameter width = 128)
(
	input valid_a,
	input valid_b,
	input valid_c,
	input valid_d,
	
	input [2:0] lru,
	output logic [1:0] line
);

always_comb
begin
	if (lru[0] == 1 && lru[1] == 1 && lru[2] == 1)
	begin
		if(valid_a == 1)
			line = 2'b00;
		else if (valid_b == 1)
			line = 2'b01;
		else if (valid_c == 1)
			line = 2'b10;
		else
			line = 2'b11;
	end

	else if (lru[0] == 1 && lru[1] == 1 && lru[2] == 0)
	begin
		if(valid_a == 1)
			line = 2'b00;
		else if (valid_b == 1)
			line = 2'b01;
		else if (valid_d == 1)
			line = 2'b11;
		else
			line = 2'b10;
	end	

	else if (lru[0] == 1 && lru[1] == 0 && lru[2] == 1)
	begin
		if(valid_b == 1)
			line = 2'b01;
		else if (valid_a == 1)
			line = 2'b00;
		else if (valid_c == 1)
			line = 2'b10;
		else
			line = 2'b11;
	end	

	else if (lru[0] == 1 && lru[1] == 0 && lru[2] == 0)
	begin
		if(valid_b == 1)
			line = 2'b01;
		else if (valid_a == 1)
			line = 2'b00;
		else if (valid_d == 1)
			line = 2'b11;
		else
			line = 2'b10;
	end

	else if (lru[0] == 0 && lru[1] == 1 && lru[2] == 1)
	begin
		if(valid_c == 1)
			line = 2'b10;
		else if (valid_d == 1)
			line = 2'b11;
		else if (valid_a == 1)
			line = 2'b00;
		else
			line = 2'b01;
	end

	else if (lru[0] == 0 && lru[1] == 1 && lru[2] == 0)
	begin
		if(valid_d == 1)
			line = 2'b11;
		else if (valid_c == 1)
			line = 2'b10;
		else if (valid_a == 1)
			line = 2'b00;
		else
			line = 2'b01;
	end

	else if (lru[0] == 0 && lru[1] == 0 && lru[2] == 1)
	begin
		if(valid_c == 1)
			line = 2'b10;
		else if (valid_d == 1)
			line = 2'b11;
		else if (valid_b == 1)
			line = 2'b01;
		else
			line = 2'b00;
	end

	else
	begin
		if(valid_d == 1)
			line = 2'b11;
		else if (valid_c == 1)
			line = 2'b10;
		else if (valid_b == 1)
			line = 2'b01;
		else
			line = 2'b00;
	end

end

endmodule: evict_line