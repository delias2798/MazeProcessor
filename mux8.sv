module mux8 #(parameter width = 16)
(
	input [2:0] sel,
	input [width-1:0] a, b, c, d, e, f, g, h,
	output logic [width-1:0] o
);

always_comb
begin
	if (sel == 3'b000)
		o = a;
	else if (sel == 3'b001)
		o = b;
	else if (sel == 3'b010)
		o = c;
	else if (sel == 3'b011)
		o = d;
	else if (sel == 3'b100)
		o = e;
	else if (sel == 3'b101)
		o = f;
	else if (sel == 3'b110)
		o = g;
	else
		o = h;
end

endmodule : mux8