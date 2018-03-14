module interconnect (
    input clk,
    wishbone.slave icache,
    wishbone.slave dcache,
    wishbone.master dram
);

enum int unsigned {
    /* List of states */
    instruction_connect,
	 data_connect
	 
} state, next_state;

logic switch;

always_comb
begin : state_actions
  	
  	dram.DAT_M = icache.DAT_M;
	dram.CYC = icache.CYC;
	dram.STB = icache.STB;
	dram.WE = icache.WE;
	dram.SEL = icache.SEL;
	dram.ADR = icache.ADR;
	icache.ACK = dram.ACK;
	icache.DAT_S = dram.DAT_S;
	icache.RTY = dram.RTY;
	dcache.ACK = 0;
	dcache.DAT_S = 128'bX;
	dcache.RTY = 0;

	case(state)
        instruction_connect: begin
        	/* Do nothing */
        end

        data_connect: begin
        	dram.DAT_M = dcache.DAT_M;
        	dram.CYC = dcache.CYC;
        	dram.STB = dcache.STB;
        	dram.WE = dcache.WE;
        	dram.SEL = dcache.SEL;
        	dram.ADR = dcache.ADR;
        	dcache.ACK = dram.ACK;
			dcache.DAT_S = dram.DAT_S;
			dcache.RTY = dram.RTY;
			icache.ACK = 0;
			icache.DAT_S = 128'bX;
			icache.RTY = 0;

        end
   	 endcase
end : state_actions

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
    next_state = state;
      
    case(state)
        instruction_connect: begin
        	if(dram.ACK) begin
        		if(dcache.CYC == 1 && dcache.STB == 1)
        			next_state = data_connect;		
        	end
        	else begin
        		if(icache.CYC == 0 && dcache.CYC == 1 && dcache.STB == 1)
        			next_state = data_connect;
        	end
        end

        data_connect: begin
         	if(dram.ACK) begin
					next_state = instruction_connect;
				end
        end
    endcase
end : next_state_logic


always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
     state <= next_state;
end : next_state_assignment


endmodule : interconnect