import lc3b_types::*;

module execute_leapfrog
(
	input lc3b_reg sr1_in,
	input lc3b_reg sr2_in,
	input lc3b_reg dest_in,
	input lc3b_reg dest_ex_mem_register,
	input mem_stall,
	input lc3b_opcode opcode,
	input lc3b_opcode mem_opcode,
	input dest_write,
	input mem_dest_write,
	input load_cc,
	input mem_load_cc,
	
	output logic leapfrog_load,
	output logic mem_dest_overwrite,
	output logic mem_load_cc_overwrite
);

always_comb
begin
	leapfrog_load = 1'b0;
	if (mem_stall) begin
		leapfrog_load = 1'b1;

		if (mem_dest_write && ((sr1_in == dest_ex_mem_register) || (sr2_in == dest_ex_mem_register)))
			leapfrog_load = 1'b0;

		if (opcode == op_ldr || opcode == op_ldi || opcode == op_ldb)
			leapfrog_load = 1'b0;

		if (opcode == op_str || opcode == op_sti || opcode == op_stb)
			leapfrog_load = 1'b0;

		if (opcode == op_trap)
			leapfrog_load = 1'b0;

		if ((opcode == op_br) && mem_load_cc) begin
			leapfrog_load = 1'b0;
		end
	end

	if (leapfrog_load && (dest_in == dest_ex_mem_register) && mem_dest_write && dest_write && (opcode == op_add || opcode == op_and || 
	opcode == op_not || opcode == op_lea || opcode == op_shf))
		mem_dest_overwrite = 1'b1;
	else
		mem_dest_overwrite = 1'b0;

	if (leapfrog_load && load_cc)
		mem_load_cc_overwrite = 1'b1;
	else
		mem_load_cc_overwrite = 1'b0;

	if (mem_opcode == op_trap) begin
		leapfrog_load = 1'b0;
		mem_dest_overwrite = 1'b0;
		mem_load_cc_overwrite = 1'b0;
	end
end

endmodule: execute_leapfrog