`timescale 1 ns / 1 ps
module column_counter(
    input reset,
    input clk,
    input push_in,
    output push_out,
    input [31:0] in_col_index,
    output [31:0] out_col_index,
    output [4:0] out_count
);
//TODO: fix counter bug
    reg r_push_out;
    reg [31:0] col_index;
    reg [4:0] counter;
    reg [5:0] timer;
    reg [4:0] r_out_count;
    reg [31:0] col_out_index;
    always @(posedge clk) begin
        if(reset) begin
            timer <= 0;
            r_push_out <= 0;
        end else begin
            r_push_out <= 0;
            if(timer == 0) begin
                if(push_in) begin
                    col_index <= in_col_index;
                    timer <= 1;
                    counter <= 0;
                end
            end else begin
                timer <= timer + 1;
                if(push_in) begin
                    if(col_index == in_col_index) begin
                        counter <= counter + 1;
                        timer <= timer;
                    end else begin
                        counter <= 0;
                        r_push_out <= 1;
                        r_out_count <= counter;
                        col_out_index <= col_index;
                        timer <= 1;
                        col_index <= in_col_index;
                    end
                end else if(timer == 6'H3F) begin
                    counter <= 0;
                    r_push_out <= 1;
                    r_out_count <= counter;
                    col_out_index <= col_index;
                    timer <= 0;
                end
            end
        end
    end
    assign push_out = r_push_out;
    assign out_col_index = col_out_index; //TODO: questionable name
    assign out_count = r_out_count;

endmodule
