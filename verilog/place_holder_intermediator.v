`timescale 1 ns / 1 ps
module place_holder_intermediator(
    input reset,
    input clk,
    input valid0,
    input [63:0] value0,
    input [9:0] row0,
    input valid1,
    input [63:0] value1,
    input [9:0] row1,
    output store,
    output [63:0] store_value,
    output add,
    output [63:0] add0,
    output [63:0] add1,
    output [9:0] add_row,
    input flush
    );

    reg r_store;
    reg [63:0] r_store_value;

    always @(posedge clk) begin
        r_store <= valid0;
        r_store_value <= value0;
    end
    assign store = r_store;
    assign store_value = r_store_value;
    assign add0 = 0;
    assign add = 0;
    assign add1 = 0;
    assign add_row = 0;
    
    //stage0 input
    //stage1 control
    //stage2 ram
    //stage3 output
endmodule
