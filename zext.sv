import lc3b_types::*;

/*
 * ZEXT
 */
module zext #(parameter width = 8)
(
    input [width-1:0] in,
    output lc3b_word out
);

assign out = {1'b0, in};

endmodule : zext