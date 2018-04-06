import lc3b_types::*;

module hazard_detection
(
	input clk,
	input control_flush,
	input lc3b_word instruction,
	input ctrl_id_ex_load,
	input lc3b_reg dest_id_ex_register,
	
	output logic hazard_stall
);

lc3b_opcode opcode;
lc3b_reg sr1_in;
lc3b_reg sr2_in;

assign opcode = lc3b_opcode'(instruction[15:12]);
assign sr1_in = instruction[8:6];
assign sr2_in = instruction[2:0];

always_comb
begin
	hazard_stall = 0;
	
	/* Data Hazard */
	if (ctrl_id_ex_load && (dest_id_ex_register == sr1_in)) begin
		if ((opcode != op_br) && (opcode != op_lea) && (opcode != op_trap) && (opcode != op_jsr))
			hazard_stall = 1;
		if ((opcode == op_jsr) && (instruction[11] == 0))
			hazard_stall = 1;
	end

	if (ctrl_id_ex_load && (dest_id_ex_register == sr2_in)) begin
		if (instruction[5] == 0 && ((opcode == op_add) || (opcode == op_and)))
			hazard_stall = 1;
	end
	
	if (control_flush)
		hazard_stall = 0;
end

endmodule: hazard_detection