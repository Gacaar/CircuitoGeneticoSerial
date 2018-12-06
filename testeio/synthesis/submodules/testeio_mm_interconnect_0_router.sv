// (C) 2001-2016 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/16.1/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2016/08/07 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module testeio_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 47,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 49 
   )
  (output [97 - 92 : 0] default_destination_id,
   output [53-1 : 0] default_wr_channel,
   output [53-1 : 0] default_rd_channel,
   output [53-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[97 - 92 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 53'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 53'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 53'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module testeio_mm_interconnect_0_router
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [122-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [122-1    : 0] src_data,
    output reg [53-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 56;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 97;
    localparam PKT_DEST_ID_L = 92;
    localparam PKT_PROTECTION_H = 112;
    localparam PKT_PROTECTION_L = 110;
    localparam ST_DATA_W = 122;
    localparam ST_CHANNEL_W = 53;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 59;
    localparam PKT_TRANS_READ  = 60;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h20000 - 64'h0); 
    localparam PAD1 = log2ceil(64'h40000 - 64'h20000); 
    localparam PAD2 = log2ceil(64'h40010 - 64'h40000); 
    localparam PAD3 = log2ceil(64'h40020 - 64'h40010); 
    localparam PAD4 = log2ceil(64'h40060 - 64'h40050); 
    localparam PAD5 = log2ceil(64'h40070 - 64'h40060); 
    localparam PAD6 = log2ceil(64'h40080 - 64'h40070); 
    localparam PAD7 = log2ceil(64'h40090 - 64'h40080); 
    localparam PAD8 = log2ceil(64'h400a0 - 64'h40090); 
    localparam PAD9 = log2ceil(64'h400b0 - 64'h400a0); 
    localparam PAD10 = log2ceil(64'h400c0 - 64'h400b0); 
    localparam PAD11 = log2ceil(64'h400d0 - 64'h400c0); 
    localparam PAD12 = log2ceil(64'h400e0 - 64'h400d0); 
    localparam PAD13 = log2ceil(64'h400f0 - 64'h400e0); 
    localparam PAD14 = log2ceil(64'h40100 - 64'h400f0); 
    localparam PAD15 = log2ceil(64'h40110 - 64'h40100); 
    localparam PAD16 = log2ceil(64'h40120 - 64'h40110); 
    localparam PAD17 = log2ceil(64'h40130 - 64'h40120); 
    localparam PAD18 = log2ceil(64'h40140 - 64'h40130); 
    localparam PAD19 = log2ceil(64'h40150 - 64'h40140); 
    localparam PAD20 = log2ceil(64'h40160 - 64'h40150); 
    localparam PAD21 = log2ceil(64'h40170 - 64'h40160); 
    localparam PAD22 = log2ceil(64'h40180 - 64'h40170); 
    localparam PAD23 = log2ceil(64'h40190 - 64'h40180); 
    localparam PAD24 = log2ceil(64'h401a0 - 64'h40190); 
    localparam PAD25 = log2ceil(64'h401b0 - 64'h401a0); 
    localparam PAD26 = log2ceil(64'h401c0 - 64'h401b0); 
    localparam PAD27 = log2ceil(64'h401d0 - 64'h401c0); 
    localparam PAD28 = log2ceil(64'h401e0 - 64'h401d0); 
    localparam PAD29 = log2ceil(64'h401f0 - 64'h401e0); 
    localparam PAD30 = log2ceil(64'h40200 - 64'h401f0); 
    localparam PAD31 = log2ceil(64'h40210 - 64'h40200); 
    localparam PAD32 = log2ceil(64'h40220 - 64'h40210); 
    localparam PAD33 = log2ceil(64'h40230 - 64'h40220); 
    localparam PAD34 = log2ceil(64'h40240 - 64'h40230); 
    localparam PAD35 = log2ceil(64'h40250 - 64'h40240); 
    localparam PAD36 = log2ceil(64'h40260 - 64'h40250); 
    localparam PAD37 = log2ceil(64'h40270 - 64'h40260); 
    localparam PAD38 = log2ceil(64'h40280 - 64'h40270); 
    localparam PAD39 = log2ceil(64'h40290 - 64'h40280); 
    localparam PAD40 = log2ceil(64'h402a0 - 64'h40290); 
    localparam PAD41 = log2ceil(64'h402b0 - 64'h402a0); 
    localparam PAD42 = log2ceil(64'h402c0 - 64'h402b0); 
    localparam PAD43 = log2ceil(64'h402d0 - 64'h402c0); 
    localparam PAD44 = log2ceil(64'h402e0 - 64'h402d0); 
    localparam PAD45 = log2ceil(64'h402f0 - 64'h402e0); 
    localparam PAD46 = log2ceil(64'h40300 - 64'h402f0); 
    localparam PAD47 = log2ceil(64'h40310 - 64'h40300); 
    localparam PAD48 = log2ceil(64'h40320 - 64'h40310); 
    localparam PAD49 = log2ceil(64'h40330 - 64'h40320); 
    localparam PAD50 = log2ceil(64'h40340 - 64'h40330); 
    localparam PAD51 = log2ceil(64'h40350 - 64'h40340); 
    localparam PAD52 = log2ceil(64'h40360 - 64'h40350); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h40360;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [53-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    testeio_mm_interconnect_0_router_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x0 .. 0x20000 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 19'h0   ) begin
            src_channel = 53'b00000100000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 49;
    end

    // ( 0x20000 .. 0x40000 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 19'h20000   ) begin
            src_channel = 53'b00000010000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 50;
    end

    // ( 0x40000 .. 0x40010 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 19'h40000   ) begin
            src_channel = 53'b10000000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 44;
    end

    // ( 0x40010 .. 0x40020 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 19'h40010  && read_transaction  ) begin
            src_channel = 53'b01000000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 43;
    end

    // ( 0x40050 .. 0x40060 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 19'h40050   ) begin
            src_channel = 53'b00100000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 46;
    end

    // ( 0x40060 .. 0x40070 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 19'h40060   ) begin
            src_channel = 53'b00010000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 52;
    end

    // ( 0x40070 .. 0x40080 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 19'h40070   ) begin
            src_channel = 53'b00001000000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 41;
    end

    // ( 0x40080 .. 0x40090 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 19'h40080   ) begin
            src_channel = 53'b00000001000000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 47;
    end

    // ( 0x40090 .. 0x400a0 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 19'h40090   ) begin
            src_channel = 53'b00000000100000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 51;
    end

    // ( 0x400a0 .. 0x400b0 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 19'h400a0   ) begin
            src_channel = 53'b00000000010000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 42;
    end

    // ( 0x400b0 .. 0x400c0 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 19'h400b0  && read_transaction  ) begin
            src_channel = 53'b00000000001000000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 40;
    end

    // ( 0x400c0 .. 0x400d0 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 19'h400c0  && read_transaction  ) begin
            src_channel = 53'b00000000000100000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 39;
    end

    // ( 0x400d0 .. 0x400e0 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 19'h400d0  && read_transaction  ) begin
            src_channel = 53'b00000000000010000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 38;
    end

    // ( 0x400e0 .. 0x400f0 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 19'h400e0  && read_transaction  ) begin
            src_channel = 53'b00000000000001000000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 37;
    end

    // ( 0x400f0 .. 0x40100 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 19'h400f0  && read_transaction  ) begin
            src_channel = 53'b00000000000000100000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 36;
    end

    // ( 0x40100 .. 0x40110 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 19'h40100  && read_transaction  ) begin
            src_channel = 53'b00000000000000010000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 35;
    end

    // ( 0x40110 .. 0x40120 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 19'h40110  && read_transaction  ) begin
            src_channel = 53'b00000000000000001000000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 34;
    end

    // ( 0x40120 .. 0x40130 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 19'h40120  && read_transaction  ) begin
            src_channel = 53'b00000000000000000100000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x40130 .. 0x40140 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 19'h40130   ) begin
            src_channel = 53'b00000000000000000010000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x40140 .. 0x40150 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 19'h40140  && read_transaction  ) begin
            src_channel = 53'b00000000000000000001000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 45;
    end

    // ( 0x40150 .. 0x40160 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 19'h40150  && read_transaction  ) begin
            src_channel = 53'b00000000000000000000100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x40160 .. 0x40170 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 19'h40160   ) begin
            src_channel = 53'b00000000000000000000010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 48;
    end

    // ( 0x40170 .. 0x40180 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 19'h40170   ) begin
            src_channel = 53'b00000000000000000000001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x40180 .. 0x40190 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 19'h40180   ) begin
            src_channel = 53'b00000000000000000000000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x40190 .. 0x401a0 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 19'h40190   ) begin
            src_channel = 53'b00000000000000000000000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x401a0 .. 0x401b0 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 19'h401a0   ) begin
            src_channel = 53'b00000000000000000000000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x401b0 .. 0x401c0 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 19'h401b0   ) begin
            src_channel = 53'b00000000000000000000000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x401c0 .. 0x401d0 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 19'h401c0   ) begin
            src_channel = 53'b00000000000000000000000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x401d0 .. 0x401e0 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 19'h401d0   ) begin
            src_channel = 53'b00000000000000000000000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x401e0 .. 0x401f0 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 19'h401e0   ) begin
            src_channel = 53'b00000000000000000000000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x401f0 .. 0x40200 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 19'h401f0   ) begin
            src_channel = 53'b00000000000000000000000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x40200 .. 0x40210 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 19'h40200   ) begin
            src_channel = 53'b00000000000000000000000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x40210 .. 0x40220 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 19'h40210   ) begin
            src_channel = 53'b00000000000000000000000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x40220 .. 0x40230 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 19'h40220   ) begin
            src_channel = 53'b00000000000000000000000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x40230 .. 0x40240 )
    if ( {address[RG:PAD34],{PAD34{1'b0}}} == 19'h40230   ) begin
            src_channel = 53'b00000000000000000000000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x40240 .. 0x40250 )
    if ( {address[RG:PAD35],{PAD35{1'b0}}} == 19'h40240   ) begin
            src_channel = 53'b00000000000000000000000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x40250 .. 0x40260 )
    if ( {address[RG:PAD36],{PAD36{1'b0}}} == 19'h40250   ) begin
            src_channel = 53'b00000000000000000000000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x40260 .. 0x40270 )
    if ( {address[RG:PAD37],{PAD37{1'b0}}} == 19'h40260   ) begin
            src_channel = 53'b00000000000000000000000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x40270 .. 0x40280 )
    if ( {address[RG:PAD38],{PAD38{1'b0}}} == 19'h40270   ) begin
            src_channel = 53'b00000000000000000000000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x40280 .. 0x40290 )
    if ( {address[RG:PAD39],{PAD39{1'b0}}} == 19'h40280   ) begin
            src_channel = 53'b00000000000000000000000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x40290 .. 0x402a0 )
    if ( {address[RG:PAD40],{PAD40{1'b0}}} == 19'h40290   ) begin
            src_channel = 53'b00000000000000000000000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x402a0 .. 0x402b0 )
    if ( {address[RG:PAD41],{PAD41{1'b0}}} == 19'h402a0   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x402b0 .. 0x402c0 )
    if ( {address[RG:PAD42],{PAD42{1'b0}}} == 19'h402b0   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x402c0 .. 0x402d0 )
    if ( {address[RG:PAD43],{PAD43{1'b0}}} == 19'h402c0   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x402d0 .. 0x402e0 )
    if ( {address[RG:PAD44],{PAD44{1'b0}}} == 19'h402d0   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0x402e0 .. 0x402f0 )
    if ( {address[RG:PAD45],{PAD45{1'b0}}} == 19'h402e0   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0x402f0 .. 0x40300 )
    if ( {address[RG:PAD46],{PAD46{1'b0}}} == 19'h402f0   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0x40300 .. 0x40310 )
    if ( {address[RG:PAD47],{PAD47{1'b0}}} == 19'h40300   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0x40310 .. 0x40320 )
    if ( {address[RG:PAD48],{PAD48{1'b0}}} == 19'h40310   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0x40320 .. 0x40330 )
    if ( {address[RG:PAD49],{PAD49{1'b0}}} == 19'h40320   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x40330 .. 0x40340 )
    if ( {address[RG:PAD50],{PAD50{1'b0}}} == 19'h40330   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x40340 .. 0x40350 )
    if ( {address[RG:PAD51],{PAD51{1'b0}}} == 19'h40340   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x40350 .. 0x40360 )
    if ( {address[RG:PAD52],{PAD52{1'b0}}} == 19'h40350   ) begin
            src_channel = 53'b00000000000000000000000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


