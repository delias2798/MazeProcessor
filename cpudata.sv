import lc3b_types::*;

module cpudata
(
	input lc3b_data cpu,
	input lc3b_data data,
	input lc3b_word wmask,
	
	output lc3b_data out
);

always_comb
begin
	for (int i = 0; i < 16; i++)
		out[i*8 +:8] = wmask[i] ? cpu[i*8 +:8]: data[i*8 +:8];
end

endmodule: cpudata