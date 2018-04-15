import lc3b_types::*;

module cpu_datapath
(
	input clk,
	
	/* Input and Output for Instruction Cache */
	input lc3b_data imem_rdata,
	input imem_resp,
	input imem_retry,
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
logic taken;
logic load_if_id;
lc3b_word pc_plus2_out;
lc3b_word pc_plus2_out_flush;
lc3b_word pc_if_id_in;
lc3b_word pc_if_id_out;
lc3b_word imem_address_flush;
lc3b_word curr_pc_if_id_in;
lc3b_word curr_pc_if_id_out;
lc3b_word predicted_pc_out;
lc3b_word predicted_pc_out_flush;
lc3b_word predicted_pc_if_id_in;
lc3b_word predicted_pc_if_id_out;
lc3b_word imem_rdata_out_flush;
lc3b_word imem_rdata_out;
lc3b_word imem_rdata_if_id_out;
logic branch_prediction;
logic branch_prediction_flush;
logic branch_prediction_if_id_in;
logic branch_prediction_if_id_out;
logic unchosen_pred_in;
logic unchosen_pred_out;
logic unchosen_pred_flush;
logic unchosen_pred_if_id_in;
logic unchosen_pred_if_id_out;

/* Internal Signals - Decode*/
logic load_id_ex;
logic load_regfile;
logic hazard_stall;
lc3b_control_word ctrl;
lc3b_control_word ctrl_in;

lc3b_reg sr1_in;
lc3b_reg sr2_in;
lc3b_reg dest_in;
lc3b_word sr1_out;
lc3b_word sr2_out;
lc3b_word sr2mux_out;
lc3b_word dest_out;
lc3b_offset8 offset8;
lc3b_offset9 offset9;
lc3b_offset11 offset11;

lc3b_control_word ctrl_id_ex;
lc3b_control_word ctrl_id_ex_in;
logic unchosen_pred_id_ex_in;
logic unchosen_pred_id_ex_out;
lc3b_word pc_id_ex_in;
lc3b_word pc_id_ex_out;
logic branch_prediction_id_ex_in;
logic branch_prediction_id_ex_out;
lc3b_word curr_pc_id_ex_in;
lc3b_word curr_pc_id_ex_out;
lc3b_word predicted_pc_id_ex_in;
lc3b_word predicted_pc_id_ex_out;
lc3b_reg sr1_id_ex_in;
lc3b_reg sr2_id_ex_in;
lc3b_reg dest_id_ex_in;
lc3b_word sr1_id_ex_out;
lc3b_word sr2_id_ex_out;
lc3b_word sr2mux_id_ex_out;
lc3b_word dest_id_ex_out;
lc3b_offset8 offset8_id_ex_out;
lc3b_offset9 offset9_id_ex_out;
lc3b_offset11 offset11_id_ex_out;

/* Internal Signals - Execute */
logic load_ex_mem;

lc3b_word pc_br;
lc3b_word pc_j;
lc3b_word alu_out;
lc3b_word destmux_out;

lc3b_control_word ctrl_ex_mem;
lc3b_reg dest_ex_mem_in;
logic unchosen_pred_ex_mem_in;
logic unchosen_pred_ex_mem_out;
lc3b_word pc_ex_mem_in;
lc3b_word pc_ex_mem_out;
logic branch_prediction_ex_mem_in;
logic branch_prediction_ex_mem_out;
lc3b_word curr_pc_ex_mem_in;
lc3b_word curr_pc_ex_mem_out;
lc3b_word predicted_pc_ex_mem_in;
lc3b_word predicted_pc_ex_mem_out;
lc3b_word pc_br_ex_mem_out;
lc3b_word pc_j_ex_mem_out;
lc3b_word alu_ex_mem_out;
lc3b_word dest_ex_mem_out;

logic [1:0] sr1_forward_sel;
logic [1:0] sr2_forward_sel;
logic pc_forward_sel;
logic dest_forward_sel;

/* Internal Signals - Memory */
logic load_mem_wb;
logic mem_stall;
logic dest_mem_forward_sel;
lc3b_word new_pc;

logic control_flush;

lc3b_control_word ctrl_ex_mem_in;
lc3b_control_word ctrl_mem_wb;
logic unchosen_pred_mem_wb_out;
lc3b_word pc_mem_wb_out;
logic branch_prediction_mem_wb_out;
lc3b_word curr_pc_mem_wb_out;
lc3b_word predicted_pc_mem_wb_out;
lc3b_word new_pc_after_flush;
lc3b_word new_pc_mem_wb_out;
lc3b_word pc_br_mem_wb_out;
lc3b_word dmem_wdata_mem_wb;
lc3b_word alu_mem_wb_out;
lc3b_word dmem_address_mem_wb;
lc3b_word dmem_rdata_out;

/* Internal Signals - Write-Back */
lc3b_word write_pc;
lc3b_opcode opcode;
lc3b_reg write_register;
lc3b_word write_data;
logic branch_enable;

/* Assign load signals for CP1 */
assign load_if_id = !mem_stall & imem_resp & !hazard_stall;
assign load_id_ex = !mem_stall & imem_resp;
assign load_ex_mem = !mem_stall & imem_resp;
assign load_mem_wb = !mem_stall & imem_resp;

/* Fetch Stage (IF) */
fetch_stage if_stage
(
	.clk(clk),
	.control_flush(control_flush),
	.imem_rdata(imem_rdata),
	.write_opcode(opcode),
	.write_register(write_register),
	.new_pc(new_pc_after_flush),
	.write_pc(write_pc),
	.branch_enable(branch_enable),
	.mem_stall(mem_stall),
	.hazard_stall(hazard_stall),
	.imem_resp(imem_resp),
	.unchosen_pred_in(unchosen_pred_in),
	.imem_address(imem_address),
	.imem_action_stb(imem_action_stb),
	.imem_action_cyc(imem_action_cyc),
	.pc_plus2_out(pc_plus2_out),
	.predicted_pc_out(predicted_pc_out),
	.imem_rdata_out(imem_rdata_out),
	.taken(branch_prediction),
	.unchosen_pred_out(unchosen_pred_out)
);

assign imem_rdata_out_flush = control_flush ? 16'b0 : imem_rdata_out;
assign pc_plus2_out_flush = control_flush ? 16'b0 : pc_plus2_out;
assign imem_address_flush = control_flush ? 16'b0 : imem_address;
assign predicted_pc_out_flush = control_flush ? 16'b0 : predicted_pc_out;
assign branch_prediction_flush = control_flush ? 1'b0 : branch_prediction;
assign unchosen_pred_flush = control_flush ? 1'b0 : unchosen_pred_out;

/* Fetch - Decode Registers (IF/ID) */
register #(.width(1)) if_id_branch_prediction
(
	.clk(clk),
	.load(load_if_id),
	.in(branch_prediction_flush),
	.out(branch_prediction_if_id_out)
);

register #(.width(1)) if_id_unchosen_pred
(
	.clk(clk),
	.load(load_if_id),
	.in(unchosen_pred_flush),
	.out(unchosen_pred_if_id_out)
);

register if_id_pc
(
	.clk(clk),
	.load(load_if_id),
	.in(pc_plus2_out_flush),
	.out(pc_if_id_out)
);

register if_id_curr_pc
(
	.clk(clk),
	.load(load_if_id),
	.in(imem_address_flush),
	.out(curr_pc_if_id_out)
);

register if_id_predicted_pc
(
	.clk(clk),
	.load(load_if_id),
	.in(predicted_pc_out_flush),
	.out(predicted_pc_if_id_out)
);

register if_id_ir
(
	.clk(clk),
	.load(load_if_id),
	.in(imem_rdata_out_flush),
	.out(imem_rdata_if_id_out)
);

/* Decode Stage (ID) */
decode_stage id_stage
(
	.clk(clk),
	.instruction(imem_rdata_if_id_out),
	.write_register(write_register),
	.write_data(write_data),
	.load_regfile(load_regfile),
	.hazard_stall(hazard_stall),
	.offset8(offset8),
	.offset9(offset9),
	.offset11(offset11),
	.ctrl(ctrl),
	.sr1_in(sr1_in),
	.sr2_in(sr2_in),
	.dest(dest_in),
	.sr1_out(sr1_out),
	.sr2_out(sr2_out),
	.sr2mux_out(sr2mux_out),
	.dest_out(dest_out)
);

hazard_detection hazard_detection_unit
(
	.clk(clk),
	.control_flush(control_flush),
	.instruction(imem_rdata_if_id_out),
	.ctrl_id_ex_load(ctrl_id_ex.load_hazard),
	.dest_id_ex_register(ctrl_id_ex.dest_register),
	.hazard_stall(hazard_stall)
);

assign ctrl_in = (control_flush || hazard_stall) ? 25'b0 : ctrl;
assign pc_if_id_in = (control_flush || hazard_stall) ? 16'b0 : pc_if_id_out;
assign curr_pc_if_id_in = (control_flush || hazard_stall) ? 16'b0 : curr_pc_if_id_out;
assign predicted_pc_if_id_in = (control_flush || hazard_stall) ? 16'b0 : predicted_pc_if_id_out;
assign branch_prediction_if_id_in = (control_flush || hazard_stall) ? 1'b0 : branch_prediction_if_id_out;
assign unchosen_pred_if_id_in = (control_flush || hazard_stall) ? 1'b0 : unchosen_pred_if_id_out;

/* Decode - Execute Registers (ID/EX) */
register_control_rom id_ex_ctrl
(
	.clk(clk),
	.load(load_id_ex),
	.in(ctrl_in),
	.out(ctrl_id_ex)
);

register #(.width(1)) id_ex_unchosen_pred
(
	.clk(clk),
	.load(load_id_ex),
	.in(unchosen_pred_if_id_in),
	.out(unchosen_pred_id_ex_out)
);

register id_ex_pc
(
	.clk(clk),
	.load(load_id_ex),
	.in(pc_if_id_in),
	.out(pc_id_ex_out)
);

register #(.width(1)) id_ex_branch_pred
(
	.clk(clk),
	.load(load_id_ex),
	.in(branch_prediction_if_id_in),
	.out(branch_prediction_id_ex_out)
);

register id_ex_curr_pc
(
	.clk(clk),
	.load(load_id_ex),
	.in(curr_pc_if_id_in),
	.out(curr_pc_id_ex_out)
);

register id_ex_predicted_pc
(
	.clk(clk),
	.load(load_id_ex),
	.in(predicted_pc_if_id_in),
	.out(predicted_pc_id_ex_out)
);

register #(.width(3)) id_ex_sr1_in
(
	.clk(clk),
	.load(load_id_ex),
	.in(sr1_in),
	.out(sr1_id_ex_in)
);

register #(.width(3)) id_ex_sr2_in
(
	.clk(clk),
	.load(load_id_ex),
	.in(sr2_in),
	.out(sr2_id_ex_in)
);

register #(.width(3)) id_ex_dest_in
(
	.clk(clk),
	.load(load_id_ex),
	.in(dest_in),
	.out(dest_id_ex_in)
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

register id_ex_sr2mux
(
	.clk(clk),
	.load(load_id_ex),
	.in(sr2mux_out),
	.out(sr2mux_id_ex_out)
);

register id_ex_dest
(
	.clk(clk),
	.load(load_id_ex),
	.in(dest_out),
	.out(dest_id_ex_out)
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

/* Execute Stage (EX) */
execute_stage ex_stage
(
	.clk(clk),
	.offset9(offset9_id_ex_out),
	.offset11(offset11_id_ex_out),
	.pc(pc_id_ex_out),
	.alu_ex_mem_out(alu_ex_mem_out),
	.pc_br_ex_mem_out(pc_br_ex_mem_out),
	.pc_ex_mem_out(pc_ex_mem_out),
	.write_data(write_data),
	.sr1(sr1_id_ex_out),
	.sr2(sr2_id_ex_out),
	.sr2mux_out(sr2mux_id_ex_out),
	.offset8(offset8_id_ex_out),
	.dest_out(dest_id_ex_out),
	.sr1_forward_sel(sr1_forward_sel),
	.sr2_forward_sel(sr2_forward_sel),
	.pc_forward_sel(pc_forward_sel),
	.dest_forward_sel(dest_forward_sel),
	.bradd2mux_sel(ctrl_id_ex.bradd2mux_sel),
	.aluop(ctrl_id_ex.aluop),
	.sr2mux_sel(ctrl_id_ex.sr2mux2_sel),
	.alumux_sel(ctrl_id_ex.alumux_sel),
	.br_add_out(pc_br),
	.bradd2mux_out(pc_j),
	.alumux_out(alu_out),
	.destmux_out(destmux_out)
);

execute_forward ex_forward
(
	.clk(clk),
	.sr1_in(sr1_id_ex_in),
	.sr2_in(sr2_id_ex_in),
	.dest_in(dest_id_ex_in),
	.dest_ex_mem_register(ctrl_ex_mem.dest_register),
	.dest_mem_wb_register(ctrl_mem_wb.dest_register),
	.ctrl_ex_mem_write(ctrl_ex_mem.alu_forward),
	.ctrl_mem_wb_write(ctrl_mem_wb.load_regfile),
	.opcode(ctrl_ex_mem.opcode),
	.sr1_forward_sel(sr1_forward_sel),
	.sr2_forward_sel(sr2_forward_sel),
	.pc_forward_sel(pc_forward_sel),
	.dest_forward_sel(dest_forward_sel)
);

assign ctrl_id_ex_in = control_flush ? 25'b0 : ctrl_id_ex;
assign branch_prediction_id_ex_in = control_flush ? 1'b0 : branch_prediction_id_ex_out;
assign pc_id_ex_in = control_flush ? 16'b0 : pc_id_ex_out;
assign curr_pc_id_ex_in = control_flush ? 16'b0 : curr_pc_id_ex_out;
assign predicted_pc_id_ex_in = control_flush ? 16'b0 : predicted_pc_id_ex_out;
assign unchosen_pred_id_ex_in = control_flush ? 1'b0 : unchosen_pred_id_ex_out;

/* Execute - Memory Registers (EX/MEM) */
register_control_rom ex_mem_ctrl
(
	.clk(clk),
	.load(load_ex_mem),
	.in(ctrl_id_ex_in),
	.out(ctrl_ex_mem)
);

register #(.width(1)) ex_mem_unchosen_pred
(
	.clk(clk),
	.load(load_ex_mem),
	.in(unchosen_pred_id_ex_in),
	.out(unchosen_pred_ex_mem_out)
);

register #(.width(1)) ex_mem_branch_pred
(
	.clk(clk),
	.load(load_ex_mem),
	.in(branch_prediction_id_ex_in),
	.out(branch_prediction_ex_mem_out)
);

register #(.width(3)) ex_mem_dest_in
(
	.clk(clk),
	.load(load_ex_mem),
	.in(dest_id_ex_in),
	.out(dest_ex_mem_in)
);

register ex_mem_pc
(
	.clk(clk),
	.load(load_ex_mem),
	.in(pc_id_ex_in),
	.out(pc_ex_mem_out)
);

register ex_mem_curr_pc
(
	.clk(clk),
	.load(load_ex_mem),
	.in(curr_pc_id_ex_in),
	.out(curr_pc_ex_mem_out)
);

register ex_mem_predicted_pc
(
	.clk(clk),
	.load(load_ex_mem),
	.in(predicted_pc_id_ex_in),
	.out(predicted_pc_ex_mem_out)
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
	.in(destmux_out),
	.out(dest_ex_mem_out)
);

/* Memory Stage (MEM) */
memory_stage mem_stage
(
	.clk(clk),
	.load_ex_mem(load_ex_mem),
	.alu_out(alu_ex_mem_out),
	.pc_br_out(pc_br_ex_mem_out),
	.pc_j_out(pc_j_ex_mem_out),
	.dmem_rdata(dmem_rdata),
	.dest_out(dest_ex_mem_out),
	.dmem_resp(dmem_resp),
	.write_data(write_data),
	.dest_register(ctrl_ex_mem.dest_register),
	.newpcmux_sel(ctrl_ex_mem.newpcmux_sel),
	.opcode(ctrl_ex_mem.opcode),
	.dest_mem_forward_sel(dest_mem_forward_sel),
	.control_flush(control_flush),
	.pc_out(new_pc),
	.dmem_address(dmem_address),
	.dmem_wdata(dmem_wdata),
	.dmem_action_stb(dmem_action_stb),
	.dmem_action_cyc(dmem_action_cyc),
	.dmem_write(dmem_write),
	.dmem_rdata_out(dmem_rdata_out),
	.dmem_byte_enable(dmem_byte_enable),
	.mem_stall(mem_stall)
);

memory_forward mem_forward
(
	.clk(clk),
	.dest_in(dest_ex_mem_in),
	.dest_mem_wb_register(ctrl_mem_wb.dest_register),
	.ctrl_mem_wb_write(ctrl_mem_wb.load_regfile),
	.dest_mem_forward_sel(dest_mem_forward_sel)
);

assign ctrl_ex_mem_in = control_flush ? 25'b0 : ctrl_ex_mem;
assign branch_prediction_ex_mem_in = control_flush ? 1'b0 : branch_prediction_ex_mem_out;
assign pc_ex_mem_in = control_flush ? 16'b0 : pc_ex_mem_out;
assign curr_pc_ex_mem_in = control_flush ? 16'b0 : curr_pc_ex_mem_out;
assign predicted_pc_ex_mem_in = control_flush ? 16'b0 : predicted_pc_ex_mem_out;
assign unchosen_pred_ex_mem_in = control_flush ? 1'b0 : unchosen_pred_ex_mem_out;

/* Memory - Write-Back Registers (MEM/WB) */
register_control_rom mem_wb_ctrl
(
	.clk(clk),
	.load(load_mem_wb),
	.in(ctrl_ex_mem_in),
	.out(ctrl_mem_wb)
);

register #(.width(1)) mem_wb_unchosen_pred
(
	.clk(clk),
	.load(load_mem_wb),
	.in(unchosen_pred_ex_mem_in),
	.out(unchosen_pred_mem_wb_out)
);

register #(.width(1)) mem_wb_branch_pred
(
	.clk(clk),
	.load(load_mem_wb),
	.in(branch_prediction_ex_mem_in),
	.out(branch_prediction_mem_wb_out)
);

register mem_wb_pc
(
	.clk(clk),
	.load(load_mem_wb),
	.in(pc_ex_mem_in),
	.out(pc_mem_wb_out)
);

register mem_wb_curr_pc
(
	.clk(clk),
	.load(load_mem_wb),
	.in(curr_pc_ex_mem_in),
	.out(curr_pc_mem_wb_out)
);

register mem_wb_predicted_pc
(
	.clk(clk),
	.load(load_mem_wb),
	.in(predicted_pc_ex_mem_in),
	.out(predicted_pc_mem_wb_out)
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
	.in(dmem_rdata_out),
	.out(dmem_wdata_mem_wb)
);

register mem_wb_alu
(
	.clk(clk),
	.load(load_mem_wb),
	.in(alu_ex_mem_out),
	.out(alu_mem_wb_out)
);

/* Write-Back Stage (WB) */
write_back_stage wb_stage
(
	.clk(clk),
	.pc_br(pc_br_mem_wb_out),
	.pc(pc_mem_wb_out),
	.dmem_address(dmem_address_mem_wb),
	.dmem_wdata(dmem_wdata_mem_wb),
	.alu_out(alu_mem_wb_out),
	.dest_register(ctrl_mem_wb.dest_register),
	.predicted_pc_mem_wb_out(predicted_pc_mem_wb_out),
	.branch_prediction_mem_wb_out(branch_prediction_mem_wb_out),
	.new_pc_mem_wb_out(new_pc_mem_wb_out),
	.opcode(ctrl_mem_wb.opcode),
	.load_cc(ctrl_mem_wb.load_cc),
	.regfilemux_sel(ctrl_mem_wb.regfilemux_sel),
	.write_data(write_data),
	.branch_enable(branch_enable),
	.control_flush(control_flush),
	.new_pc_after_flush(new_pc_after_flush)
);

assign write_register = ctrl_mem_wb.dest_register;
assign load_regfile = ctrl_mem_wb.load_regfile;

assign write_pc = curr_pc_mem_wb_out;
assign opcode = ctrl_mem_wb.opcode;

assign unchosen_pred_in = unchosen_pred_mem_wb_out;

endmodule: cpu_datapath