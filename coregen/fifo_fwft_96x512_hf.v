////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: O.87xd
//  \   \         Application: netgen
//  /   /         Filename: fifo_fwft_96x512_hf.v
// /___/   /\     Timestamp: Wed Jan  2 13:20:30 2013
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog /home/ktown/R3/coregen/tmp/_cg/fifo_fwft_96x512_hf.ngc /home/ktown/R3/coregen/tmp/_cg/fifo_fwft_96x512_hf.v 
// Device	: 5vlx330ff1760-1
// Input file	: /home/ktown/R3/coregen/tmp/_cg/fifo_fwft_96x512_hf.ngc
// Output file	: /home/ktown/R3/coregen/tmp/_cg/fifo_fwft_96x512_hf.v
// # of Modules	: 1
// Design Name	: fifo_fwft_96x512_hf
// Xilinx        : /remote/Xilinx/13.4/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module fifo_fwft_96x512_hf (
  clk, rd_en, rst, empty, wr_en, full, prog_empty, prog_full, dout, din
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input rd_en;
  input rst;
  output empty;
  input wr_en;
  output full;
  output prog_empty;
  output prog_full;
  output [95 : 0] dout;
  input [95 : 0] din;
  
  // synthesis translate_off
  
  wire N0;
  wire N1;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/Mshreg_power_on_wr_rst_0_3 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_reg_10 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_14 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot_16 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_q_18 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_q_20 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_23 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot_25 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_q_27 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_q_29 ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo ;
  wire \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/wr_ack_i ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_SBITERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DBITERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<63>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<62>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<61>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<60>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<59>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<58>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<57>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<56>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<55>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<54>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<53>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<52>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<51>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<50>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<49>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<48>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<47>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<46>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<45>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<44>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<43>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<42>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<41>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<40>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<39>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<38>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<37>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<36>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<35>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<34>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<33>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<32>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<31>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<30>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<29>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<28>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<27>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<26>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<25>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<24>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<12>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<11>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<10>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<9>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<8>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<12>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<11>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<10>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<9>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<8>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_SBITERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DBITERR_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<12>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<11>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<10>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<9>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<8>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<12>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<11>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<10>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<9>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<8>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<7>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<6>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<5>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<4>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<3>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<2>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<1>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<0>_UNCONNECTED ;
  wire \NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/Mshreg_power_on_wr_rst_0_Q15_UNCONNECTED ;
  wire [0 : 0] \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i ;
  wire [0 : 0] \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/power_on_wr_rst ;
  wire [4 : 0] \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb ;
  wire [2 : 1] \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful ;
  GND   XST_GND (
    .G(N0)
  );
  VCC   XST_VCC (
    .P(N1)
  );
  FDPE #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_reg  (
    .C(clk),
    .CE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [0]),
    .D(N0),
    .PRE(rst),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_reg_10 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb_4  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_reg_10 ),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb_3  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [4]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb_2  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [3]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb_1  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [2]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb_0  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [1]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_fb [0])
  );
  FDP #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .PRE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_23 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_q  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_fifo ),
    .PRE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_q_27 )
  );
  FDC #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_q  (
    .C(clk),
    .CLR(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_fifo ),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_q_29 )
  );
  FIFO36_72_EXP #(
    .ALMOST_FULL_OFFSET ( 9'h022 ),
    .SIM_MODE ( "SAFE" ),
    .DO_REG ( 0 ),
    .EN_ECC_READ ( "FALSE" ),
    .EN_ECC_WRITE ( "FALSE" ),
    .EN_SYN ( "TRUE" ),
    .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
    .ALMOST_EMPTY_OFFSET ( 9'h0FF ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72  (
    .RDEN(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo ),
    .WREN(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/wr_ack_i ),
    .RST(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .RDCLKU(clk),
    .RDCLKL(clk),
    .WRCLKU(clk),
    .WRCLKL(clk),
    .RDRCLKU(clk),
    .RDRCLKL(clk),
    .ALMOSTEMPTY(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_fifo ),
    .ALMOSTFULL(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_fifo ),
    .EMPTY(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .FULL(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful [2]),
    .RDERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDERR_UNCONNECTED ),
    .WRERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRERR_UNCONNECTED ),
    .SBITERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_SBITERR_UNCONNECTED ),
    .DBITERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DBITERR_UNCONNECTED ),
    .DI({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
N0, N0, N0, N0, N0, din[95], din[94], din[93], din[92], din[91], din[90], din[89], din[88], din[87], din[86], din[85], din[84], din[83], din[82], 
din[81], din[80], din[79], din[78], din[77], din[76], din[75], din[74], din[73], din[72]}),
    .DIP({N0, N0, N0, N0, N0, N0, N0, N0}),
    .DO({\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<63>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<62>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<61>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<60>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<59>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<58>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<57>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<56>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<55>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<54>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<53>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<52>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<51>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<50>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<49>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<48>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<47>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<46>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<45>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<44>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<43>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<42>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<41>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<40>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<39>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<38>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<37>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<36>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<35>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<34>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<33>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<32>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<31>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<30>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<29>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<28>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<27>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<26>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<25>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DO<24>_UNCONNECTED , dout[95], 
dout[94], dout[93], dout[92], dout[91], dout[90], dout[89], dout[88], dout[87], dout[86], dout[85], dout[84], dout[83], dout[82], dout[81], dout[80], 
dout[79], dout[78], dout[77], dout[76], dout[75], dout[74], dout[73], dout[72]}),
    .DOP({\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DOP<0>_UNCONNECTED }),
    .RDCOUNT({
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<12>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<11>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<10>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<9>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<8>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<0>_UNCONNECTED }),
    .WRCOUNT({
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<12>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<11>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<10>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<9>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<8>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<0>_UNCONNECTED }),
    .ECCPARITY({
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<0>_UNCONNECTED })
  );
  FDP #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .PRE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_14 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_q  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_fifo ),
    .PRE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_q_18 )
  );
  FDC #(
    .INIT ( 1'b0 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_q  (
    .C(clk),
    .CLR(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_fifo ),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_q_20 )
  );
  FIFO36_72_EXP #(
    .ALMOST_FULL_OFFSET ( 9'h022 ),
    .SIM_MODE ( "SAFE" ),
    .DO_REG ( 0 ),
    .EN_ECC_READ ( "FALSE" ),
    .EN_ECC_WRITE ( "FALSE" ),
    .EN_SYN ( "TRUE" ),
    .FIRST_WORD_FALL_THROUGH ( "FALSE" ),
    .ALMOST_EMPTY_OFFSET ( 9'h0FF ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72  (
    .RDEN(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo ),
    .WREN(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/wr_ack_i ),
    .RST(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .RDCLKU(clk),
    .RDCLKL(clk),
    .WRCLKU(clk),
    .WRCLKL(clk),
    .RDRCLKU(clk),
    .RDRCLKL(clk),
    .ALMOSTEMPTY(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_fifo ),
    .ALMOSTFULL(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_fifo ),
    .EMPTY(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .FULL(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful [1]),
    .RDERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDERR_UNCONNECTED ),
    .WRERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRERR_UNCONNECTED ),
    .SBITERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_SBITERR_UNCONNECTED ),
    .DBITERR(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_DBITERR_UNCONNECTED ),
    .DI({din[63], din[62], din[61], din[60], din[59], din[58], din[57], din[56], din[55], din[54], din[53], din[52], din[51], din[50], din[49], 
din[48], din[47], din[46], din[45], din[44], din[43], din[42], din[41], din[40], din[39], din[38], din[37], din[36], din[35], din[34], din[33], 
din[32], din[31], din[30], din[29], din[28], din[27], din[26], din[25], din[24], din[23], din[22], din[21], din[20], din[19], din[18], din[17], 
din[16], din[15], din[14], din[13], din[12], din[11], din[10], din[9], din[8], din[7], din[6], din[5], din[4], din[3], din[2], din[1], din[0]}),
    .DIP({din[71], din[70], din[69], din[68], din[67], din[66], din[65], din[64]}),
    .DO({dout[63], dout[62], dout[61], dout[60], dout[59], dout[58], dout[57], dout[56], dout[55], dout[54], dout[53], dout[52], dout[51], dout[50], 
dout[49], dout[48], dout[47], dout[46], dout[45], dout[44], dout[43], dout[42], dout[41], dout[40], dout[39], dout[38], dout[37], dout[36], dout[35], 
dout[34], dout[33], dout[32], dout[31], dout[30], dout[29], dout[28], dout[27], dout[26], dout[25], dout[24], dout[23], dout[22], dout[21], dout[20], 
dout[19], dout[18], dout[17], dout[16], dout[15], dout[14], dout[13], dout[12], dout[11], dout[10], dout[9], dout[8], dout[7], dout[6], dout[5], 
dout[4], dout[3], dout[2], dout[1], dout[0]}),
    .DOP({dout[71], dout[70], dout[69], dout[68], dout[67], dout[66], dout[65], dout[64]}),
    .RDCOUNT({
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<12>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<11>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<10>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<9>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<8>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_RDCOUNT<0>_UNCONNECTED }),
    .WRCOUNT({
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<12>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<11>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<10>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<9>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<8>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_WRCOUNT<0>_UNCONNECTED }),
    .ECCPARITY({
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<7>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<6>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<5>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<4>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<3>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<2>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<1>_UNCONNECTED , 
\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/gf72.sngfifo36_72_ECCPARITY<0>_UNCONNECTED })
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/full_i1  (
    .I0(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful [2]),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful [1]),
    .O(full)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/PROG_FULL1  (
    .I0(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_full_q_29 ),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_full_q_20 ),
    .O(prog_full)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/PROG_EMPTY1  (
    .I0(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/prog_empty_q_27 ),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/prog_empty_q_18 ),
    .O(prog_empty)
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/RD_RST_I<1>1  (
    .I0(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/wr_rst_reg_10 ),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/power_on_wr_rst [0]),
    .O(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/empty_i1  (
    .I0(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 ),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 ),
    .O(empty)
  );
  LUT5 #(
    .INIT ( 32'h303000AA ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo1  (
    .I0(rd_en),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_23 ),
    .I3(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 ),
    .I4(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 ),
    .O(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/rden_fifo )
  );
  LUT5 #(
    .INIT ( 32'h303000AA ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo1  (
    .I0(rd_en),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_14 ),
    .I3(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 ),
    .I4(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 ),
    .O(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/rden_fifo )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot_25 ),
    .PRE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 )
  );
  FDP #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user  (
    .C(clk),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot_16 ),
    .PRE(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rd_rst_i [0]),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 )
  );
  LUT5 #(
    .INIT ( 32'hCFCF0088 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot  (
    .I0(rd_en),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_q_23 ),
    .I3(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 ),
    .I4(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 ),
    .O(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_rstpot_25 )
  );
  LUT5 #(
    .INIT ( 32'hCFCF0088 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot  (
    .I0(rd_en),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_fifo ),
    .I2(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_q_14 ),
    .I3(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[2].inst_extd/gonep.inst_prim/empty_user_24 ),
    .I4(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_15 ),
    .O(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/gextw[1].inst_extd/gonep.inst_prim/empty_user_rstpot_16 )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/wr_ack_i1  (
    .I0(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful [2]),
    .I1(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/ful [1]),
    .I2(wr_en),
    .O(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/v5_fifo.fblk/wr_ack_i )
  );
  SRLC16E #(
    .INIT ( 16'h001F ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/Mshreg_power_on_wr_rst_0  (
    .A0(N0),
    .A1(N0),
    .A2(N1),
    .A3(N0),
    .CE(N1),
    .CLK(clk),
    .D(N0),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/Mshreg_power_on_wr_rst_0_3 ),
    .Q15(\NLW_U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/Mshreg_power_on_wr_rst_0_Q15_UNCONNECTED )
  );
  FDE #(
    .INIT ( 1'b1 ))
  \U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/power_on_wr_rst_0  (
    .C(clk),
    .CE(N1),
    .D(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/Mshreg_power_on_wr_rst_0_3 ),
    .Q(\U0/xst_fifo_generator/gconvfifo.rf/gbiv5.bi/rstbt/power_on_wr_rst [0])
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
