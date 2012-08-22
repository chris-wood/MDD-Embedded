//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2009 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 11.3
//  \   \        Application: Partial Reconfiguration
//  /   /        Filename: CountCW.v
// /___/   /\    Date Last Modified: 04 September 2009
// \   \  /  \
//  \___\/\___\
// Device: Virtex-5
// Design Name: xpr_bram_led
// Purpose: Partial Reconfiguration Tutorial
///////////////////////////////////////////////////////////////////////////////
// Reconfigurable Module: recon_block_count
// rotate the button LEDs Clock Wise
// led_out[3:0] are embedded in this module, i.e. OBUF instantiated

module recon_block_count (
	rst_n,
	clk,
	out_counter);

   input rst_n;                // Active high reset
   input clk;                  // 200MHz input clock
   output [3:0] out_counter;       // Output to LEDs

   reg [24:0] count;
   reg [3:0]  data_out;

   reg [3:0] nxt_data_out;

   OBUF OBUF_inst_led_out_3 (out_counter[3], data_out[3]);  //(output, input)
   OBUF OBUF_inst_led_out_2 (out_counter[2], data_out[2]);  //(output, input)
   OBUF OBUF_inst_led_out_1 (out_counter[1], data_out[1]);  //(output, input)
   OBUF OBUF_inst_led_out_0 (out_counter[0], data_out[0]);  //(output, input)

   always @(posedge clk)
      if (rst_n) begin
         count <= 0;
      end
      else begin
         count <= count + 1;
      end


   always @(data_out)
      case (data_out)
         4'b0001: nxt_data_out <= 4'b0010;
         4'b0010: nxt_data_out <= 4'b0100;
         4'b0100: nxt_data_out <= 4'b1000;
         4'b1000: nxt_data_out <= 4'b0001;
         4'b0011: nxt_data_out <= 4'b0001;
         4'b0101: nxt_data_out <= 4'b0001;
         4'b0110: nxt_data_out <= 4'b0001;
         4'b0111: nxt_data_out <= 4'b0001;
         4'b1001: nxt_data_out <= 4'b0001;
         4'b1010: nxt_data_out <= 4'b0001;
         4'b1011: nxt_data_out <= 4'b0001;
         4'b1100: nxt_data_out <= 4'b0001;
         4'b1101: nxt_data_out <= 4'b0001;
         4'b1110: nxt_data_out <= 4'b0001;
         4'b1111: nxt_data_out <= 4'b0001;
         4'b0000: nxt_data_out <= 4'b0001;
      endcase

    always @(posedge clk)
      if (rst_n)
         data_out <= 4'b0001;
      else begin
         if (count == 25'b1111111111111111111111111) begin
            data_out <= nxt_data_out;
         end
      end

endmodule
