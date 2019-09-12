`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  UART_RX.v
 * Project:    Project_3
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 26, 2018 
 *
 * Purpose: This module is used to instantiate the Receive Engine of the 
 * UART.
 *
 ****************************************************************************/
module UART_RX(	clk, rst, EIGHT, PEN, OHEL, RX, CLR, k, 
		DATA_OUT, OVF, FERR, PERR, RXRDY);
//*****************************************************************************
	input 			clk, rst, EIGHT, PEN, OHEL, CLR, RX;
	input 	    [18:0] 	k;
	output wire [7:0] 	DATA_OUT;
	output wire		OVF, FERR, PERR, RXRDY;
//*****************************************************************************
	wire			BTU, START, DONE;
//*****************************************************************************
	RX_Controller RX_Controller(	.clk(clk), 	.rst(rst), 	.k(k), 
					.EIGHT(EIGHT), 	.PEN(PEN), 	.RX(RX), 
					.BTU(BTU), 	.DONE(DONE), 	.START(START) );
//*****************************************************************************
	RX_DataPath RX_DataPath( .clk(clk), 
				 .rst(rst), 
				 .BTU(BTU), 
				 .START(START),
				 .RX(RX), 
				 .EIGHT(EIGHT),
				 .PEN(PEN),
				 .OHEL(OHEL),
				 .DONE(DONE), 
				 .CLR(CLR),
				 .REMAP_OUT(DATA_OUT), 
				 .RXRDY(RXRDY),
			         .PERR(PERR), 
				 .FERR(FERR), 
				 .OVF(OVF) );
//*****************************************************************************
endmodule

