`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  UART_TX.v
 * Project:    Project_3
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 26, 2018 
 *
 * Purpose: This module is used to instantiate the Receive Engine of the 
 * UART.
 *
 * Notes: This included the TXRDY register, DOIT register, Loadable register 
 * for OUT_PORT data, Encoder for Parity bits, the Shift Register, 
 * Bit-Time Counter, and Bit Counter.
 ****************************************************************************/
module UART_Top(	clk, rst, EIGHT, PEN, OHEL, RX, k, READS, WRITES, OUT_PORT, 
						TX, IN_PORT, PED_OUT);
//***************************************************************************
	input 					clk, rst, EIGHT, PEN, OHEL, RX;
	input  		[18:0]	k;
	input			[15:0]	READS, WRITES;
	input 		[7:0]		OUT_PORT;
	output wire	[7:0]		IN_PORT;
	output wire 			TX, PED_OUT;
//***************************************************************************				
	wire			TXRDY, RXRDY, PERR, FERR, OVF,
					PED_TX, PED_RX;
	wire [7:0]	STATUS, UART_RDATA;
//***************************************************************************		
	// UART TX Engine 
	UART_TX UART_TX ( .clk(clk), 
							.rst(rst), 
							.OUT_PORT(OUT_PORT[7:0]),
							.k(k),
							.EIGHT(EIGHT),
							.PEN(PEN),
							.OHEL(OHEL),
							.TXRDY(TXRDY),
							.TX(TX),
							.LOAD( WRITES[0] ) );
//***************************************************************************
	// UART RX Engine 
	UART_RX UART_RX ( .clk(clk), 
							.rst(rst), 
							.EIGHT(EIGHT),
							.PEN(PEN),
							.OHEL(OHEL),
							.RX(RX),
							.CLR(READS[0]),
							.k(k),
							.DATA_OUT(UART_RDATA),
							.OVF(OVF),
							.FERR(FERR),
							.PERR(PERR),
							.RXRDY(RXRDY) );
//***************************************************************************
	assign STATUS = {3'b0, OVF, FERR, PERR, TXRDY, RXRDY};
//***************************************************************************	
	assign IN_PORT = (READS[1]) ? STATUS : (READS[0]) ? UART_RDATA : 8'b0;
//***************************************************************************
	// Instantiate PEDs for RXRDY and TXRDY	
	PED 	TX_OUT ( .clk(clk), .rst(rst), .PED_IN(TXRDY), .PED_OUT(PED_TX) ),
			RX_OUT ( .clk(clk), .rst(rst), .PED_IN(RXRDY), .PED_OUT(PED_RX) );
//***************************************************************************
	assign PED_OUT =  PED_TX | PED_RX;
endmodule
