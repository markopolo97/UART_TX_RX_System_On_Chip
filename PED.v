`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  PED.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 17, 2018 
 *
 * Purpose: This module is used create a PED(Positive Edge Detect) to go high 
 * after TXRDY is active.
 ****************************************************************************/
module PED(clk, rst, PED_IN, PED_OUT);
	// Declare Inputs and Outputs
	input 		clk, rst, PED_IN;
	output wire PED_OUT;
	reg 			Q1, Q2;
	
	always@(posedge clk, posedge rst)
		if(rst)	{Q1, Q2} <= {1'b0, 1'b0};
		else 		{Q1, Q2} <= {PED_IN, Q1};
	
	// AND gate of Q1 & not Q2
	assign PED_OUT = Q1 & (~Q2);

endmodule
