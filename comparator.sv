module comparator #(parameter width = 9)
(
	input [width-1:0] value0,
	input [width-1:0] value1,
	
	output logic out
);

always_comb
begin
	if(value0 == value1)
		out = 1;
	else
		out = 0;
end

endmodule: comparator