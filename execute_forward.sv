import lc3b_types::*;

module execute_forward
(
	input clk,
	input lc3b_reg sr1_in,
	input lc3b_reg sr2_in,
	input lc3b_reg dest_in,
	input lc3b_reg dest_ex_mem_register,
	input lc3b_reg dest_mem_wb_register,
	input ctrl_ex_mem_write,
	input ctrl_mem_wb_write,
	
	input lc3b_opcode opcode,
	
	output logic [1:0] sr1_forward_sel,
	output logic [1:0] sr2_forward_sel,
	output logic pc_forward_sel,
	output logic dest_forward_sel
);

always_comb
begin
	sr1_forward_sel = 2'b00;
	sr2_forward_sel = 2'b00;
	pc_forward_sel = 1'b0;
	dest_forward_sel = 1'b0;
	
	/* MEM Hazard */
	if (ctrl_mem_wb_write && (sr1_in == dest_mem_wb_register))
		sr1_forward_sel = 2'b01;
	
	if (ctrl_mem_wb_write && (sr2_in == dest_mem_wb_register))
		sr2_forward_sel = 2'b01;
		
	if (ctrl_mem_wb_write && (dest_in == dest_mem_wb_register))
		dest_forward_sel = 1'b1;
		
	/* EX Hazard */
	if (ctrl_ex_mem_write && (sr1_in == dest_ex_mem_register))
		sr1_forward_sel = 2'b10;
	
	if (ctrl_ex_mem_write && (sr2_in == dest_ex_mem_register))
		sr2_forward_sel = 2'b10;
	
	/* Forward the address calculated by LEA */
	if (ctrl_ex_mem_write && (sr1_in == dest_ex_mem_register) && (opcode == op_lea))
		sr1_forward_sel = 2'b11;
		
	if (ctrl_ex_mem_write && (sr2_in == dest_ex_mem_register) && (opcode == op_lea))
		sr2_forward_sel = 2'b11;
		
	/* Forward PC when opcode is JSR or TRAP */
	if (ctrl_ex_mem_write && (sr1_in == dest_ex_mem_register) && (opcode == op_trap || opcode == op_jsr)) begin
		pc_forward_sel = 1'b1;
		sr1_forward_sel = 2'b11;
	end
	
	if (ctrl_ex_mem_write && (sr2_in == dest_ex_mem_register) && (opcode == op_trap || opcode == op_jsr)) begin
		pc_forward_sel = 1'b1;
		sr2_forward_sel = 2'b11;
	end
end

endmodule: execute_forward