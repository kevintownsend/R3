`timescale 1 ns / 1 ps
module packet_decoder(
    input reset,
    input clk,
    input [63:0] data,
    input push_in,
    //input load_ram,
    output [63:0] value,
    output [31:0] column,
    output [31:0] row,
    output push_out);

    reg [127:0] buffer;
    reg [4:0] count, next_count;

    reg [63:0] r_value;
    reg [31:0] r_column, r_row;
    reg r_push_out;
    integer i;

    //TODO: add block ram.

    always @(posedge clk) begin
        if(reset)begin
            buffer <= 0;
            count <= 0;
            r_push_out <= 0;
        end else begin
    /*
            if(buffer[7:0] == 8'HFF) begin
                next_count = 1;
            end else begin
                next_count = 9;
            end*/
            if(count == 16) begin
                next_count = 0;
                r_push_out <= 1;
                r_value <= buffer[127:64];
                r_column <= buffer[63:32];
                r_row <= buffer[31:0];
            end else begin
                next_count = count;
                r_push_out <= 0;
                r_value <= 0;
                r_column <= 0;
                r_row <= 0;
            end
            if(push_in) begin
                for(i = 0; i < 64; i = i + 1) begin
                    buffer[{next_count, 3'H0} + i] <= data[i];
                end
                next_count = next_count + 8;
            end else begin
            end
            count <= next_count;
        end
    end
    
    assign push_out = r_push_out;
    assign value = r_value;
    assign column = r_column;
    assign row = r_row;

endmodule
