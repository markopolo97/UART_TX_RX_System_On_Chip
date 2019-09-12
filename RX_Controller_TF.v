`timescale 1ns / 1ps

/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  RX_Controller_TF.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Dec 19, 2018 
 *
 * Purpose: This module is used to verify that the RX Controller.
 ****************************************************************************/

module RX_Controller_TF;

	// Inputs
	reg clk;
	reg rst;
	reg [18:0] k;
	reg EIGHT;
	reg PEN;
	reg RX;

	// Outputs
	wire BTU;
	wire DONE;
	wire START;

	// Instantiate the Unit Under Test (UUT)
	RX_Controller uut (
		.clk(clk), 
		.rst(rst), 
		.k(k), 
		.EIGHT(EIGHT), 
		.PEN(PEN), 
		.RX(RX), 
		.BTU(BTU), 
		.DONE(DONE), 
		.START(START)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		k = 0;
		EIGHT = 0;
		PEN = 0;
		RX = 0;

		// Wait 100 ns for global reset to finish
		#100 rst   = 0;
		#10  EIGHT = 1;
			  PEN   = 1;
    
		// Add stimulus here

	end
      
endmodule

