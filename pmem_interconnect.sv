module pmem_interconnect (
    input clk,
    wishbone.slave evict,
    wishbone.slave stream,
    wishbone.master pmem
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
	pmem.DAT_M = 128'bX;
	pmem.CYC = 0;
	pmem.STB = 0;
	pmem.WE = 0;
	pmem.SEL = 16'bX;
	pmem.ADR = 12'bX;
	evict.ACK = 0;
	evict.DAT_S = 128'bX;
	evict.RTY = 0;
	stream.ACK = 0;
	stream.DAT_S = 128'bX;
	stream.RTY = 0;

	case(state)
			idle: begin
			/* DO NOTHING */
			end

        instruction_connect: begin
        	pmem.DAT_M = evict.DAT_M;
        	pmem.CYC = evict.CYC;
        	pmem.STB = evict.STB;
        	pmem.WE = evict.WE;
        	pmem.SEL = evict.SEL;
        	pmem.ADR = evict.ADR;
        	evict.ACK = pmem.ACK;
			evict.DAT_S = pmem.DAT_S;
			evict.RTY = pmem.RTY;
			stream.ACK = 0;
			stream.DAT_S = 128'bX;
			stream.RTY = 0;
        end

		  instruction_stall: begin
			/* DO NOTHING */
		  end

        data_connect: begin
        	pmem.DAT_M = stream.DAT_M;
        	pmem.CYC = stream.CYC;
        	pmem.STB = stream.STB;
        	pmem.WE = stream.WE;
        	pmem.SEL = stream.SEL;
        	pmem.ADR = stream.ADR;
        	stream.ACK = pmem.ACK;
			stream.DAT_S = pmem.DAT_S;
			stream.RTY = pmem.RTY;
			evict.ACK = 0;
			evict.DAT_S = 128'bX;
			evict.RTY = 0;
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
				if(evict.CYC == 1 && evict.STB == 1)
					next_state = instruction_connect;
				else if(stream.CYC == 1 && stream.STB == 1)
					next_state = data_connect;
			end

			instruction_stall: next_state = instruction_connect;

			instruction_connect: begin
				if(pmem.ACK) begin
					if(stream.CYC == 1 && stream.STB == 1)
						next_state = data_stall;
					else
						next_state = idle;
				end
			end

			data_stall: next_state = data_connect;

			data_connect: begin
				if(pmem.ACK) begin
					if(evict.CYC == 1 && evict.STB == 1)
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


endmodule : pmem_interconnect
