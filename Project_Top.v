`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  Project_Top.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Dec 19, 2018 
 *
 * Purpose: This module is used to instantiate the Receive Engine of the 
 * UART.
 *
 * Notes: This included the TXRDY register, DOIT register, Loadable register 
 * for OUT_PORT data, Encoder for Parity bits, the Shift Register, 
 * Bit-Time Counter, and Bit Counter.
 ****************************************************************************/
module Project_Top(clk, rst, EIGHT, PEN, OHEL, BAUD, RX, LED, TX);
	input 					clk, rst, EIGHT, PEN, OHEL, RX; 
	input			[3:0]		BAUD;
	output reg 	[15:0]	LED;
	output wire 			TX;
//***************************************************************************			
	reg			interrupt;
	wire			RST_S, PED_OUT, interrupt_ack, 
					WRITE_STROBE, READ_STROBE,
					LOAD;
	wire [7:0]	IN_PORT;
	wire [15:0]	PORT_ID, OUT_PORT,  
					WRITES, READS;	
	wire [18:0]	k;
//***************************************************************************		
	// AISO
	AISO AISO 	 ( .clk(clk), 	.rst(rst), .RST_S(RST_S) ); // synchronous reset	
//***************************************************************************		
	// Walking LEDs:
	always @(posedge clk, posedge RST_S) begin
		if (RST_S) 			LED <= 16'b0; 		else
		if (WRITES[1]) 	LED <= OUT_PORT;	else
								LED <= LED; 
	end					 
//***************************************************************************
	// Address Decoder
	AdrDecoder AdrDecoder( 	.PORT_ID(PORT_ID[3:0]),
									.WRITE_STROBE(WRITE_STROBE),
									.READ_STROBE(READ_STROBE),
									.READS(READS),
									.WRITES(WRITES) );
//***************************************************************************
	// BAUD Decoder
	BAUD_Decoder baud_decoder ( .BAUD(BAUD), .k(k) ); // BAUD Rate
//***************************************************************************
	// UART 
	UART_Top UART( .clk(clk), 
						.rst(RST_S), 
						.EIGHT(EIGHT), 
						.PEN(PEN), 
						.OHEL(OHEL),
						.RX(RX),
						.k(k),
						.READS(READS),
						.WRITES(WRITES),
						.OUT_PORT(OUT_PORT[7:0]),
						.TX(TX),
						.IN_PORT(IN_PORT),
						.PED_OUT(PED_OUT) );
//***************************************************************************	 
	 // Interrupt Service Routine/ RS Flop
	 always@(posedge clk, posedge RST_S)begin
		if(RST_S)				interrupt <= 1'b0;else
		if(PED_OUT)				interrupt <= 1'b1;else
		if(interrupt_ack)		interrupt <= 1'b0;
		else						interrupt <= interrupt;
	 end
//***************************************************************************
	 // Tramel Blaze Processor
	 tramelblaze_top tramelblaze_top(
							.CLK(clk), 
							.RESET(RST_S), 
							.IN_PORT( {8'b0, IN_PORT} ), 
							.INTERRUPT(interrupt), 
							.OUT_PORT(OUT_PORT), 
							.PORT_ID(PORT_ID), 
							.READ_STROBE(READ_STROBE), 
							.WRITE_STROBE(WRITE_STROBE), 
							.INTERRUPT_ACK(interrupt_ack) );
//***************************************************************************			
endmodule
