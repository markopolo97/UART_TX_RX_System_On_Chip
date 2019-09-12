`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  RX_Controller.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Dec 2, 2018 
 *
 * Purpose: This module is used to instantiate part of the Recieving Engine 
 * of the UART.
 *
 ****************************************************************************/
module RX_Controller(clk, rst, k, EIGHT, PEN, RX, BTU, DONE, START);
//*****************************************************************************
	//------------------------------------------- 
	// Inputs and Outputs:
	//------------------------------------------- 
	input			 clk, rst, EIGHT, PEN, RX;
	input [18:0] k;
	output wire	 BTU, DONE, START;
	//------------------------------------------- 
	// Wires and Registers:
	//------------------------------------------- 
	wire 			 DOIT;  
	wire	[18:0] k_START;
	reg			 P_START, P_DOIT, N_START, N_DOIT;
	reg 	[1:0]	 PS, NS;
	reg	[3:0]	 SW_count, bit_count;
	reg	[18:0] k_count;
	//------------------------------------------- 
	// State Machine Parameters:
	//------------------------------------------- 
	parameter [1:0] 	S0 = 2'b00, 
							S1 = 2'b01,
							S2 = 2'b10,
							S3 = 2'b11;
//*****************************************************************************
	assign k_START = (START) ? k>>1 : k; // If START = 1, then k/2 or k>>1
//*****************************************************************************
// Bit Time Counter:
//*****************************************************************************
	assign BTU =(k_count==k_START);
	always @(posedge clk, posedge rst)begin
		if(rst)				k_count <= 19'b0; 
		else if(BTU)		k_count <= 19'b0;
		else if(DOIT) 		k_count <= k_count + 19'b1;	
		else					k_count <= 19'b0;
	end
//*****************************************************************************
// Bit Counter:
//*****************************************************************************
	assign DONE = (bit_count==SW_count);
	always @(posedge clk, posedge rst)begin
		if(rst)					bit_count <= 4'b0; 
		else if(DOIT & BTU) 	bit_count <= bit_count + 4'b1; 
		else if(DOIT & ~BTU) bit_count <= bit_count; 
		else						bit_count <= 4'b0;
	end
//*****************************************************************************
	always@(*)begin
		case( {EIGHT, PEN} )
			S0 : SW_count = 4'b1001; // 9
			S1 : SW_count = 4'b1010; // 10
			S2 : SW_count = 4'b1010; // 10
			S3 : SW_count = 4'b1011; // 11
		endcase
	end
//*****************************************************************************
// STATE MACHINE:	
//*****************************************************************************
// State Register
//*****************************************************************************	
	assign {START, DOIT} = {P_START, P_DOIT};
	always@(posedge clk, posedge rst)begin
		if(rst) 	{PS, P_START, P_DOIT} <= {S0, 1'b0, 1'b0};
		else 		{PS, P_START, P_DOIT} <= {NS, N_START, N_DOIT};
	end
//*****************************************************************************	
// Next State and Output Combo Logic
//*****************************************************************************	
	always@(*) begin	
		case(PS) 
			//-----------------------------------------------------------------------
		 	S0: 	begin
					{N_START, N_DOIT} = {1'b0, 1'b0};
					NS = (RX) ? S0 : S1; 
					end
			//-----------------------------------------------------------------------
			S1: 	begin
					{N_START, N_DOIT} = {1'b1, 1'b1};
					NS = (RX) ? S0 : ( (BTU) ? S2 : S1 );
					end
			//-----------------------------------------------------------------------
			S2: 	begin
					{N_START, N_DOIT} = {1'b0, 1'b1};
					NS = (DONE) ? S0 : S2; 
					end
			//-----------------------------------------------------------------------	
			default: begin
					{NS, N_START, N_DOIT} = {S0, 1'b0, 1'b0};
					end
			//-----------------------------------------------------------------------
		endcase
	end
//*****************************************************************************	
endmodule
