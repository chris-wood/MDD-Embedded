//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2009 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 12.1
//  \   \        Application: Partial Reconfiguration
//  /   /        Filename: top.v
// /___/   /\    Date Last Modified: 01 January 2010
// \   \  /  \
//  \___\/\___\
// Device: Virtex-6
// Design Name: xpr_bram_led
// Purpose: Partial Reconfiguration Tutorial
///////////////////////////////////////////////////////////////////////////////
//
//    Project : BRAM_LED
// Description: This design outputs LED patterns based on two reconfigurable
//              modules.  The recon_block_bram module ouput depends on the
//              BRAM contents within the reconfig module.  The recon_block_counter
//              module output depends on the counter within the reconfig
//              module.  Partial bit files can be created and downloaded that
//              change the contents of the BRAM and the behavior of the counter.
//              The counter reconfig module containes I/O that are embedded
//              within the reconfig module.
//
//////////////////////////////////////////////////////////////////////////////

// black box definition for reconfigurable module recon_block_bram

module recon_block_bram(
   input         clk,
   input         en,
   input  [11:0] addr,
   output  [7:0] data_out)
   /*synthesis syn_black_box*/;
endmodule


// black box definition for reconfigurable module recon_block_counter

module recon_block_count(
   input        clk,
   input        rst_n,
   output [3:0] out_counter)
   /*synthesis syn_black_box black_box_pad_pin="out_counter"*/;
endmodule

//////////////////////////////////////////////////////////////////////////////
//  Top-level, static design
//////////////////////////////////////////////////////////////////////////////

module top(
    input        clk_p,       // 200MHz differential input clock
    input        clk_n,       // 200MHz differential input clock
    input        rst_n,       // Reset mapped to center push button
    output       test_count,  // LED to see clock, counter and reset activity
    output [3:0] out_counter, // mapped to push button LEDs
    output [7:0] out_bram);   // mapped to general purpose LEDs

    // turn off IOBUF insertion for embedded IO with XST syntax
    // synthesis attribute buffer_type out_counter none;

    reg [34:0]  count;
    reg         test_count_r;
    wire        gclk;

   // instantiate clock module to divide 200MHz to 100MHz
   clocks U0_clocks (
      .clk_p(clk_p),
      .clk_n(clk_n),
      .clk_out(gclk));

    // instantiate reconfigurable module BRAM
    recon_block_bram U1_RP_Bram (
      .en       (rst_n),
      .clk      (gclk),
      .addr     (count[34:23]),
      .data_out (out_bram));

    // instantiate reconfigurable module counter
    recon_block_count U2_RP_Count (
      .rst_n    (rst_n),
      .clk      (gclk),
      .out_counter (out_counter));

// MAIN
   assign test_count = test_count_r;

   always @(posedge gclk)
     if (rst_n)
       begin
         count <= 0;
         test_count_r <= 0;
       end
     else
       begin
         count <= count + 1;
         test_count_r <= count[24];
       end

endmodule
