import lc3b_types::*;

module ir
(
   	input lc3b_word in,
		output lc3b_opcode opcode,
   	output lc3b_reg dest, src1, src2,
		output lc3b_offset4 offset4,
		output lc3b_offset5 offset5,
   	output lc3b_offset6 offset6,
   	output lc3b_offset8 offset8,
   	output lc3b_offset9 offset9,
   	output lc3b_offset11 offset11
);

assign opcode = lc3b_opcode'(in[15:12]);
assign dest = in[11:9];
assign src1 = in[8:6];
assign src2 = in[2:0];
assign offset4 = in[3:0];
assign offset5 = in[4:0];
assign offset6 = in[5:0];
assign offset8 = in[7:0];
assign offset9 = in[8:0];
assign offset11 = in[10:0];

endmodule : ir
