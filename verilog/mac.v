`timescale 1 ns / 1 ps
module mac(
    input clk,
    input reset,
    input [9:0] row,
    input [63:0] value0,
    input [63:0] value1,
    input wr,
    output push,
    output [63:0] dout,
    input done);

    //multiplier
    reg multiplier_shift [14:0];
    reg [9:0] multiplier_row_shift [14:0];

    reg adder_shift [11:0];
    reg [9:0] adder_row_shift [11:0];

    wire [63:0] multy_result;
    wire [63:0] sum;
    wire inter_add;
    wire [63:0] inter_add0, inter_add1;
    wire [9:0] inter_add_row;
    integer i;

    multiplier multy(
        .clk(clk),
        .result(multy_result),
        .a(value0),
        .b(value1));    

    always @(posedge clk) begin
        multiplier_shift[0] <= wr;
        multiplier_row_shift[0] <= row;
        for(i = 0; i < 14; i = i + 1) begin
            multiplier_shift[i + 1] <= multiplier_shift[i];
            multiplier_row_shift[i + 1] <= multiplier_row_shift[i];
        end
    end
    //TODO: add done signal

    reg [7:0] flush_counter;
    wire flush;
    always @(posedge clk) begin
        if(reset)
            flush_counter <= 0;
        else if(done)
            flush_counter <= flush_counter + 1;
        else
            flush_counter <= 0;
    end
    assign flush = flush_counter[7];

    intermediator inter(
        .reset(reset),
        .clk(clk),
        .valid0(multiplier_shift[14]),
        .value0(multy_result),
        .row0(multiplier_row_shift[14]),
        .valid1(adder_shift[11]),
        .value1(sum),
        .row1(adder_row_shift[11]),
        .store(push),
        .store_value(dout),
        .add(inter_add),
        .add0(inter_add0),
        .add1(inter_add1),
        .add_row(inter_add_row),
        .flush(flush));

    adder addy(
        .clk(clk),
        .result(sum),
        .a(inter_add0),
        .b(inter_add1));

    always @(posedge clk) begin
        adder_shift[0] <= inter_add;
        adder_row_shift[0] <= inter_add_row;
        for(i = 0; i < 11; i = i + 1) begin
            adder_shift[i + 1] <= adder_shift[i];
            adder_row_shift[i + 1] <= adder_row_shift[i];
        end
    end
endmodule
