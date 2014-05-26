`timescale 1 ns / 1 ps
module intermediator(
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

    reg [2:0] ctl0_stg0, ctl0_stg1, ctl0_stg2, ctl0_stg3, ctl0_stg4;
    reg [2:0] ctl1_stg0, ctl1_stg1, ctl1_stg2, ctl1_stg3, ctl1_stg4;
    reg ctl_com_stg0, ctl_com_stg1, ctl_com_stg2, ctl_com_stg3, ctl_com_stg4;

    reg [63:0] value0_stg0, value0_stg1, value0_stg2, value0_stg3, value0_stg4;
    reg [9:0] row0_stg0, row0_stg1, row0_stg2, row0_stg3, row0_stg4;
    reg [63:0] value1_stg0, value1_stg1, value1_stg2, value1_stg3, value1_stg4;
    reg [9:0] row1_stg0, row1_stg1, row1_stg2, row1_stg3, row1_stg4;
    
    reg [9:0] lur, har;

    reg [31:0] waiter;
    reg [1:0] waiter_state;
    `define IDLE 0
    `define START 1
    `define STEADY 2
    `define FINISH 3

    reg store_ready;
    reg r_store;
    reg [63:0] r_store_value;
    reg r_add;
    reg [63:0] r_add0;
    reg [63:0] r_add1;
    reg [63:0] r_add_row;
    
    wire [63:0] ram_value0, ram_value1;
    //OPTIONAL: reduce latency by getting values later.
    always @(posedge clk) begin
        if(reset) begin
            ctl0_stg0 <= 0;
            ctl1_stg0 <= 0;
            ctl_com_stg0 <= 0;
        end else begin
            ctl0_stg0 <= {2'H0, valid0};
            ctl1_stg0 <= {2'H0, valid1};
            ctl_com_stg0 <= 0;
        end
        value0_stg0 <= value0;
        row0_stg0 <= row0;
        value1_stg0 <= value1;
        row1_stg0 <= row1;
    end

    always @(posedge clk) begin
        ctl0_stg1 <= ctl0_stg0;
        ctl1_stg1 <= ctl1_stg0;
        ctl_com_stg1 <= (row1_stg0 == row0_stg0) && ctl0_stg0[0] && ctl1_stg0[0];
        value0_stg1 <= value0_stg0;
        row0_stg1 <= row0_stg0;
        value1_stg1 <= value1_stg0;
        row1_stg1 <= row1_stg0;
    end

    always @(posedge clk) begin
        ctl0_stg2 <= ctl0_stg1;
        ctl1_stg2 <= ctl1_stg1;
        if(ctl_com_stg1) begin
            ctl0_stg2[1:0] <= 0;
            ctl1_stg2[1:0] <= 0;
        end
        ctl_com_stg2 <= ctl_com_stg1;
        value0_stg2 <= value0_stg1;
        row0_stg2 <= row0_stg1;
        value1_stg2 <= value1_stg1;
        row1_stg2 <= row1_stg1;
        if(store_ready) begin
            if(!(ctl0_stg1[0])) begin
                ctl0_stg2[2] <= 1;
                row0_stg2 <= lur;
            end else if(!ctl1_stg1[0]) begin
                ctl1_stg2[2] <= 1;
                row1_stg2 <= lur;
            end
        end
    end

    //TODO: add state: IDLE, Start, Steady, Finish
    //waiter logic
    always @(posedge clk) begin
        if(reset) begin
            lur <= 0;
            har <= 0;
            waiter <= 0;
            waiter_state <= `IDLE;
            store_ready <= 0;
        end else begin
            store_ready <= 0;
            har <= {row0_stg0[9:4] + 1, 4'H0};
            if(har[4] == row0_stg0[4]) begin
                if(har[4])
                    waiter[31:16] <= 0;
                else
                    waiter[15:0] <= 0;
            end
            case(waiter_state)
                `IDLE: begin
                    if(ctl0_stg0[0]) begin
                        waiter_state <= `START;
                        lur <= {row0_stg0[9:4], 4'H0};
                    end
                    waiter <= 0;
                end
                `START: begin
                    if(lur[9:4] + 6'H3 == har[9:4])
                        waiter_state <= `STEADY;
                    if(flush)
                        waiter_state <= `FINISH;
                end
                `STEADY: begin
                    if(lur[9:4] + 6'H3 != har[9:4])begin
                        store_ready <= 1;
                    end
                    if(flush)
                        waiter_state <= `FINISH;
                end
                `FINISH: begin
                    store_ready <= 1;
                    if(lur == har)
                        waiter_state <= `IDLE;
                end
            endcase
            if((!ctl0_stg1[0] || !ctl1_stg1[0]) && store_ready)
                lur <= lur + 1;
            if(ctl0_stg2[0]) begin
                waiter[row0_stg2[4:0]] <= ~waiter[row0_stg2[4:0]];
            end
            if(ctl1_stg2[0])
                waiter[row1_stg2[4:0]] <= ~waiter[row1_stg2[4:0]];
        end
    end

    wire occupied0, occupied1;

    assign occupied0 = waiter[row0_stg2[4:0]];
    assign occupied1 = waiter[row1_stg2[4:0]];

    always @(posedge clk) begin
        ctl0_stg3 <= ctl0_stg2;
        ctl1_stg3 <= ctl1_stg2;
        ctl0_stg3[1] <= ctl0_stg2[0] && !occupied0;
        ctl1_stg3[1] <= ctl1_stg2[0] && !occupied1;
        ctl_com_stg3 <= ctl_com_stg2;
        value0_stg3 <= value0_stg2;
        row0_stg3 <= row0_stg2;
        value1_stg3 <= value1_stg2;
        row1_stg3 <= row1_stg2;
    end
    
    block_ram_64x1024 ram(
        .clka(clk),
        .wea(ctl0_stg3[1]),
        .addra(row0_stg3),
        .dina(value0_stg3),
        .douta(ram_value0),
        .clkb(clk),
        .web(ctl1_stg3[1]),
        .addrb(row1_stg3),
        .dinb(value1_stg3),
        .doutb(ram_value1));
        

    always @(posedge clk) begin
        ctl0_stg4 <= ctl0_stg3;
        ctl1_stg4 <= ctl1_stg3;
        ctl_com_stg4 <= ctl_com_stg3;
        value0_stg4 <= value0_stg3;
        row0_stg4 <= row0_stg3;
        value1_stg4 <= value1_stg3;
        row1_stg4 <= row1_stg3;
    end

    wire overflow_fifo_rd;
    reg overflow_fifo_rd1;
    wire overflow_fifo_empty, overflow_fifo_full;
    wire [9:0] overflow_fifo_row;
    wire [63:0] overflow_fifo_value0;
    wire [63:0] overflow_fifo_value1;

    assign overflow_fifo_rd = (ctl0_stg3[1:0] != 2'H1) && !ctl_com_stg3 && !overflow_fifo_empty;
    always @(posedge clk) begin
        overflow_fifo_rd1 <= overflow_fifo_rd;
    end

    fifo_138x16_shift overflow_fifo(
        .clk(clk),
        .srst(reset),
        .din({row1_stg4, value1_stg4, ram_value1}),
        .wr_en((ctl1_stg4[1:0] == 2'H1)),
        .rd_en(overflow_fifo_rd),
        .dout({overflow_fifo_row, overflow_fifo_value0, overflow_fifo_value1}),
        .full(overflow_fifo_full),
        .empty(overflow_fifo_empty));

    always @(posedge clk) begin
        r_add <= 0;
        r_add0 <= 0;
        r_add1 <= 0;
        r_add_row <= 0;
        if(ctl_com_stg4) begin
            r_add <= 1;
            r_add0 <= value0_stg4;
            r_add1 <= value1_stg4;
            r_add_row <= row0_stg4;
        end else if(ctl0_stg4[1:0] == 2'H1) begin
            r_add <= 1;
            r_add0 <= value0_stg4;
            r_add1 <= ram_value0;
            r_add_row <= row0_stg4;
        end else if(overflow_fifo_rd1) begin
            r_add <= 1;
            r_add0 <= overflow_fifo_value0;
            r_add1 <= overflow_fifo_value1;
            r_add_row <= overflow_fifo_row;
        end
    end
    assign add = r_add;
    assign add0 = r_add0;
    assign add1 = r_add1;
    assign add_row = r_add_row;

    always @(posedge clk) begin
        r_store <= 0;
        r_store_value <= 0;
        if(reset)
            r_store <= 0;
        if(ctl0_stg4[2]) begin
            r_store <= 1;
            r_store_value <= ram_value0;
        end else if(ctl1_stg4[2]) begin
            r_store <= 1;
            r_store_value <= ram_value1;
        end
    end
    assign store = r_store;
    assign store_value = r_store_value;

endmodule
