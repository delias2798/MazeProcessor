import lc3b_types::*;

module cc_comp
(
	input lc3b_reg dest,
	input lc3b_nzp cc_out,
	
	output branch_enable
);

assign branch_enable = (dest[2] & cc_out[2]) | (dest[1] & cc_out[1]) | (dest[0] & cc_out[0]);

endmodule : cc_comp