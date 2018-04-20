import lc3b_types::*;

module l2_n_array #(parameter width = 128)
(

    input clk,
    input write,
    input lc3b_l2_index index,
	 input lc3b_l2_index index_n,
    input [width-1:0] datain,
    output logic [width-1:0] dataout,
	 output logic [width-1:0] dataout_n
);

logic [width-1:0] data [15:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[index] = datain;
    end
end

assign dataout = data[index];
assign dataout_n = data[index_n];

endmodule : l2_n_array