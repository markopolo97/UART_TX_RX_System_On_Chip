`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  Top Level.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Dec 18, 2018 
 *
 * Purpose: This module is used to instantiate the Receive Engine of the 
 * UART.
 *
 * Notes: This included the TXRDY register, DOIT register, Loadable register 
 * for OUT_PORT data, Encoder for Parity bits, the Shift Register, 
 * Bit-Time Counter, and Bit Counter.
 ****************************************************************************/
module Top_Level(clk, rst, EIGHT, PEN, OHEL, BAUD, RX, TX, LED);

	input clk, rst, EIGHT, PEN, OHEL, RX;
	input [3:0] BAUD;
	output TX;
	output[15:0] LED;
	//-----------------------------------------------------------------
	wire				w_clk, w_rst, w_EIGHT, w_PEN, w_OHEL, w_RX, w_TX;
	wire [3:0]		w_BAUD;
	wire [15:0]		w_LED;
	//-----------------------------------------------------------------
	Project_Top	core		(.clk(w_clk), 		.rst(w_rst), .BAUD(w_BAUD), 
								 .EIGHT(w_EIGHT), .PEN(w_PEN), .OHEL(w_OHEL), 
								 .RX(w_RX), 		.TX(w_TX), 	 .LED(w_LED));
	//-----------------------------------------------------------------	
	TSI			tsi		(.i_clk(clk), 		.i_rst(rst), .i_BAUD(BAUD), 
								 .i_EIGHT(EIGHT), .i_PEN(PEN), .i_OHEL(OHEL), 
						    	 .i_RX(RX), 		.i_TX(w_TX), .i_LED(w_LED), 
									 
								 .o_clk(w_clk), 	 	.o_rst(w_rst), .o_BAUD(w_BAUD), 
								 .o_EIGHT(w_EIGHT), 	.o_PEN(w_PEN), .o_OHEL(w_OHEL), 
								 .o_RX(w_RX), 			.o_TX(TX), 		.o_LED(LED) );
	//-----------------------------------------------------------------
endmodule
