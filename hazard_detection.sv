import lc3b_types::*;

module hazard_detection
(
	input clk,
	input lc3b_reg sr1_in,
	input lc3b_reg sr2_in,
	input ctrl_id_ex_load,
	input lc3b_reg dest_id_ex_register,
	
	output logic hazard_stall
);

always_comb
begin
	hazard_stall = 0;
	
	if (ctrl_id_ex_load && ((dest_id_ex_register == sr1_in) || (dest_id_ex_register == sr2_in)))
		hazard_stall = 1;
end

endmodule: hazard_detection