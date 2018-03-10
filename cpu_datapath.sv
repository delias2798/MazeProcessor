import lc3b_types::*;

module cpu_datapath
(
	input clk,
	
	/* Input and Output for Instruction Cache */
	input lc3b_data imem_rdata,
	input imem_resp,
	output lc3b_word imem_address,
	output logic imem_action_stb,
	output logic imem_action_cyc,
	
	/* Input and Output for Data Cache */
	input lc3b_data dmem_rdata,
	input dmem_resp,
	input dmem_retry,
	output lc3b_word dmem_address,
	output lc3b_word dmem_wdata,
	output logic dmem_action_stb,
	output logic dmem_action_cyc,
	output logic dmem_write,
	output lc3b_mem_wmask dmem_byte_enable
);

/* Internal Signals - Fetch*/
logic load_if_id;
lc3b_word pc_plus2_out;
lc3b_word pc_if_id_out;
lc3b_word imem_rdata_out;
lc3b_word imem_rdata_if_id_out;

/* Fetch Stage (IF) */
fetch_stage if_stage
(
	.clk(clk),
	.imem_rdata(imem_rdata),
	.new_pc(new_pc_mem_wb_out),
	.branch_enable(branch_enable),
	.imem_address(imem_address),
	.pc_plus2_out(pc_plus2_out),
	.imem_rdata_out(imem_rdata_out)
);

/* Fetch - Decode Registers (IF/ID) */
register if_id_pc
(
	.clk(clk),
	.load(load_if_id),
	.in(pc_plus2_out),
	.out(pc_if_id_out)
);

register if_id_ir
(
	.clk(clk),
	.load(load_if_id),
	.in(imem_rdata_out),
	.out(imem_rdata_if_id_out)
);

/* Internal Signals - Decode*/
logic load_id_ex;
lc3b_control_word ctrl;

lc3b_word sr1_out;
lc3b_word sr2_out;
lc3b_word dest_out;
lc3b_reg dest_register;
lc3b_offset8 offset8;
lc3b_offset9 offset9;
lc3b_offset11 offset11;

lc3b_word pc_id_ex_out;
lc3b_word sr1_id_ex_out;
lc3b_word sr2_id_ex_out;
lc3b_word dest_id_ex_out;
lc3b_reg dest_id_ex_register;
lc3b_offset8 offset8_id_ex_out;
lc3b_offset9 offset9_id_ex_out;
lc3b_offset11 offset11_id_ex_out;

/* Decode Stage (ID) */
decode_stage id_stage
(
	.clk(clk),
	.instruction(imem_rdata_if_id_out),
	.write_register(write_register),
	.write_data(write_data),
	.offset8(offset8),
	.offset9(offset9),
	.offset11(offset11),
	.ctrl(ctrl),
	.sr1_out(sr1_out),
	.sr2mux2_out(sr2_out),
	.destmux_out(dest_out),
	.dest_register(dest_register)
);

/* Decode - Execute Registers (ID/EX) */
register id_ex_pc
(
	.clk(clk),
	.load(load_id_ex),
	.in(pc_if_id_out),
	.out(pc_id_ex_out)
);

register id_ex_sr1
(
	.clk(clk),
	.load(load_id_ex),
	.in(sr1_out),
	.out(sr1_id_ex_out)
);

register id_ex_sr2
(
	.clk(clk),
	.load(load_id_ex),
	.in(sr2_out),
	.out(sr2_id_ex_out)
);

register id_ex_dest
(
	.clk(clk),
	.load(load_id_ex),
	.in(dest_out),
	.out(dest_id_ex_out)
);

register #(.width(3)) id_ex_dest_reg
(
	.clk(clk),
	.load(load_id_ex),
	.in(dest_register),
	.out(dest_id_ex_register)
);

register #(.width(8)) id_ex_offset8
(
	.clk(clk),
	.load(load_id_ex),
	.in(offset8),
	.out(offset8_id_ex_out)
);

register #(.width(9)) id_ex_offset9
(
	.clk(clk),
	.load(load_id_ex),
	.in(offset9),
	.out(offset9_id_ex_out)
);

register #(.width(11)) id_ex_offset11
(
	.clk(clk),
	.load(load_id_ex),
	.in(offset11),
	.out(offset11_id_ex_out)
);

/* Internal Signals - Execute */
logic load_ex_mem;

lc3b_word pc_br;
lc3b_word pc_j;
lc3b_word alu_out;

lc3b_word pc_ex_mem_out;
lc3b_word pc_br_ex_mem_out;
lc3b_word pc_j_ex_mem_out;
lc3b_word alu_ex_mem_out;
lc3b_word dest_ex_mem_out;
lc3b_reg dest_ex_mem_register;

/* Execute Stage (EX) */
execute_stage ex_stage
(
	.clk(clk),
	.offset9(offset9_id_ex_out),
	.offset11(offset11_id_ex_out),
	.pc(pc_id_ex_out),
	.sr1(sr1_id_ex_out),
	.sr2(sr2_id_ex_out),
	.offset8(offset8_id_ex_out),
	.br_add_out(pc_br),
	.bradd2mux_out(pc_j),
	.alumux_out(alu_out)
);

/* Execute - Memory Registers (EX/MEM) */
register ex_mem_pc
(
	.clk(clk),
	.load(load_ex_mem),
	.in(pc_id_ex_out),
	.out(pc_ex_mem_out)
);

register ex_mem_pc_br
(
	.clk(clk),
	.load(load_ex_mem),
	.in(pc_br),
	.out(pc_br_ex_mem_out)
);

register ex_mem_pc_j
(
	.clk(clk),
	.load(load_ex_mem),
	.in(pc_j),
	.out(pc_j_ex_mem_out)
);

register ex_mem_alu
(
	.clk(clk),
	.load(load_ex_mem),
	.in(alu_out),
	.out(alu_ex_mem_out)
);

register ex_mem_dest
(
	.clk(clk),
	.load(load_ex_mem),
	.in(dest_id_ex_out),
	.out(dest_ex_mem_out)
);

register #(.width(3)) ex_mem_dest_reg
(
	.clk(clk),
	.load(load_ex_mem),
	.in(dest_id_ex_register),
	.out(dest_ex_mem_register)
);

/* Internal Signals - Memory */
logic load_mem_wb;
lc3b_word new_pc;

lc3b_word pc_mem_wb_out;
lc3b_word new_pc_mem_wb_out;
lc3b_word pc_br_mem_wb_out;
lc3b_word dmem_wdata_mem_wb;
lc3b_word alu_mem_wb_out;
lc3b_word dmem_address_mem_wb;
lc3b_reg dest_mem_wb_register;

/* Memory Stage (MEM) */
memory_stage mem_stage
(
	.clk(clk),
	.alu_out(alu_ex_mem_out),
	.pc_br_out(pc_br_ex_mem_out),
	.pc_j_out(pc_j_ex_mem_out),
	.dmem_rdata(dmem_rdata),
	.dest_out(dest_ex_mem_out),
	.pc_out(new_pc),
	.dmem_address(dmem_address),
	.dmem_wdata(dmem_wdata),
	.dmem_write(dmem_write),
	.dmem_byte_enable(dmem_byte_enable)
);

/* Memory - Write-Back Registers (MEM/WB) */
register mem_wb_pc
(
	.clk(clk),
	.load(load_mem_wb),
	.in(pc_ex_mem_out),
	.out(pc_mem_wb_out)
);

register mem_wb_dmem_address
(
	.clk(clk),
	.load(load_mem_wb),
	.in(dmem_address),
	.out(dmem_address_mem_wb)
);

register mem_wb_new_pc
(
	.clk(clk),
	.load(load_mem_wb),
	.in(new_pc),
	.out(new_pc_mem_wb_out)
);

register mem_wb_pc_br
(
	.clk(clk),
	.load(load_mem_wb),
	.in(pc_br_ex_mem_out),
	.out(pc_br_mem_wb_out)
);

register mem_wb_mem_wdata
(
	.clk(clk),
	.load(load_mem_wb),
	.in(dmem_wdata),
	.out(dmem_wdata_mem_wb)
);

register mem_wb_alu
(
	.clk(clk),
	.load(load_mem_wb),
	.in(alu_ex_mem_out),
	.out(alu_mem_wb_out)
);

register #(.width(3)) mem_wb_dest_reg
(
	.clk(clk),
	.load(load_mem_wb),
	.in(dest_ex_mem_register),
	.out(dest_mem_wb_register)
);

/* Internal Signals - Write-Back */
lc3b_reg write_register;
lc3b_word write_data;
logic branch_enable;

/* Write-Back Stage (WB) */
write_back_stage wb_stage
(
	.clk(clk),
	.pc_br(pc_br_mem_wb_out),
	.pc(pc_mem_wb_out),
	.dmem_address(dmem_address_mem_wb),
	.dmem_wdata(dmem_wdata_mem_wb),
	.alu_out(alu_mem_wb_out),
	.dest_register(dest_mem_wb_register),
	.write_data(write_data),
	.branch_enable(branch_enable)
);

assign write_register = dest_mem_wb_register;

endmodule: cpu_datapath