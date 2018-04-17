module wb_interconnect (
    input clk,
    wishbone.slave icache,
    wishbone.slave dcache,
    wishbone.master l2
);

enum int unsigned {
    /* List of states */
	 idle,
	 instruction_stall,
    instruction_connect,
	 data_stall,
	 data_connect
} state, next_state;

always_comb
begin : state_actions
  	/* Default values */
	l2.DAT_M = 128'bX;
	l2.CYC = 0;
	l2.STB = 0;
	l2.WE = 0;
	l2.SEL = 16'bX;
	l2.ADR = 12'bX;
	icache.ACK = 0;
	icache.DAT_S = 128'bX;
	icache.RTY = 0;
	dcache.ACK = 0;
	dcache.DAT_S = 128'bX;
	dcache.RTY = 0;

	case(state)
			idle: begin
			/* DO NOTHING */
			end
			
        instruction_connect: begin
        	l2.DAT_M = icache.DAT_M;
        	l2.CYC = icache.CYC;
        	l2.STB = icache.STB;
        	l2.WE = icache.WE;
        	l2.SEL = icache.SEL;
        	l2.ADR = icache.ADR;
        	icache.ACK = l2.ACK;
			icache.DAT_S = l2.DAT_S;
			icache.RTY = l2.RTY;
			dcache.ACK = 0;
			dcache.DAT_S = 128'bX;
			dcache.RTY = 0;
        end
		  
		  instruction_stall: begin
			/* DO NOTHING */
		  end

        data_connect: begin
        	l2.DAT_M = dcache.DAT_M;
        	l2.CYC = dcache.CYC;
        	l2.STB = dcache.STB;
        	l2.WE = dcache.WE;
        	l2.SEL = dcache.SEL;
        	l2.ADR = dcache.ADR;
        	dcache.ACK = l2.ACK;
			dcache.DAT_S = l2.DAT_S;
			dcache.RTY = l2.RTY;
			icache.ACK = 0;
			icache.DAT_S = 128'bX;
			icache.RTY = 0;
        end
		  
		  data_stall: begin
			/* DO NOTHING */
		  end
   	 endcase
end : state_actions

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
    next_state = state;
      
    case(state)
			idle: begin
				if(icache.CYC == 1 && icache.STB == 1)
					next_state = instruction_connect;
				else if(dcache.CYC == 1 && dcache.STB == 1)
					next_state = data_connect;
			end
			
			instruction_stall: next_state = instruction_connect;
		  
			instruction_connect: begin
				if(l2.ACK) begin
					if(dcache.CYC == 1 && dcache.STB == 1)
						next_state = data_stall;
					else
						next_state = idle;
				end
			end
		  
			data_stall: next_state = data_connect;
		  
			data_connect: begin
				if(l2.ACK) begin
					if(icache.CYC == 1 && icache.STB == 1)
						next_state = instruction_stall;
					else
						next_state = idle;
				end
			end
		  
    endcase
end : next_state_logic


always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
     state <= next_state;
end : next_state_assignment


endmodule : wb_interconnect