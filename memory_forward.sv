import lc3b_types::*;

module memory_forward
(
	input clk,
	input lc3b_reg dest_in,
	input lc3b_reg dest_mem_wb_register,
	input ctrl_mem_wb_write,
	
	output logic dest_mem_forward_sel
);

always_comb
begin
	dest_mem_forward_sel = 1'b0;
	
	if (ctrl_mem_wb_write && (dest_in == dest_mem_wb_register))
		dest_mem_forward_sel = 1'b1;
end

endmodule: memory_forward