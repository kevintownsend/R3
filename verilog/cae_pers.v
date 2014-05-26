/*****************************************************************************/
//
// Module      : cae_pers.v
// Revision    : $Revision: 1.4.1.4 $
// Last Modified On: $Date: 2012/03/07 15:41:55 $
// Last Modified By: $Author: ktown $
//
//-----------------------------------------------------------------------------
//
// Original Author : gedwards
// Created On      : Wed Oct 10 09:26:08 2007
// TODO: add author information
//-----------------------------------------------------------------------------
//
// Description     : SMVM personality
//
//                   Top-level of SMVM personality.  For a complete list of 
//                   optional ports, see 
//                   /opt/convey/pdk/<rev>/<platform>/doc/cae_pers.v
//
//-----------------------------------------------------------------------------
//
// Copyright (c) 2007-2011 : created by Convey Computer Corp. This model is the
// confidential and proprietary property of Convey Computer Corp.
//
/*****************************************************************************/
/* $Id: cae_pers.v,v 1.4.1.4 2012/03/07 15:41:55 ktown Exp ktown $ */

`timescale 1 ns / 1 ps

`include "pdk_fpga_defines.vh"

(* keep_hierarchy = "true" *)
module cae_pers (
   input        clk_csr,
   input        clk,
   input        clk2x,
   input        i_reset,
   input        i_csr_reset_n,
   input  [1:0]     i_aeid,

   input        ppll_reset,
   output       ppll_locked,
   output       clk_per,

   //
   // Dispatch Interface
   //
   input  [31:0]    cae_inst,
   input  [63:0]    cae_data,
   input        cae_inst_vld,

   output [17:0]    cae_aeg_cnt,
   output [15:0]    cae_exception,
   output [63:0]    cae_ret_data,
   output       cae_ret_data_vld,
   output       cae_idle,
   output       cae_stall,

   //
   // MC Interface(s)
   //
   output       mc0_req_ld_e, mc0_req_ld_o,
   output       mc0_req_st_e, mc0_req_st_o,
   output [1:0]     mc0_req_size_e, mc0_req_size_o,
   output [47:0]    mc0_req_vadr_e, mc0_req_vadr_o,
   output [63:0]    mc0_req_wrd_rdctl_e, mc0_req_wrd_rdctl_o,
   output       mc0_rsp_stall_e, mc0_rsp_stall_o,
   input        mc0_rd_rq_stall_e, mc0_rd_rq_stall_o,
   input        mc0_wr_rq_stall_e, mc0_wr_rq_stall_o,
   input  [63:0]    mc0_rsp_data_e, mc0_rsp_data_o,
   input        mc0_rsp_push_e, mc0_rsp_push_o,
   input  [31:0]    mc0_rsp_rdctl_e, mc0_rsp_rdctl_o,
   output       mc1_req_ld_e, mc1_req_ld_o,
   output       mc1_req_st_e, mc1_req_st_o,
   output [1:0]     mc1_req_size_e, mc1_req_size_o,
   output [47:0]    mc1_req_vadr_e, mc1_req_vadr_o,
   output [63:0]    mc1_req_wrd_rdctl_e, mc1_req_wrd_rdctl_o,
   output       mc1_rsp_stall_e, mc1_rsp_stall_o,
   input        mc1_rd_rq_stall_e, mc1_rd_rq_stall_o,
   input        mc1_wr_rq_stall_e, mc1_wr_rq_stall_o,
   input  [63:0]    mc1_rsp_data_e, mc1_rsp_data_o,
   input        mc1_rsp_push_e, mc1_rsp_push_o,
   input  [31:0]    mc1_rsp_rdctl_e, mc1_rsp_rdctl_o,
   output       mc2_req_ld_e, mc2_req_ld_o,
   output       mc2_req_st_e, mc2_req_st_o,
   output [1:0]     mc2_req_size_e, mc2_req_size_o,
   output [47:0]    mc2_req_vadr_e, mc2_req_vadr_o,
   output [63:0]    mc2_req_wrd_rdctl_e, mc2_req_wrd_rdctl_o,
   output       mc2_rsp_stall_e, mc2_rsp_stall_o,
   input        mc2_rd_rq_stall_e, mc2_rd_rq_stall_o,
   input        mc2_wr_rq_stall_e, mc2_wr_rq_stall_o,
   input  [63:0]    mc2_rsp_data_e, mc2_rsp_data_o,
   input        mc2_rsp_push_e, mc2_rsp_push_o,
   input  [31:0]    mc2_rsp_rdctl_e, mc2_rsp_rdctl_o,
   output       mc3_req_ld_e, mc3_req_ld_o,
   output       mc3_req_st_e, mc3_req_st_o,
   output [1:0]     mc3_req_size_e, mc3_req_size_o,
   output [47:0]    mc3_req_vadr_e, mc3_req_vadr_o,
   output [63:0]    mc3_req_wrd_rdctl_e, mc3_req_wrd_rdctl_o,
   output       mc3_rsp_stall_e, mc3_rsp_stall_o,
   input        mc3_rd_rq_stall_e, mc3_rd_rq_stall_o,
   input        mc3_wr_rq_stall_e, mc3_wr_rq_stall_o,
   input  [63:0]    mc3_rsp_data_e, mc3_rsp_data_o,
   input        mc3_rsp_push_e, mc3_rsp_push_o,
   input  [31:0]    mc3_rsp_rdctl_e, mc3_rsp_rdctl_o,
   output       mc4_req_ld_e, mc4_req_ld_o,
   output       mc4_req_st_e, mc4_req_st_o,
   output [1:0]     mc4_req_size_e, mc4_req_size_o,
   output [47:0]    mc4_req_vadr_e, mc4_req_vadr_o,
   output [63:0]    mc4_req_wrd_rdctl_e, mc4_req_wrd_rdctl_o,
   output       mc4_rsp_stall_e, mc4_rsp_stall_o,
   input        mc4_rd_rq_stall_e, mc4_rd_rq_stall_o,
   input        mc4_wr_rq_stall_e, mc4_wr_rq_stall_o,
   input  [63:0]    mc4_rsp_data_e, mc4_rsp_data_o,
   input        mc4_rsp_push_e, mc4_rsp_push_o,
   input  [31:0]    mc4_rsp_rdctl_e, mc4_rsp_rdctl_o,
   output       mc5_req_ld_e, mc5_req_ld_o,
   output       mc5_req_st_e, mc5_req_st_o,
   output [1:0]     mc5_req_size_e, mc5_req_size_o,
   output [47:0]    mc5_req_vadr_e, mc5_req_vadr_o,
   output [63:0]    mc5_req_wrd_rdctl_e, mc5_req_wrd_rdctl_o,
   output       mc5_rsp_stall_e, mc5_rsp_stall_o,
   input        mc5_rd_rq_stall_e, mc5_rd_rq_stall_o,
   input        mc5_wr_rq_stall_e, mc5_wr_rq_stall_o,
   input  [63:0]    mc5_rsp_data_e, mc5_rsp_data_o,
   input        mc5_rsp_push_e, mc5_rsp_push_o,
   input  [31:0]    mc5_rsp_rdctl_e, mc5_rsp_rdctl_o,
   output       mc6_req_ld_e, mc6_req_ld_o,
   output       mc6_req_st_e, mc6_req_st_o,
   output [1:0]     mc6_req_size_e, mc6_req_size_o,
   output [47:0]    mc6_req_vadr_e, mc6_req_vadr_o,
   output [63:0]    mc6_req_wrd_rdctl_e, mc6_req_wrd_rdctl_o,
   output       mc6_rsp_stall_e, mc6_rsp_stall_o,
   input        mc6_rd_rq_stall_e, mc6_rd_rq_stall_o,
   input        mc6_wr_rq_stall_e, mc6_wr_rq_stall_o,
   input  [63:0]    mc6_rsp_data_e, mc6_rsp_data_o,
   input        mc6_rsp_push_e, mc6_rsp_push_o,
   input  [31:0]    mc6_rsp_rdctl_e, mc6_rsp_rdctl_o,
   output       mc7_req_ld_e, mc7_req_ld_o,
   output       mc7_req_st_e, mc7_req_st_o,
   output [1:0]     mc7_req_size_e, mc7_req_size_o,
   output [47:0]    mc7_req_vadr_e, mc7_req_vadr_o,
   output [63:0]    mc7_req_wrd_rdctl_e, mc7_req_wrd_rdctl_o,
   output       mc7_rsp_stall_e, mc7_rsp_stall_o,
   input        mc7_rd_rq_stall_e, mc7_rd_rq_stall_o,
   input        mc7_wr_rq_stall_e, mc7_wr_rq_stall_o,
   input  [63:0]    mc7_rsp_data_e, mc7_rsp_data_o,
   input        mc7_rsp_push_e, mc7_rsp_push_o,
   input  [31:0]    mc7_rsp_rdctl_e, mc7_rsp_rdctl_o,

   //
   // Write flush
   //
   output       mc0_req_flush_e, mc0_req_flush_o,
   input        mc0_rsp_flush_cmplt_e, mc0_rsp_flush_cmplt_o,
   output       mc1_req_flush_e, mc1_req_flush_o,
   input        mc1_rsp_flush_cmplt_e, mc1_rsp_flush_cmplt_o,
   output       mc2_req_flush_e, mc2_req_flush_o,
   input        mc2_rsp_flush_cmplt_e, mc2_rsp_flush_cmplt_o,
   output       mc3_req_flush_e, mc3_req_flush_o,
   input        mc3_rsp_flush_cmplt_e, mc3_rsp_flush_cmplt_o,
   output       mc4_req_flush_e, mc4_req_flush_o,
   input        mc4_rsp_flush_cmplt_e, mc4_rsp_flush_cmplt_o,
   output       mc5_req_flush_e, mc5_req_flush_o,
   input        mc5_rsp_flush_cmplt_e, mc5_rsp_flush_cmplt_o,
   output       mc6_req_flush_e, mc6_req_flush_o,
   input        mc6_rsp_flush_cmplt_e, mc6_rsp_flush_cmplt_o,
   output       mc7_req_flush_e, mc7_req_flush_o,
   input        mc7_rsp_flush_cmplt_e, mc7_rsp_flush_cmplt_o,

   //
   // AE-to-AE Interface not used
   //

   //
   // Management/Debug Interface
   //
   input  [3:0]     cae_ring_ctl_in,
   input  [15:0]    cae_ring_data_in,
   output [3:0]     cae_ring_ctl_out,
   output [15:0]    cae_ring_data_out,

   input        csr_31_31_intlv_dis
);

initial $display("starting cae personality aeid:%d\n", i_aeid);

`include "pdk_fpga_param.vh"

   //
   // Local clock generation
   //
   (* KEEP = "true" *) wire reset_per;
   cae_clock clock (
      .clk(clk),
      .i_reset(i_reset),
      .ppll_reset(ppll_reset),

      .clk_per(clk_per),
      .ppll_locked(ppll_locked),
      .reset_per(reset_per)
   );


     //
     // Instruction decode
     //
     wire [4:0]   inst_caep;
     wire [17:0]  inst_aeg_idx;
     instdec dec (
        .cae_inst(cae_inst),
        .cae_data(cae_data),
        .cae_inst_vld(cae_inst_vld),

        .inst_val(inst_val),
        .inst_caep(inst_caep),
        .inst_aeg_wr(inst_aeg_wr),
        .inst_aeg_rd(inst_aeg_rd),
        .inst_aeg_idx(inst_aeg_idx),
        .err_unimpl(err_unimpl)
    );


   //**************************************************************************
   //              PERSONALITY SPECIFIC LOGIC
   //**************************************************************************

   //
   // AEG[0..NA-1] Registers
   //
    localparam NA = 128;
    localparam NB = 7;       // Number of bits to represent NAEG

    assign cae_aeg_cnt = NA;

    //output of aeg registers
    wire [63:0]  w_aeg[NA-1:0];

    genvar g;
    generate for (g=0; g<NA; g=g+1) begin : g0
      reg [63:0] c_aeg, r_aeg;

      always @* begin
        case (g)
//TODO: add cases for registers to be written to
            default: c_aeg = r_aeg;
        endcase
      end

      wire c_aeg_we = inst_aeg_wr && inst_aeg_idx[NB-1:0] == g;

      always @(posedge clk) begin
        if (c_aeg_we) begin
            r_aeg <= cae_data;
            $display("@verilog:writing: %x", cae_data);
        end
        else
            r_aeg <= c_aeg;
        end
      assign w_aeg[g] = r_aeg;
    end endgenerate

   reg      r_ret_val, r_err_unimpl, r_err_aegidx;
   reg [63:0]   r_ret_data;

   wire c_val_aegidx = inst_aeg_idx < NA;

    //return logic
   always @(posedge clk) begin
      r_ret_val    <= inst_aeg_rd && c_val_aegidx;
      r_ret_data   <= w_aeg[inst_aeg_idx[NB-1:0]];
      r_err_aegidx <= (inst_aeg_wr || inst_aeg_rd) && !c_val_aegidx;
//TODO: add logic to decide which instructions are implemented
      r_err_unimpl <= err_unimpl || (inst_val && (inst_caep !== 'd0/* && inst_caep !== 'd1 && inst_caep !== 'd2*/)); 
   end
   assign cae_ret_data_vld = r_ret_val;
   assign cae_ret_data     = r_ret_data;

   assign cae_exception[1:0] = {r_err_aegidx, r_err_unimpl};

   // ISE can have issues with global wires attached to D(flop)/I(lut) inputs
   wire r_reset;
   FDSE rst (.C(clk_per),.S(reset_per),.CE(r_reset),.D(!r_reset),.Q(r_reset));

   //logic for using cae IMPORTANT. cae_idle should be 0 when executing a custom instruction and 1 otherwise.
   //cae_stall should be 1 when when exectuting a custom instruction and 0 otherwise.
   //assign cae_idle  = 1'b1;
   //assign cae_stall = 1'b0;


   //
   // default state
   //
assign cae_ring_ctl_out = cae_ring_ctl_in;
assign cae_ring_data_out = cae_ring_data_in;

    assign mc0_req_size_e = 2'd3;
    assign mc0_req_flush_e = 1'b0;
    assign mc0_req_size_o = 2'd3;
    assign mc0_req_flush_o = 1'b0;
    assign mc1_req_size_e = 2'd3;
    assign mc1_req_flush_e = 1'b0;
    assign mc1_req_size_o = 2'd3;
    assign mc1_req_flush_o = 1'b0;
    assign mc2_req_size_e = 2'd3;
    assign mc2_req_flush_e = 1'b0;
    assign mc2_req_size_o = 2'd3;
    assign mc2_req_flush_o = 1'b0;
    assign mc3_req_size_e = 2'd3;
    assign mc3_req_flush_e = 1'b0;
    assign mc3_req_size_o = 2'd3;
    assign mc3_req_flush_o = 1'b0;
    assign mc4_req_size_e = 2'd3;
    assign mc4_req_flush_e = 1'b0;
    assign mc4_req_size_o = 2'd3;
    assign mc4_req_flush_o = 1'b0;
    assign mc5_req_size_e = 2'd3;
    assign mc5_req_flush_e = 1'b0;
    assign mc5_req_size_o = 2'd3;
    assign mc5_req_flush_o = 1'b0;
    assign mc6_req_size_e = 2'd3;
    assign mc6_req_flush_e = 1'b0;
    assign mc6_req_size_o = 2'd3;
    assign mc6_req_flush_o = 1'b0;
    assign mc7_req_size_e = 2'd3;
    assign mc7_req_flush_e = 1'b0;
    assign mc7_req_size_o = 2'd3;
    assign mc7_req_flush_o = 1'b0;
    
    reg r_caep00;
    reg [31:0] watch_dog_timer;
    reg watch_dog_reset;
    wire [15:0] pe_stall;
    wire c_caep00;
    assign c_caep00 = (inst_caep == 5'd0 && inst_val);


    always @(posedge clk) begin
        r_caep00 <= c_caep00;
        if(reset_per)
            watch_dog_timer <= 0;
        else if(cae_stall)
            watch_dog_timer <= watch_dog_timer + 1;
        else
            watch_dog_timer <= 0;
        watch_dog_reset <= watch_dog_timer[31] || reset_per;
    end
    //TODO: expand pe_stall
    assign cae_idle = (~|pe_stall) && !r_caep00;
    assign cae_stall = (|pe_stall) || c_caep00 || r_caep00;

    smvm pe0 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[0]),
        .ret_val(),
        .mc_req_ld(mc0_req_ld_e),
        .mc_req_st(mc0_req_st_e),
        .mc_req_vadr(mc0_req_vadr_e),
        .mc_req_wrd_rdctl(mc0_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc0_rd_rq_stall_e),
        .mc_wr_rq_stall(mc0_wr_rq_stall_e),
        .mc_rsp_rdctl(mc0_rsp_rdctl_e),
        .mc_rsp_data(mc0_rsp_data_e),
        .mc_rsp_push(mc0_rsp_push_e),
        .mc_rsp_stall(mc0_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[6][47:0]),
        .y(w_aeg[7][47:0]),
        .nnz(w_aeg[8]),
        .a_mem_size(w_aeg[9]),
        .result_size(w_aeg[10]),
        .mcv(w_aeg[11])
    );

    smvm pe1 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[1]),
        .ret_val(),
        .mc_req_ld(mc0_req_ld_o),
        .mc_req_st(mc0_req_st_o),
        .mc_req_vadr(mc0_req_vadr_o),
        .mc_req_wrd_rdctl(mc0_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc0_rd_rq_stall_o),
        .mc_wr_rq_stall(mc0_wr_rq_stall_o),
        .mc_rsp_rdctl(mc0_rsp_rdctl_o),
        .mc_rsp_data(mc0_rsp_data_o),
        .mc_rsp_push(mc0_rsp_push_o),
        .mc_rsp_stall(mc0_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[12][47:0]),
        .y(w_aeg[13][47:0]),
        .nnz(w_aeg[14]),
        .a_mem_size(w_aeg[15]),
        .result_size(w_aeg[16]),
        .mcv(w_aeg[17])
    );

    smvm pe2 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[2]),
        .ret_val(),
        .mc_req_ld(mc1_req_ld_e),
        .mc_req_st(mc1_req_st_e),
        .mc_req_vadr(mc1_req_vadr_e),
        .mc_req_wrd_rdctl(mc1_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc1_rd_rq_stall_e),
        .mc_wr_rq_stall(mc1_wr_rq_stall_e),
        .mc_rsp_rdctl(mc1_rsp_rdctl_e),
        .mc_rsp_data(mc1_rsp_data_e),
        .mc_rsp_push(mc1_rsp_push_e),
        .mc_rsp_stall(mc1_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[18][47:0]),
        .y(w_aeg[19][47:0]),
        .nnz(w_aeg[20]),
        .a_mem_size(w_aeg[21]),
        .result_size(w_aeg[22]),
        .mcv(w_aeg[23])
    );

    smvm pe3 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[3]),
        .ret_val(),
        .mc_req_ld(mc1_req_ld_o),
        .mc_req_st(mc1_req_st_o),
        .mc_req_vadr(mc1_req_vadr_o),
        .mc_req_wrd_rdctl(mc1_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc1_rd_rq_stall_o),
        .mc_wr_rq_stall(mc1_wr_rq_stall_o),
        .mc_rsp_rdctl(mc1_rsp_rdctl_o),
        .mc_rsp_data(mc1_rsp_data_o),
        .mc_rsp_push(mc1_rsp_push_o),
        .mc_rsp_stall(mc1_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[24][47:0]),
        .y(w_aeg[25][47:0]),
        .nnz(w_aeg[26]),
        .a_mem_size(w_aeg[27]),
        .result_size(w_aeg[28]),
        .mcv(w_aeg[29])
    );

    smvm pe4 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[4]),
        .ret_val(),
        .mc_req_ld(mc2_req_ld_e),
        .mc_req_st(mc2_req_st_e),
        .mc_req_vadr(mc2_req_vadr_e),
        .mc_req_wrd_rdctl(mc2_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc2_rd_rq_stall_e),
        .mc_wr_rq_stall(mc2_wr_rq_stall_e),
        .mc_rsp_rdctl(mc2_rsp_rdctl_e),
        .mc_rsp_data(mc2_rsp_data_e),
        .mc_rsp_push(mc2_rsp_push_e),
        .mc_rsp_stall(mc2_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[30][47:0]),
        .y(w_aeg[31][47:0]),
        .nnz(w_aeg[32]),
        .a_mem_size(w_aeg[33]),
        .result_size(w_aeg[34]),
        .mcv(w_aeg[35])
    );

    smvm pe5 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[5]),
        .ret_val(),
        .mc_req_ld(mc2_req_ld_o),
        .mc_req_st(mc2_req_st_o),
        .mc_req_vadr(mc2_req_vadr_o),
        .mc_req_wrd_rdctl(mc2_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc2_rd_rq_stall_o),
        .mc_wr_rq_stall(mc2_wr_rq_stall_o),
        .mc_rsp_rdctl(mc2_rsp_rdctl_o),
        .mc_rsp_data(mc2_rsp_data_o),
        .mc_rsp_push(mc2_rsp_push_o),
        .mc_rsp_stall(mc2_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[36][47:0]),
        .y(w_aeg[37][47:0]),
        .nnz(w_aeg[38]),
        .a_mem_size(w_aeg[39]),
        .result_size(w_aeg[40]),
        .mcv(w_aeg[41])
    );

    smvm pe6 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[6]),
        .ret_val(),
        .mc_req_ld(mc3_req_ld_e),
        .mc_req_st(mc3_req_st_e),
        .mc_req_vadr(mc3_req_vadr_e),
        .mc_req_wrd_rdctl(mc3_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc3_rd_rq_stall_e),
        .mc_wr_rq_stall(mc3_wr_rq_stall_e),
        .mc_rsp_rdctl(mc3_rsp_rdctl_e),
        .mc_rsp_data(mc3_rsp_data_e),
        .mc_rsp_push(mc3_rsp_push_e),
        .mc_rsp_stall(mc3_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[42][47:0]),
        .y(w_aeg[43][47:0]),
        .nnz(w_aeg[44]),
        .a_mem_size(w_aeg[45]),
        .result_size(w_aeg[46]),
        .mcv(w_aeg[47])
    );

    smvm pe7 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[7]),
        .ret_val(),
        .mc_req_ld(mc3_req_ld_o),
        .mc_req_st(mc3_req_st_o),
        .mc_req_vadr(mc3_req_vadr_o),
        .mc_req_wrd_rdctl(mc3_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc3_rd_rq_stall_o),
        .mc_wr_rq_stall(mc3_wr_rq_stall_o),
        .mc_rsp_rdctl(mc3_rsp_rdctl_o),
        .mc_rsp_data(mc3_rsp_data_o),
        .mc_rsp_push(mc3_rsp_push_o),
        .mc_rsp_stall(mc3_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[48][47:0]),
        .y(w_aeg[49][47:0]),
        .nnz(w_aeg[50]),
        .a_mem_size(w_aeg[51]),
        .result_size(w_aeg[52]),
        .mcv(w_aeg[53])
    );

    smvm pe8 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[8]),
        .ret_val(),
        .mc_req_ld(mc4_req_ld_e),
        .mc_req_st(mc4_req_st_e),
        .mc_req_vadr(mc4_req_vadr_e),
        .mc_req_wrd_rdctl(mc4_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc4_rd_rq_stall_e),
        .mc_wr_rq_stall(mc4_wr_rq_stall_e),
        .mc_rsp_rdctl(mc4_rsp_rdctl_e),
        .mc_rsp_data(mc4_rsp_data_e),
        .mc_rsp_push(mc4_rsp_push_e),
        .mc_rsp_stall(mc4_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[54][47:0]),
        .y(w_aeg[55][47:0]),
        .nnz(w_aeg[56]),
        .a_mem_size(w_aeg[57]),
        .result_size(w_aeg[58]),
        .mcv(w_aeg[59])
    );

    smvm pe9 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[9]),
        .ret_val(),
        .mc_req_ld(mc4_req_ld_o),
        .mc_req_st(mc4_req_st_o),
        .mc_req_vadr(mc4_req_vadr_o),
        .mc_req_wrd_rdctl(mc4_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc4_rd_rq_stall_o),
        .mc_wr_rq_stall(mc4_wr_rq_stall_o),
        .mc_rsp_rdctl(mc4_rsp_rdctl_o),
        .mc_rsp_data(mc4_rsp_data_o),
        .mc_rsp_push(mc4_rsp_push_o),
        .mc_rsp_stall(mc4_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[60][47:0]),
        .y(w_aeg[61][47:0]),
        .nnz(w_aeg[62]),
        .a_mem_size(w_aeg[63]),
        .result_size(w_aeg[64]),
        .mcv(w_aeg[65])
    );

    smvm pe10 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[10]),
        .ret_val(),
        .mc_req_ld(mc5_req_ld_e),
        .mc_req_st(mc5_req_st_e),
        .mc_req_vadr(mc5_req_vadr_e),
        .mc_req_wrd_rdctl(mc5_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc5_rd_rq_stall_e),
        .mc_wr_rq_stall(mc5_wr_rq_stall_e),
        .mc_rsp_rdctl(mc5_rsp_rdctl_e),
        .mc_rsp_data(mc5_rsp_data_e),
        .mc_rsp_push(mc5_rsp_push_e),
        .mc_rsp_stall(mc5_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[66][47:0]),
        .y(w_aeg[67][47:0]),
        .nnz(w_aeg[68]),
        .a_mem_size(w_aeg[69]),
        .result_size(w_aeg[70]),
        .mcv(w_aeg[71])
    );

    smvm pe11 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[11]),
        .ret_val(),
        .mc_req_ld(mc5_req_ld_o),
        .mc_req_st(mc5_req_st_o),
        .mc_req_vadr(mc5_req_vadr_o),
        .mc_req_wrd_rdctl(mc5_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc5_rd_rq_stall_o),
        .mc_wr_rq_stall(mc5_wr_rq_stall_o),
        .mc_rsp_rdctl(mc5_rsp_rdctl_o),
        .mc_rsp_data(mc5_rsp_data_o),
        .mc_rsp_push(mc5_rsp_push_o),
        .mc_rsp_stall(mc5_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[72][47:0]),
        .y(w_aeg[73][47:0]),
        .nnz(w_aeg[74]),
        .a_mem_size(w_aeg[75]),
        .result_size(w_aeg[76]),
        .mcv(w_aeg[77])
    );

    smvm pe12 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[12]),
        .ret_val(),
        .mc_req_ld(mc6_req_ld_e),
        .mc_req_st(mc6_req_st_e),
        .mc_req_vadr(mc6_req_vadr_e),
        .mc_req_wrd_rdctl(mc6_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc6_rd_rq_stall_e),
        .mc_wr_rq_stall(mc6_wr_rq_stall_e),
        .mc_rsp_rdctl(mc6_rsp_rdctl_e),
        .mc_rsp_data(mc6_rsp_data_e),
        .mc_rsp_push(mc6_rsp_push_e),
        .mc_rsp_stall(mc6_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[78][47:0]),
        .y(w_aeg[79][47:0]),
        .nnz(w_aeg[80]),
        .a_mem_size(w_aeg[81]),
        .result_size(w_aeg[82]),
        .mcv(w_aeg[83])
    );

    smvm pe13 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[13]),
        .ret_val(),
        .mc_req_ld(mc6_req_ld_o),
        .mc_req_st(mc6_req_st_o),
        .mc_req_vadr(mc6_req_vadr_o),
        .mc_req_wrd_rdctl(mc6_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc6_rd_rq_stall_o),
        .mc_wr_rq_stall(mc6_wr_rq_stall_o),
        .mc_rsp_rdctl(mc6_rsp_rdctl_o),
        .mc_rsp_data(mc6_rsp_data_o),
        .mc_rsp_push(mc6_rsp_push_o),
        .mc_rsp_stall(mc6_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[84][47:0]),
        .y(w_aeg[85][47:0]),
        .nnz(w_aeg[86]),
        .a_mem_size(w_aeg[87]),
        .result_size(w_aeg[88]),
        .mcv(w_aeg[89])
    );

    smvm pe14 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[14]),
        .ret_val(),
        .mc_req_ld(mc7_req_ld_e),
        .mc_req_st(mc7_req_st_e),
        .mc_req_vadr(mc7_req_vadr_e),
        .mc_req_wrd_rdctl(mc7_req_wrd_rdctl_e),
        .mc_rd_rq_stall(mc7_rd_rq_stall_e),
        .mc_wr_rq_stall(mc7_wr_rq_stall_e),
        .mc_rsp_rdctl(mc7_rsp_rdctl_e),
        .mc_rsp_data(mc7_rsp_data_e),
        .mc_rsp_push(mc7_rsp_push_e),
        .mc_rsp_stall(mc7_rsp_stall_e),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[90][47:0]),
        .y(w_aeg[91][47:0]),
        .nnz(w_aeg[92]),
        .a_mem_size(w_aeg[93]),
        .result_size(w_aeg[94]),
        .mcv(w_aeg[95])
    );

    smvm pe15 (
        .clk(clk_per),
        .reset(watch_dog_reset),
        .idle(cae_idle),
        .start(r_caep00),
        .stall(pe_stall[15]),
        .ret_val(),
        .mc_req_ld(mc7_req_ld_o),
        .mc_req_st(mc7_req_st_o),
        .mc_req_vadr(mc7_req_vadr_o),
        .mc_req_wrd_rdctl(mc7_req_wrd_rdctl_o),
        .mc_rd_rq_stall(mc7_rd_rq_stall_o),
        .mc_wr_rq_stall(mc7_wr_rq_stall_o),
        .mc_rsp_rdctl(mc7_rsp_rdctl_o),
        .mc_rsp_data(mc7_rsp_data_o),
        .mc_rsp_push(mc7_rsp_push_o),
        .mc_rsp_stall(mc7_rsp_stall_o),
        .x(w_aeg[1][47:0]),
        .a(w_aeg[96][47:0]),
        .y(w_aeg[97][47:0]),
        .nnz(w_aeg[98]),
        .a_mem_size(w_aeg[99]),
        .result_size(w_aeg[100]),
        .mcv(w_aeg[101])
    );
   
    /* ---------- debug & synopsys off blocks  ---------- */

    // synopsys translate_off

    // Parameters: 1-Severity: Don't Stop, 2-start check only after negedge of reset
    //assert_never #(1, 2, "***ERROR ASSERT: unimplemented instruction cracked") a0 (.clk(clk), .reset_n(~reset), .test_expr(r_unimplemented_inst));

    // synopsys translate_on

endmodule // cae_pers

