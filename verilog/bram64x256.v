module bram64x256(
    input clk,
    input wr,
    input [7:0] adr,
    input [63:0] din,
    output [63:0] dout);
    
    reg [63:0] ram [255:0];
    reg [63:0] rDout;

    assign dout = rDout;

    always @(posedge clk) begin
        if(wr)
            ram[adr] <= din;
        rDout <= ram[adr];
    end
    
endmodule
