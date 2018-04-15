import lc3b_types::*;

module memory_stall
(
	input clk,
	input load_ex_mem,
	input dmem_resp,
	input lc3b_opcode opcode,
	input lc3b_word dest_out,
	input lc3b_word alu_out,
	input lc3b_word dmem_data_out,
	input control_flush,
	input lc3b_reg dest_register,

	output logic dmem_action_stb,
	output logic dmem_action_cyc,
	output logic dmem_write,
	output lc3b_mem_wmask dmem_byte_enable,
	output lc3b_word dmem_wdata,
	output logic mem_stall,
	output lc3b_word dmem_address,
	output logic perf_count_sel,
	output lc3b_word perf_count_data
);

logic mem_ack_load;
logic [1:0] mem_ack_in;
logic [1:0] mem_ack_out;
logic mem_addr_mux_sel;

/* Performance Counter Signals*/
logic load_branch;
logic load_branch_mispred;
logic load_stall;
logic load_l1_hit;
logic load_l2_hit;
logic load_evict_hit;
logic load_l1_miss;
logic load_l2_miss;
logic load_evict_miss;
logic load_curr_stall;

lc3b_word branch_in;
lc3b_word branch_out;
lc3b_word branch_mispred_in;
lc3b_word branch_mispred_out;
lc3b_word stall_in;
lc3b_word stall_out;
lc3b_word l1_hit_in;
lc3b_word l1_hit_out;
lc3b_word l2_hit_in;
lc3b_word l2_hit_out;
lc3b_word evict_hit_in;
lc3b_word evict_hit_out;
lc3b_word l1_miss_in;
lc3b_word l1_miss_out;
lc3b_word l2_miss_in;
lc3b_word l2_miss_out;
lc3b_word evict_miss_in;
lc3b_word evict_miss_out;
lc3b_word curr_stall_in;
lc3b_word curr_stall_out;

always_comb
begin
	dmem_action_cyc = 0;
	dmem_action_stb = 0;
	mem_stall = 0;
	mem_addr_mux_sel = 0;
	mem_ack_load = 0;
	mem_ack_in = 2'b00;

	/* Performance Counters */
	load_branch = 0;
	load_branch_mispred = 0;
	load_stall = 0;
	load_l1_hit = 0;
	load_l1_miss = 0;
	load_l2_hit = 0;
	load_l2_miss = 0;
	load_evict_hit = 0;
	load_evict_miss = 0;
	branch_in = branch_out;
	branch_mispred_in = branch_mispred_out;
	stall_in = stall_out;
	l1_hit_in = l1_hit_out;
	l1_miss_in = l1_miss_out;
	l2_hit_in = l2_hit_out;
	l2_miss_in = l2_miss_out;
	evict_hit_in = evict_hit_out;
	evict_miss_in = evict_miss_out;
	perf_count_sel = 0;
	perf_count_data = 16'b0;
	curr_stall_in = 0;

	if (load_ex_mem)
		mem_ack_load = 1;

	if ((opcode == op_ldr) || (opcode == op_str) || (opcode == op_ldb) || (opcode == op_stb) || (opcode == op_trap))
	begin
		dmem_action_cyc = 1;
		dmem_action_stb = 1;
		mem_stall = 1;
	end

	// Write Signal
	if ((opcode == op_stb) || (opcode == op_str))
		dmem_write = 1;
	else
		dmem_write = 0;

	// Mem Byte Enable Signal
	if ((opcode == op_stb) && (dmem_address[0] == 1))
		dmem_byte_enable = 2'b10;
	else if ((opcode == op_stb) && (dmem_address[0] == 0))
		dmem_byte_enable = 2'b01;
	else
		dmem_byte_enable = 2'b11;

	dmem_wdata = dest_out;

	if ((opcode == op_ldi || opcode == op_sti))
	begin
		dmem_action_cyc = 1;
		dmem_action_stb = 1;
		mem_stall = 1;
	end

	if (mem_ack_out == 2'b01 && (opcode == op_ldi || opcode == op_sti))
	begin
		mem_ack_in = mem_ack_out + 2'b01;
		mem_ack_load = 1;
		mem_stall = 1;
	end

	if (mem_ack_out == 2'b10 && (opcode == op_ldi || opcode == op_sti))
	begin
		mem_addr_mux_sel = 1;
		dmem_action_cyc = 1;
		dmem_action_stb = 1;
		mem_stall = 1;
		if (opcode == op_sti)
			dmem_write = 1;
		else
			dmem_write = 0;
	end

	if (dmem_resp)
	begin
		mem_stall = 0;
		if (opcode == op_ldi || opcode == op_sti)
		begin
			mem_ack_in = mem_ack_out + 2'b01;
			if (mem_ack_in == 2'b11)
				mem_ack_in = 2'b00;
			mem_ack_load = 1;
			if (mem_ack_out == 2'b00 || mem_ack_out == 2'b01)
				mem_stall = 1;
		end
	end

	if (control_flush)
	begin
		dmem_action_cyc = 0;
		dmem_action_stb = 0;
		dmem_write = 0;
		mem_stall = 0;
	end

	/* Set Performance Counters */
	if (( ((opcode == op_br) && dest_register) || (opcode == op_jmp) || (opcode == op_jsr) || (opcode == op_trap)) && load_ex_mem) begin
		branch_in = branch_out + 1'b1;
		load_branch = 1;
	end

	if (control_flush) begin
		branch_mispred_in = branch_mispred_out + 1'b1;
		load_branch_mispred = 1;
	end

	if (!load_ex_mem) begin
		stall_in = stall_out + 1'b1;
		load_stall = 1;
		curr_stall_in = curr_stall_out + 1'b1;
	end
	else begin
		if (curr_stall_out == 0) begin
			l1_hit_in = l1_hit_out + 1'b1;
			load_l1_hit = 1;
		end
		else if(curr_stall_out <= 8) begin
			l2_hit_in = l2_hit_out + 1'b1;
			load_l2_hit = 1;

			l1_miss_in = l1_miss_out + 1'b1;
			load_l1_miss = 1;
		end
		else if(curr_stall_out <= 19) begin
			evict_hit_in = evict_hit_out + 1'b1;
			load_evict_hit = 1;

			l2_miss_in = l2_miss_out + 1'b1;
			load_l2_miss = 1;

			l1_miss_in = l1_miss_out + 1'b1;
			load_l1_miss = 1;
		end
		else begin
			evict_miss_in = evict_miss_out + 1'b1;
			load_evict_miss = 1;

			l2_miss_in = l2_miss_out + 1'b1;
			load_l2_miss = 1;

			l1_miss_in = l1_miss_out + 1'b1;
			load_l1_miss = 1;
		end
	end
	load_curr_stall = 1;

	/*
	xFFF0 -> Total branches
	xFFF2 -> Total misprediction
	xFFEA -> Total stalls
	xFFFE -> L1 Hit
	xFFFC -> L1 Miss
	xFFFA -> L2 Hit
	xFFF8 -> L2 Miss
	xFFF6 -> EVICT Hit
	xFFF4 -> EVICT Miss
	*/
	if (dmem_address == 16'hfff0 || dmem_address == 16'hfff2 || dmem_address == 16'hffea
	|| dmem_address == 16'hfffe || dmem_address == 16'hfffc || dmem_address == 16'hfffa
	|| dmem_address == 16'hfff8 || dmem_address == 16'hfff6 || dmem_address == 16'hfff4) begin

		if (opcode == op_ldr || opcode == op_ldi) begin
			if (dmem_address == 16'hfff0)
				perf_count_data = branch_out;
			else if (dmem_address == 16'hfff2 )
				perf_count_data = branch_mispred_out;
			else if (dmem_address == 16'hffea)
				perf_count_data = stall_out;
			else if (dmem_address == 16'hfffe)
				perf_count_data = l1_hit_out;
			else if (dmem_address == 16'hfffc)
				perf_count_data = l1_miss_out;
			else if (dmem_address == 16'hfffa)
				perf_count_data = l2_hit_out;
			else if (dmem_address == 16'hfff8)
				perf_count_data = l2_miss_out;
			else if (dmem_address == 16'hfff6)
				perf_count_data = evict_hit_out;
			else if (dmem_address == 16'hfff4)
				perf_count_data = evict_miss_out;
		end

		if (opcode == op_str || opcode == op_sti) begin
			if (dmem_address == 16'hfff0) begin
				branch_in = 16'b0;
				load_branch = 1;
			end
			else if (dmem_address == 16'hfff2 ) begin
				branch_mispred_in = 16'b0;
				load_branch_mispred = 1;
			end
			else if (dmem_address == 16'hffea ) begin
				stall_in = 16'b0;
				load_stall = 1;
			end
			else if (dmem_address == 16'hfffe ) begin
				l1_hit_in = 16'b0;
				load_l1_hit = 1;
			end
			else if (dmem_address == 16'hfffc ) begin
				l1_miss_in = 16'b0;
				load_l1_miss = 1;
			end
			else if (dmem_address == 16'hfffa ) begin
				l2_hit_in = 16'b0;
				load_l2_hit = 1;
			end
			else if (dmem_address == 16'hfff8 ) begin
				l2_miss_in = 16'b0;
				load_l2_miss = 1;
			end
			else if (dmem_address == 16'hfff6 ) begin
				evict_hit_in = 16'b0;
				load_evict_hit = 1;
			end
			else if (dmem_address == 16'hfff4 ) begin
				evict_miss_in = 16'b0;
				load_evict_miss = 1;
			end
		end

		dmem_action_cyc = 0;
		dmem_action_stb = 0;
		dmem_write = 0;
		mem_stall = 0;
		perf_count_sel = 1;
	end

end

performance_counter p_counter
(
	.clk(clk),
	.load_branch(load_branch),
	.load_branch_mispred(load_branch_mispred),
	.load_stall(load_stall),
	.load_l1_hit(load_l1_hit),
	.load_l2_hit(load_l2_hit),
	.load_evict_hit(load_evict_hit),
	.load_l1_miss(load_l1_miss),
	.load_l2_miss(load_l2_miss),
	.load_evict_miss(load_evict_miss),
	.load_curr_stall(load_curr_stall),
	.branch_in(branch_in),
	.branch_mispred_in(branch_mispred_in),
	.stall_in(stall_in),
	.l1_hit_in(l1_hit_in),
	.l2_hit_in(l2_hit_in),
	.evict_hit_in(evict_hit_in),
	.l1_miss_in(l1_miss_in),
	.l2_miss_in(l2_miss_in),
	.evict_miss_in(evict_miss_in),
	.curr_stall_in(curr_stall_in),
	.branch_out(branch_out),
	.branch_mispred_out(branch_mispred_out),
	.stall_out(stall_out),
	.l1_hit_out(l1_hit_out),
	.l2_hit_out(l2_hit_out),
	.evict_hit_out(evict_hit_out),
	.l1_miss_out(l1_miss_out),
	.l2_miss_out(l2_miss_out),
	.evict_miss_out(evict_miss_out),
	.curr_stall_out(curr_stall_out)
);

register #(.width(2)) mem_curr_ack_counter
(
	.clk(clk),
	.load(mem_ack_load),
	.in(mem_ack_in),
	.out(mem_ack_out)
);

mux2 mem_addr_mux
(
	.sel(mem_addr_mux_sel),
	.a(alu_out),
	.b(dmem_data_out),
	.f(dmem_address)
);

endmodule: memory_stall
