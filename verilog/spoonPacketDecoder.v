`timescale 1 ns / 1 ps
module spoonPacketDecoder(
    input reset,
    input clk,
    input [63:0] data,
    input push_in,
    input ramIn,
    output [63:0] value,
    output [31:0] column,
    output [31:0] row,
    output push_out,
    output stall);

    reg [255:0] buffer;
    reg [5:0] count, next_count;
    reg [5:0] packetSize;
    reg [63:0] r_value;
    reg [31:0] r_column, r_row;
    reg r_push_out;
    reg [4:0] local_row;
    reg [2:0] delta_size;
    reg [63:0] delta;
    integer i, j;
    reg [7:0] ramAdr;
    wire [63:0] ramDOut;
    reg [7:0] ramCount;
    reg fetchRam;
    reg [63:0] valuePrime;
    reg r_push_in;
    reg [63:0] r_data;
    reg r_ram_in;

    always @(posedge clk) begin
        r_push_in <= push_in;
        r_data <= data;
        r_ram_in <= ramIn;
    end
    
    bram64x256 bram(
        .clk(clk),
        .wr(r_ram_in),
        .adr(ramAdr),
        .din(r_data),
        .dout(ramDOut));
        
    always @* begin
        if(r_ram_in)
            ramAdr = ramCount;
        else
            ramAdr = buffer[15:8];
        if(fetchRam)
            valuePrime = ramDOut;
        else
            valuePrime = r_value;
    end

    always @(posedge clk)
        fetchRam <= (buffer[2:0] < 5);

    assign stall = count[4];

    reg shift_buffer;
    //1,2,3,5,8,10,12,16
    always @(posedge clk) begin
        if(count[4]) begin
            case(buffer[2:0])
                0:begin 
                    buffer <= (buffer >> (1 * 8));
                    next_count = count - 1;
                end
                1:begin 
                    buffer <= (buffer >> (2 * 8));
                    next_count = count - 2;
                end
                2:begin 
                    buffer <= (buffer >> (3 * 8));
                    next_count = count - 3;
                end
                3:begin
                    buffer <= (buffer >> (5 * 8));
                    next_count = count - 5;
                end
                4:begin
                    buffer <= (buffer >> (7 * 8));
                    next_count = count - 7;
                end
                5:begin
                    buffer <= (buffer >> (9 * 8));
                    next_count = count - 9;
                end
                6:begin
                    buffer <= (buffer >> (11 * 8));
                    next_count = count - 11;
                end
                7:begin
                    buffer <= (buffer >> (14 * 8));
                    next_count = count - 14;
                end
            endcase
        end else
            next_count = count;
        if(r_push_in) begin
            for(i = 0; i < 64; i = i + 1)
                buffer[{next_count, 3'H0} + i] <= r_data[i];
            count <= next_count + 8;
        end else
            count <= next_count;
        if(reset == 1)
            count <= 0;
    end

    always @(posedge clk) begin
        if(reset == 1)begin
            r_push_out <= 0;
            r_value <= 0;
            r_column <= 0;
            r_row <= 0;
            
    //1,2,3,5,7,9,11,14
        end else begin
            //TODO:redo with new method
            delta = 0;
            delta[4:0] = buffer[7:3];
            case(buffer[2:0])
                0:begin
                end
                1:begin
                end
                2:begin
                    delta[12:5] = buffer[23:16];
                end
                3:begin
                    delta[28:5] = buffer[39:16];
                end
                4:begin
                    delta[44:5] = buffer[55:16];
                end
                5:begin
                end
                6:begin
                    delta[20:5] = buffer[87:72];
                end
                7:begin
                    delta[36:5] = buffer[103:72];
                end
            endcase
            //TODO:the rest

            r_value <= buffer[71:8];
            
            if((buffer[2:0] > 0) && (count[4] == 1)) begin
                r_push_out <= 1;
                local_row = {1'H0,r_row[3:0]} + {1'H0, delta[3:0]};
                r_row[3:0] <= local_row[3:0];
                r_column <= r_column + delta[35:4] + local_row[4];
            end else if((buffer[2:0] == 0) && (count[4] == 1)) begin
                r_column <= 0;
                r_row[3:0] <= 0;
                r_row[31:4] <= r_row[31:4] + 1;
                r_push_out <= 0;
            end else
                r_push_out <= 0;
            
        end

    end

    always @(posedge clk) begin
        if(reset) begin
            ramCount <= 0;
        end else begin
            if(r_ram_in)
                ramCount <= ramCount + 1;
        end
    end
    
    assign push_out = r_push_out;
    assign column = r_column;
    assign row = r_row;
    assign value = valuePrime;

endmodule
