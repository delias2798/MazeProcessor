import lc3b_types::*;

module eviction_wb_array #(parameter width = 128)
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
        data = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data = datain;
    end
end

assign dataout = data;

endmodule : eviction_wb_array