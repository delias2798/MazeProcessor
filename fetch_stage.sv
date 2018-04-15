import lc3b_types::*;

module fetch_stage
(
	input clk,
	input control_flush,
	input lc3b_opcode write_opcode,
	input lc3b_reg write_register,
	input lc3b_data imem_rdata,
	input lc3b_word new_pc,
	input lc3b_word write_pc,
	input branch_enable,
	input mem_stall,
	input hazard_stall,
	input imem_resp,
	input unchosen_pred_in,
	
	output lc3b_word imem_address,
	output logic imem_action_stb,
	output logic imem_action_cyc,
	output lc3b_word pc_plus2_out,
	output lc3b_word predicted_pc_out,
	output lc3b_word imem_rdata_out,
	output logic taken,
	output logic unchosen_pred_out
);

/* Control Signals */
logic load_pc;

lc3b_word predicted_pc;
logic btb_hit;
logic write_bht;
logic local_prediction;
logic global_prediction;
logic tournament_prediction;
logic prediction;
logic tournament_taken;

assign load_pc = (!mem_stall & imem_resp & !hazard_stall) || control_flush;
assign imem_action_cyc = 1;
assign imem_action_stb = 1;


/* Internal Signals */
lc3b_word pc_in;

mux2 predicted_pc_mux
(
	.sel(taken),
	.a(pc_plus2_out),
	.b(predicted_pc),
	.f(predicted_pc_out)
);

mux2 pc_mux
(
	.sel(control_flush),
	.a(predicted_pc_out),
	.b(new_pc),
	.f(pc_in)
);

plus2 pc_plus2
(
	.in(imem_address),
	.out(pc_plus2_out)
);

register pc_regsiter
(
	.clk(clk),
	.load(load_pc),
	.in(pc_in),
	.out(imem_address)
);

mux8 imem_rdata_mux
(
	.sel(imem_address[3:1]),
	.a(imem_rdata[15:0]),
	.b(imem_rdata[31:16]),
	.c(imem_rdata[47:32]),
	.d(imem_rdata[63:48]),
	.e(imem_rdata[79:64]),
	.f(imem_rdata[95:80]),
	.g(imem_rdata[111:96]),
	.h(imem_rdata[127:112]),
	.o(imem_rdata_out)
);

/* Branch Predictor */
btb btb
(
	.clk(clk),
	.read_pc(imem_address),
	.write_pc(write_pc),
	.write_data(new_pc),
	.taken(branch_enable),
	.write(write_bht),
	.hit(btb_hit),
	.predicted_pc(predicted_pc)
);

local_bht local_bht
(
	.clk(clk),
	.read_pc(imem_address),
	.write_pc(write_pc),
	.taken(branch_enable),
	.write(write_bht),
	.prediction(local_prediction)
);

global_bht global_bht
(
	.clk(clk),
	.read_pc(imem_address),
	.write_pc(write_pc),
	.taken(branch_enable),
	.write(write_bht),
	.prediction(global_prediction)
);

tournament_bht tournament_bht
(
	.clk(clk),
	.read_pc(imem_address),
	.write_pc(write_pc),
	.taken(branch_enable),
	.write(write_bht),
	.control_flush(control_flush),
	.unchosen_pred(unchosen_pred_in),
	.prediction(tournament_prediction)
);

mux2 #(.width(1)) tournament_predict
(
	.sel(tournament_prediction),
	.a(local_prediction),
	.b(global_prediction),
	.f(tournament_taken)
);

assign taken = tournament_taken & btb_hit;

mux2 #(.width(1)) tournament_predict_unchosen
(
	.sel(tournament_prediction),
	.a(global_prediction),
	.b(local_prediction),
	.f(unchosen_pred_out)
);

assign write_bht = load_pc && ((write_opcode == op_br && write_register) || (write_opcode == op_jmp) || (write_opcode == op_jsr) || (write_opcode == op_trap));

endmodule: fetch_stage