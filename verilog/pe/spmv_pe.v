module spmv_pe(clk, op_in, op_out, busy_in, busy_out, reg_mem_ld, req_mem_st,
    req_mem_addr, req_mem_d_tag, req_mem_stall, rsp_mem_push, rsp_mem_tag,
    rsp_mem_q, rsp_mem_stall, req_scratch_ld, req_scratch_st,
    req_scratch_d, req_scratch_stall, rsp_scratch_push, rsp_scratch_q,
    rsp_scratch_stall);
    parameter ID = 0;
    localparam OPCODE_ARG_PE = 7;
    localparam OPCODE_ARG_1 = 12;
    localparam OPCODE_ARG_2 = 16;
    input clk;
    input [63:0] op_in;
    output [63:0] op_out;
    input busy_in;
    output busy_out;
    output req_mem_ld;
    output req_mem_st;
    output [47:0] req_mem_addr;
    output [63:0] req_mem_d_tag;
    input req_mem_stall;
    input rsp_mem_push;
    input [32:0] rsp_mem_tag;
    input [63:0] rsp_mem_q;
    output rsp_mem_stall;

    output req_scratch_ld;
    output req_scratch_st;
    output [63:0] req_scratch_d;
    input req_scratch_stall;
    input rsp_scratch_push;
    input [63:0] rsp_scratch_q;
    output rsp_scratch_stall;

    reg rst, next_rst;
    reg state, next_state;
    localparam IDLE = 0;
    localparam STEADY = 1;

    localparam REGISTER_START = 0;
    localparam REGISTER_END = 2;
    reg [47:0] registers [REGISTER_START:REGISTER_END - 1];
    reg [47:0] next_registers [REGISTER_START:REGISTER_END - 1];
    wire registers_equal = (registers[0] == registers[1]);
    integer i;
    always @(posedge clk) begin
        rst <= next_rst;
        state <= next_state;
        for(i = REGISTER_START; i < REGISTER_END; i = i + 1)
            registers[i] = next_registers[i];
    end
    reg [63:0] op;
    reg busy;
    reg busy_status;
    always @(posedge clk) begin
        op <= op_in;
        busy <= busy_in | busy_status;
    end
    assign op_out = op;
    assign busy_out = busy;

    always @* begin
        next_rst = 0;
        next_state = state;
        busy_status = decoder_busy;
        for(i = REGISTER_START; i < REGISTER_END; i = i + 1)
            next_registers[i] = registers[i];
        if(op[OPCODE_ARG_1 - 1] || (op[OPCODE_ARG_1 - 2: OPCODE_ARG_PE] == ID))
            case(OPCODE_ARG_PE - 1 : 0)
                OP_RST: begin
                    next_rst = 1;
                    next_state = IDLE;
                end
                OP_STEADY: begin
                    next_state = STEADY;
                end
                OP_LD: begin
                    for(i = REGISTER_START; i < REGISTER_END; i = i + 1)
                        if(i == op[OPCODE_ARG_2 - 1:OPCODE_ARG_2])
                            next_register[i] = op[63:OPCODE_ARG_2];
                end
            endcase
            case(state)
                STEADY: begin
                    busy_status = 1;
                    if(registers_equal)
                        next_state = IDLE;
                end
            endcase
    end

    sparse_matrix_decoder decoder(clk, op, decoder_busy, decoder_req_mem_ld,
        decoder_req_mem_addr, decoder_req_mem_tag, decoder_mem_req_fifo_full,
        rsp_mem_push && (rsp_mem_tag[0] == 0), rsp_mem_tag[2:1], rsp_mem_q,
        decoder_rsp_mem_stall, req_scratch_ld, req_scratch_st, req_scratch_addr,
        req_scratch_d, req_scratch_stall, req_scratch_push, rsp_scratch_q,
        rsp_scratch_stall, decoder_index_push, decoder_row, decoder_col,
        decoder_val_push, decoder_val, x_cache_stall_val, x_cache_stall_index);

    //TODO: x_vector_cache
    //TODO: mac
    //TODO: memory request management


endmodule;
