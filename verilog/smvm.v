`timescale 1 ns / 1 ps
module smvm(
    input clk,
    input reset,
    input idle,
    input start,
    output stall,
    output [63:0] ret_val,
    output mc_req_ld,
    output mc_req_st,
    output [47:0] mc_req_vadr,
    output [63:0] mc_req_wrd_rdctl,
    input mc_rd_rq_stall,
    input mc_wr_rq_stall,
    input [31:0] mc_rsp_rdctl,
    input [63:0] mc_rsp_data,
    input mc_rsp_push,
    output mc_rsp_stall,
    input [47:0] x,
    input [47:0] a,
    input [47:0] y,
    input [63:0] nnz,
    input [63:0] a_mem_size,
    input [63:0] result_size,
    input [47:0] mcv);

    reg [2:0] state, next_state;
    `define IDLE 0
    `define LD_RAM 1
    `define LD_A 2
    `define LD_X 3
    `define STORE_RES 4
    reg [47:0] r_x, next_r_x;
    reg [47:0] r_a_ptr, next_r_a_ptr;
    reg [47:0] r_y_ptr, next_r_y_ptr;
    reg [63:0] r_nnz_left, next_r_nnz_left;
    reg [63:0] r_a_bytes_left, next_r_a_bytes_left;
    reg [63:0] r_result_left, next_r_result_left;
    reg [47:0] r_mcv_ptr, next_r_mcv_ptr;
    
    reg r_mc_req_ld, r_mc_req_st, next_r_mc_req_ld, next_r_mc_req_st;
    reg [47:0] r_mc_req_vadr, next_r_mc_req_vadr;
    reg [63:0] r_mc_req_wrd_rdctl, next_r_mc_req_wrd_rdctl;
    
    wire [31:0] decode_row;
    wire [31:0] decode_column;
    wire [63:0] decode_value;
    wire decode_push;
    wire column_fifo_empty;
    wire column_fifo_full;
    wire column_fifo_hf;
    wire [4:0] column_fifo_count;
    wire [31:0] column_fifo_dout;
    wire matrix_fifo_empty;
    wire matrix_fifo_full;
    wire matrix_fifo_hf;
    wire [31:0] matrix_fifo_row;
    wire [63:0] matrix_fifo_value;
    
    reg a_near_empty;
    reg r_mac_wr, next_r_mac_wr;
    reg [63:0] r_mac_vector_in;
    reg next_r_column_fifo_rd;
    reg r_column_fifo_rd;
    wire mac_push;
    wire [63:0] mac_result;
    reg result_fifo_rd, next_result_fifo_rd;
    wire [63:0] result_fifo_dout;
    wire result_fifo_full, result_fifo_empty;

    reg idle_reset;
    reg [7:0] counter, next_counter;

    reg next_decode_push_in, decode_push_in;
    wire packet_fifo_empty, decode_stall;
    wire [63:0] packet_fifo_dout;
    wire packet_fifo_hf;
    wire packet_fifo_full;

    wire [4:0] vector_fifo_count;
    wire [63:0] vector_fifo_dout;
    wire vector_fifo_empty, vector_fifo_full;
    wire vector_fifo_hf;
    reg rd_vector_fifo, next_rd_vector_fifo;
    reg [4:0] mac_counter;

    always @(posedge clk)
        idle_reset <= idle || reset;

    assign ret_val = 0;

    //TODO: use stall
    assign mc_rsp_stall = 0;
    always @(posedge clk)
        r_column_fifo_rd <= next_r_column_fifo_rd;
    assign stall = (state != `IDLE);

    always @(posedge clk)
        a_near_empty <= ~|r_a_bytes_left[63:4];

    reg [2:0] to_idle_count;
    always @(posedge clk) begin
        if(r_result_left == 0)
            to_idle_count = to_idle_count + 1;
        else
            to_idle_count = 0;
    end

    always @* begin
        next_state = state;
        next_r_mc_req_ld = 0;
        next_r_mc_req_st = 0;
        next_r_mc_req_vadr = 0;
        next_r_mc_req_wrd_rdctl = 0;
        next_r_x = r_x;
        next_r_a_ptr = r_a_ptr;
        next_r_y_ptr = r_y_ptr;
        next_r_nnz_left = r_nnz_left;
        next_r_a_bytes_left = r_a_bytes_left;
        next_r_result_left = r_result_left;
        next_result_fifo_rd = 0;
        next_r_column_fifo_rd <= 0;
        next_r_mcv_ptr = r_mcv_ptr;
        next_counter = counter;
        case(state)
            `IDLE: begin
                next_r_a_bytes_left = 0;
                next_counter = 0;
                if(start) begin
                    next_state = `LD_RAM;
                    next_r_x = x;
                    next_r_a_ptr = a;
                    next_r_nnz_left = nnz;
                    next_r_a_bytes_left = a_mem_size;
                    next_r_result_left = result_size;
                    next_r_y_ptr = y;
                    next_r_mcv_ptr = mcv;
                end
                //TODO: make efficient
                if(next_r_result_left == 0)
                    next_state = `IDLE;
            end
            `LD_RAM: begin
                if(!mc_rd_rq_stall) begin
                    next_r_mc_req_ld = 1;
                    next_r_mc_req_vadr = r_mcv_ptr;
                    next_r_mc_req_wrd_rdctl = 2;
                    next_r_mcv_ptr = r_mcv_ptr + 8;
                    next_counter = counter + 1;
                end
                if(counter == 8'HFF)
                    next_state = `LD_A;
                else
                    next_state = `LD_RAM;
            end
            `LD_A: begin
                if((r_result_left == 0) && to_idle_count[2])
                    next_state = `IDLE;
                else if(!mc_wr_rq_stall && !result_fifo_empty && (r_result_left != 0)) begin
                    next_result_fifo_rd = 1;
                    next_state = `STORE_RES;
                end else if(!mc_rd_rq_stall & !column_fifo_empty && !vector_fifo_hf) begin
                    next_r_column_fifo_rd <= 1;
                    next_state = `LD_X;
                end
                if(!mc_rd_rq_stall && !(a_near_empty && !r_a_bytes_left[3:0]) && !packet_fifo_hf)begin //fix for non 8 divisible numbers 
                    next_r_mc_req_ld = 1;
                    next_r_mc_req_vadr = r_a_ptr;
                    next_r_a_ptr = r_a_ptr + 8;
                    next_r_a_bytes_left = r_a_bytes_left - 8;
                    next_r_mc_req_wrd_rdctl = 0;
                end
            end
            `LD_X: begin
                next_r_mc_req_ld = 1;
                next_r_mc_req_vadr = r_x + {column_fifo_dout, 3'H0};
                next_r_mc_req_wrd_rdctl = {57'H0,column_fifo_count,2'H1};
                if(!mc_rd_rq_stall & !column_fifo_empty && !vector_fifo_hf) begin
                    next_r_column_fifo_rd <= 1;
                    next_state = `LD_X;
                end else
                    next_state = `LD_A;
            end
            `STORE_RES: begin
                next_r_mc_req_st = 1;
                next_r_mc_req_vadr = r_y_ptr;
                next_r_y_ptr = r_y_ptr + 8;
                next_r_mc_req_wrd_rdctl = result_fifo_dout;
                next_r_result_left = r_result_left - 1;
                if(r_result_left[63:2] == 0) begin
                    next_state = `LD_A;
                end else if(!mc_wr_rq_stall && !result_fifo_empty) begin
                    next_result_fifo_rd = 1;
                    next_state = `STORE_RES;
                end else 
                    next_state = `LD_A;
            end
        endcase
        if(r_mac_wr)begin
            next_r_nnz_left = r_nnz_left - 1;
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            state <= `IDLE;
        end else begin
            state <= next_state;
        end
        r_x <= next_r_x;
        r_a_ptr <= next_r_a_ptr;
        r_nnz_left <= next_r_nnz_left;
        r_a_bytes_left <= next_r_a_bytes_left;
        r_result_left <= next_r_result_left;
        r_mc_req_ld <= next_r_mc_req_ld;
        r_mc_req_st <= next_r_mc_req_st;
        r_mc_req_vadr <= next_r_mc_req_vadr;
        r_mc_req_wrd_rdctl <= next_r_mc_req_wrd_rdctl;
        result_fifo_rd <= next_result_fifo_rd;
        r_y_ptr <= next_r_y_ptr;
        r_mcv_ptr <= next_r_mcv_ptr;
        counter <= next_counter;
        if(start) begin
            $display("start values:%x, %x, %x, %x, %x, %x, %x", a, x, y, nnz, a_mem_size, result_size, mcv);
        end
    end

    assign mc_req_ld = r_mc_req_ld;
    assign mc_req_st = r_mc_req_st;
    assign mc_req_vadr = r_mc_req_vadr;
    assign mc_req_wrd_rdctl = r_mc_req_wrd_rdctl;


    always @*
        next_decode_push_in = !packet_fifo_empty && !decode_stall && !matrix_fifo_hf && !column_fifo_hf;
    always @(posedge clk) begin
        decode_push_in <= next_decode_push_in;
    end
    reg [63:0] decode_data_in;
    always @*
        if(next_decode_push_in)
            decode_data_in <= packet_fifo_dout;
        else
            decode_data_in <= mc_rsp_data;
    //TODO: add half full flag
    fifo_fwft_64x1024 packet_fifo(
        .clk(clk),
        .rst(idle_reset),
        .din(mc_rsp_data),
        .wr_en(mc_rsp_push && (mc_rsp_rdctl[1:0] == 0)),
        .rd_en(next_decode_push_in),
        .dout(packet_fifo_dout),
        .full(packet_fifo_full),
        .empty(packet_fifo_empty),
        .prog_full(packet_fifo_hf));

    spoonPacketDecoder decode(
        .reset(idle_reset),
        .clk(clk),
        .data(decode_data_in),
        .push_in(next_decode_push_in),
        .ramIn(mc_rsp_push && (mc_rsp_rdctl[1:0] == 2)),
        .value(decode_value),
        .row(decode_row),
        .column(decode_column),
        .push_out(decode_push),
        .stall(decode_stall));

    wire cc_push;
    wire [31:0] cc_column;
    wire [4:0] cc_count;
    column_counter cc(
        .clk(clk),
        .reset(idle_reset),
        .push_in(decode_push),
        .push_out(cc_push),
        .in_col_index(decode_column),
        .out_col_index(cc_column),
        .out_count(cc_count));

    assign column_fifo_count[4] = 0;

    fifo_36x512_hf column_fifo(
        .clk(clk),
        .rst(idle_reset),
        .din({cc_count[3:0], cc_column}),
        .wr_en(cc_push),
        .rd_en(next_r_column_fifo_rd),
        .dout({column_fifo_count[3:0], column_fifo_dout}),
        .full(column_fifo_full),
        .empty(column_fifo_empty),
        .prog_full(column_fifo_hf));

    fifo_fwft_96x512_hf matrix_fifo(
        .clk(clk),
        .rst(idle_reset),
        .din({decode_row, decode_value}),
        .wr_en(decode_push),
        .rd_en(r_mac_wr),
        .dout({matrix_fifo_row, matrix_fifo_value}),
        .full(matrix_fifo_full),
        .empty(matrix_fifo_empty),
        .prog_full(matrix_fifo_hf));

    fifo_69x512_hf vector_fifo(
        .clk(clk),
        .rst(idle_reset),
        .din({mc_rsp_rdctl[6:2],mc_rsp_data}),
        .wr_en(mc_rsp_push & mc_rsp_rdctl[0]),
        .rd_en(next_rd_vector_fifo),
        .dout({vector_fifo_count, vector_fifo_dout}),
        .full(vector_fifo_full),
        .empty(vector_fifo_empty),
        .prog_full(vector_fifo_hf));

    wire result_fifo_hf;

    always @* begin
        next_rd_vector_fifo = (!vector_fifo_empty) && (mac_counter == 0) && (!rd_vector_fifo) && (!result_fifo_hf);
    end
    always @(posedge clk)
        rd_vector_fifo <= next_rd_vector_fifo;

    always @(posedge clk) begin
        if(reset) begin
            mac_counter <= 0;
            r_mac_wr <= 0;
        end else if(rd_vector_fifo) begin
            if(mac_counter > 0)
                $display("error over write");
            mac_counter <= vector_fifo_count;
            r_mac_vector_in <= vector_fifo_dout;
            r_mac_wr <= 1;
        end else if(mac_counter > 0) begin
            r_mac_wr <= 1;
            mac_counter <= mac_counter - 1;
        end else begin
            r_mac_wr <= 0;
        end
    end

    //TODO: fix with fifo
    mac the_mac(
        .clk(clk),
        .reset(idle_reset),
        .row(matrix_fifo_row[9:0]),
        .value0(matrix_fifo_value),
        .value1(r_mac_vector_in),
        .wr(r_mac_wr),
        .push(mac_push),
        .dout(mac_result),
        .done(r_nnz_left == 0));

    
    fifo_64x512_hf result_fifo(
        .clk(clk),
        .rst(idle_reset),
        .din(mac_result),
        .wr_en(mac_push),
        .rd_en(next_result_fifo_rd),
        .dout(result_fifo_dout),
        .full(result_fifo_full),
        .empty(result_fifo_empty),
        .prog_full(result_fifo_hf));

    //check for overflow fifo
    always @(posedge clk) begin
        if(vector_fifo_full)
            $display("error:vector_fifo overflow");
        if(result_fifo_full)
            $display("error:result_fifo overflow");
        if(matrix_fifo_full)
            $display("error:matrix_fifo overflow");
        if(column_fifo_full)
            $display("error:column_fifo overflow");
        if(packet_fifo_full)
            $display("error:packet_fifo overflow");
        if(packet_fifo_hf)
            $display("note:packet_fifo half full");
    end
endmodule
