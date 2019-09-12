`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  UART_TX.v
 * Project:    FULL UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 26, 2018 
 *
 * Purpose: This module is used to instantiate the Transmit Engine of the 
 * UART.
 *
 * Notes: This included the TXRDY register, DOIT register, Loadable register 
 * for OUT_PORT data, Encoder for Parity bits, the Shift Register, 
 * Bit-Time Counter, and Bit Counter.
 ****************************************************************************/
module UART_TX(clk, rst, OUT_PORT, k, EIGHT, PEN, OHEL, TXRDY, TX, LOAD);
//*****************************************************************************	
	input 				clk, rst, EIGHT, PEN, OHEL, LOAD; // switches from board
	input [18:0]		k;				// From BAUD Decoder
	input [7:0]			OUT_PORT;	// From TramelBlaze
	output reg			TXRDY;		// Sent to PED
	output wire			TX;			// RX signal on Board(INVERTED)
//*****************************************************************************				
	reg 					DOIT, 		// Output of DOIT Reg
							LOADDI;		// Loads Shift Reg
	wire 					//	Paritity Bits: Odd/Even
							EP, OP,
							// Output of Bit Time Counter:
							BTU, 		// Will also SHIFT data in Shift Reg
							// Output of Bit Counter:
							DONE;		// When DONE is active Counters are reseted 
	reg 	[7:0]			LDATA;	// Data that goes to Encoder and Shift Reg
	reg 	[1:0]			tn_bit;	// Output of encoder
	reg	[3:0]			count; 	// Count of bit counter
	reg 	[10:0] 		SR;		// Data of shift register 
	reg	[18:0]		k_count;	// Count of bit time counter
//*********************************	********************************************
// TXRDY Register: *TXRDY signal is low active(logic is INVERTED)
	always@(posedge clk, posedge rst)begin
		if	(rst)				TXRDY <= 1'b1;			// Rest TXRDY
		else if(LOAD)		TXRDY <= 1'b0;			// Set TXRDY
		else if(DONE)		TXRDY <= 1'b1;			// Clear TXRDY
		else					TXRDY <= TXRDY;		
	end		
//*****************************************************************************	
// DOIT Register:
	always@(posedge clk, posedge rst)begin
		if(rst)				DOIT <= 1'b0;			// Reset DOIT
		else if(LOAD)		DOIT <= 1'b1;			// Set DOIT
      else if(DONE)		DOIT <= 1'b0;			// Clear DOIT
		else					DOIT <= DOIT;
	end
//*****************************************************************************	
// Loadable Register:
	always@(posedge clk, posedge rst)begin
		if(rst)				LDATA <= 8'b0;				// Reset LDATA
		else if(LOAD)		LDATA <= OUT_PORT[7:0];	// Load Data from Outport[7:0]
		else					LDATA <= LDATA;
	end
//*****************************************************************************	
// LOADD1 Register:  
	always@(posedge clk, posedge rst)begin
		if(rst)				LOADDI <= 1'b0;			// If rst, Q gets 0
		else					LOADDI <= LOAD;			// D gets Q
	end
//*****************************************************************************
// Set Parity Bits:
	assign EP = (EIGHT) ?  (^LDATA) :  (^LDATA[6:0]); 	// If Even
	assign OP = (EIGHT) ? ~(^LDATA) : ~(^LDATA[6:0]);	// If Odd
//*****************************************************************************
// ENCODER: Based on TABLE provided
	always@(*)begin
		case( {EIGHT, PEN, OHEL} )
			3'b000 : {tn_bit} = 2'b11;				
			3'b001 : {tn_bit} = 2'b11;
			3'b010 : {tn_bit} = {1'b1, EP};
			3'b011 : {tn_bit} = {1'b1, OP};
			3'b100 : {tn_bit} = {1'b1, LDATA[7]};
			3'b101 : {tn_bit} = {1'b1, LDATA[7]};
			3'b110 : {tn_bit} = {EP, 	LDATA[7]};
			3'b111 : {tn_bit} = {OP, 	LDATA[7]};
		endcase
	end
//*****************************************************************************
// Shift Register: 
//*****************************************************************************
	always@(posedge clk, posedge rst)begin
		if(rst) 		SR <= 11'b11111111111;else // Reset to ALL ONES
		//-----------------------------------------------------------------
		// Load Data: 
		if(LOADDI)	SR <= {tn_bit, LDATA[6:0], 2'b01};else
		//-----------------------------------------------------------------
		// Shift Data:
		if(BTU)		SR <= {1'b1, SR[10:1]}; // Shift right and fill in 1	
		//-----------------------------------------------------------------
		else			SR <= SR;
	end
//*****************************************************************************
	assign TX = SR[0];
//*****************************************************************************
// Bit Time Counter:
	assign BTU =(k_count==k);
	always @(posedge clk, posedge rst)begin
		if(rst)				k_count <= 19'b0; else
		// INCRMENT when DOIT = 1 and BTU = 0
		if(DOIT & ~BTU) 	k_count <= k_count + 19'b1;	
		else					k_count <= 19'b0;
	end
//*****************************************************************************
// Bit Counter:
	assign DONE = (count==11);
	always @(posedge clk, posedge rst)begin
		if(rst)				count <= 4'b0; else
		// If DOIT = 0, COUNT is 0
		if(~DOIT)			count <= 4'b0; else
		// INCREMENT when DOIT = 1 and BTU = 1
		if(DOIT & BTU) 	count <= count + 4'b1; 
		else					count <= count;
	end
//*****************************************************************************	

endmodule
