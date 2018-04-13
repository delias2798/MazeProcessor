import lc3b_types::*;

module performance_counter
(
	input clk,
	input load_branch,
	input load_branch_mispred,
	input load_stall,
	input load_l1_hit,
	input load_l2_hit,
	input load_evict_hit,
	input load_l1_miss,
	input load_l2_miss,
	input load_evict_miss,
	input load_curr_stall,
	
	input lc3b_word branch_in,
	input lc3b_word branch_mispred_in,
	input lc3b_word stall_in,
	input lc3b_word l1_hit_in,
	input lc3b_word l2_hit_in,
	input lc3b_word evict_hit_in,
	input lc3b_word l1_miss_in,
	input lc3b_word l2_miss_in,
	input lc3b_word evict_miss_in,
	input lc3b_word curr_stall_in,

	output lc3b_word branch_out,
	output lc3b_word branch_mispred_out,
	output lc3b_word stall_out,
	output lc3b_word l1_hit_out,
	output lc3b_word l2_hit_out,
	output lc3b_word evict_hit_out,
	output lc3b_word l1_miss_out,
	output lc3b_word l2_miss_out,
	output lc3b_word evict_miss_out,
	output lc3b_word curr_stall_out
);

/* Branch */
register branch
(
	.clk(clk),
	.load(load_branch),
	.in(branch_in),
	.out(branch_out)
);

register branch_mispred
(
	.clk(clk),
	.load(load_branch_mispred),
	.in(branch_mispred_in),
	.out(branch_mispred_out)
);

/* Pipeline */
register stall
(
	.clk(clk),
	.load(load_stall),
	.in(stall_in),
	.out(stall_out)
);

/* Cache */
register l1_hit
(
	.clk(clk),
	.load(load_l1_hit),
	.in(l1_hit_in),
	.out(l1_hit_out)
);

register l2_hit
(
	.clk(clk),
	.load(load_l2_hit),
	.in(l2_hit_in),
	.out(l2_hit_out)
);

register evict_hit
(
	.clk(clk),
	.load(load_evict_hit),
	.in(evict_hit_in),
	.out(evict_hit_out)
);

register l1_miss
(
	.clk(clk),
	.load(load_l1_miss),
	.in(l1_miss_in),
	.out(l1_miss_out)
);

register l2_miss
(
	.clk(clk),
	.load(load_l2_miss),
	.in(l2_miss_in),
	.out(l2_miss_out)
);

register evict_miss
(
	.clk(clk),
	.load(load_evict_miss),
	.in(evict_miss_in),
	.out(evict_miss_out)
);

register curr_stall
(
	.clk(clk),
	.load(load_curr_stall),
	.in(curr_stall_in),
	.out(curr_stall_out)
);

endmodule: performance_counter
