import lc3b_types::*;

module regfile
(
    input clk,
    input load,
    input lc3b_word data_in,
    input lc3b_reg src_a, src_b, src_c, dest,
    output lc3b_word reg_a, reg_b, reg_c
);

lc3b_word data [7:0] /* synthesis ramstyle = "logic" */;

/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 16'b0;
    end
end

always_ff @(negedge clk)
begin
    if (load == 1)
    begin
        data[dest] = data_in;
    end
end

always_comb
begin
    reg_a = data[src_a];
    reg_b = data[src_b];
	 reg_c = data[src_c];
end

endmodule : regfile
