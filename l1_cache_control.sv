module l1_cache_control
(
	input clk,
	
	/* Signals to datapath*/
	output logic valid0_write,
	output logic valid1_write,
	output logic valid_in,
	output logic dirty0_write,
	output logic dirty1_write,
	output logic dirty_in,
	output logic tag0_write,
	output logic tag1_write,
	output logic data0_write,
	output logic data1_write,
	output logic lru_write,
	output logic lru_in,
	output logic pmem_addr_sig,
	output logic data_sig,
	
	/* Signals from datapath*/
	input lru_out,
	input dirty_out,
	input cline0_and,
	input cline1_and,
	input hit,
	
	/* Signals from cpu*/
	input cpu_action_stb,
	input cpu_action_cyc,
	input cpu_write,
	
	/* Signals to cpu*/
	output logic cpu_resp,
	output logic cpu_retry,
	
	/* Signals to memory */
	output logic mem_action_stb,
	output logic mem_action_cyc,
	output logic mem_write,
	
	/* Signals from memory */
	input mem_resp,
	input mem_retry
);

logic resp;

assign cpu_resp = resp;
assign cpu_retry = cpu_action_stb & cpu_action_cyc & (!resp);

enum int unsigned {
    /* List of states */
	 idle,
	 write_back,
	 stall,
	 read_mem
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 valid0_write = 1'b0;
	 valid1_write = 1'b0;
	 valid_in = 1'b0;
	 dirty0_write = 1'b0;
	 dirty1_write = 1'b0;
	 dirty_in = 1'b0;
	 tag0_write = 1'b0;
	 tag1_write = 1'b0;
	 data0_write = 1'b0;
	 data1_write = 1'b0;
	 lru_write = 1'b0;
	 lru_in = 1'b0;
	 pmem_addr_sig = 1'b0;
	 data_sig = 1'b0;
	 resp = 1'b0;
	 mem_action_stb = 1'b0;
	 mem_action_cyc = 1'b0;
	 mem_write = 1'b0;
	 
	 /* Actions for each state */
	 case(state)
		idle: begin
			if (hit && cpu_action_stb && cpu_action_cyc)
			begin
				// Read
				if (!cpu_write)
				begin
					if (cline0_and)
						lru_in = 1;
					else if (cline1_and)
						lru_in = 0;
						
					lru_write = 1;
					resp = 1;
				end
				
				// Write
				if (cpu_write)
				begin
					dirty_in = 1;
					if (cline0_and)
					begin
						dirty0_write = 1;
						data0_write = 1;
						lru_in = 1;
					end
					else if (cline1_and)
					begin
						dirty1_write = 1;
						data1_write = 1;
						lru_in = 0;
					end
					
					lru_write = 1;
					resp = 1;
				end
			end
		end
		
		write_back: begin
			pmem_addr_sig = 1;
			mem_action_stb = 1;
			mem_action_cyc = 1;
			mem_write = 1;
		end
		
		read_mem: begin
			pmem_addr_sig = 0;
			mem_action_stb = 1;
			mem_action_cyc = 1;
			mem_write = 0;
			
			data_sig = 1;
			dirty_in = 0;
			valid_in = 1;
			
			if (mem_resp) begin
				if (lru_out)
				begin
					tag1_write = 1;
					valid1_write = 1;
					dirty1_write = 1;
					data1_write = 1;
					//lru_in = 0;
				end
				else
				begin
					tag0_write = 1;
					valid0_write = 1;
					dirty0_write = 1;
					data0_write = 1;
					//lru_in = 1;
				end
			end
			//lru_write = 1;
		end
		
		default: ;
	 endcase
end

always_comb 
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
		next_state = state;
		case(state)
			idle: begin
				if (hit)
					next_state = idle;
				else if (!hit && !dirty_out && cpu_action_stb && cpu_action_cyc)
					next_state = read_mem;
				else if (!hit && dirty_out && cpu_action_stb && cpu_action_cyc)
					next_state = write_back;
			end
			
			read_mem: begin
				if (!mem_resp)
					next_state = read_mem;
				else
					next_state = idle;
			end
			
			write_back: begin
				if (!mem_resp)
					next_state = write_back;
				else
					next_state = read_mem;
			end
			
			//stall: next_state = read_mem;
			
			default: next_state = idle;
		endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule: l1_cache_control