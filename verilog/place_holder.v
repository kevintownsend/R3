module place_holder(
    input clk,
    input reset,
    input [9:0] row,
    input [63:0] value0,
    input [63:0] value1,
    input wr,
    output push,
    output [63:0] dout,
    input done);

    reg [63:0] r_value;
    reg r_push;

    always @(posedge clk) begin
        r_value <= value0;
        r_push <= wr;
    end
    assign push = r_push;
    assign dout = r_value;

endmodule
