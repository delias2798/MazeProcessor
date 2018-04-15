import lc3b_types::*;

module global_bht_history_register #(parameter width = 128)
(

    input clk,
    input write,
    input [width-1:0] datain,
	 output logic [width-1:0] dataout
);

logic [width-1:0] data;

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(negedge clk)
begin
    if (write == 1)
    begin
        data = datain;
    end
end

assign dataout = data;

endmodule : global_bht_history_register
