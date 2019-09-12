`timescale 1ns / 1ps

/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  RX_datapath_TF.v
 * Project:    Project_2
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 29, 2018 
 *
 * Purpose: This module is used to verify that the RX datapath.
 ****************************************************************************/
module RX_Datapath_TF;

	// Inputs
	reg clk;
	reg rst;
	reg BTU;
	reg START;
	reg RX;
	reg EIGHT;
	reg PEN;
	reg OHEL;
	reg DONE;
	reg CLR;

	// Outputs
	wire [7:0] REMAP_OUT;
	wire RXRDY;
	wire PERR;
	wire FERR;
	wire OVF;

	// Instantiate the Unit Under Test (UUT)
	RX_DataPath uut (
		.clk(clk), 
		.rst(rst), 
		.BTU(BTU), 
		.START(START), 
		.RX(RX), 
		.EIGHT(EIGHT), 
		.PEN(PEN), 
		.OHEL(OHEL), 
		.DONE(DONE), 
		.CLR(CLR), 
		.REMAP_OUT(REMAP_OUT), 
		.RXRDY(RXRDY), 
		.PERR(PERR), 
		.FERR(FERR), 
		.OVF(OVF)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		BTU = 0;
		START = 0;
		RX = 0;
		EIGHT = 0;
		PEN = 0;
		OHEL = 0;
		DONE = 0;
		CLR = 0;

		// Wait 100 ns for global reset to finish
		#100 rst = 0;
			  EIGHT = 1;
			  RX = 1;
			  PEN = 1;
			  BTU = 0;
			  DONE = 1;
        
		// Add stimulus here

	end
      
endmodule

