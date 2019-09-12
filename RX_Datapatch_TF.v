`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:52:05 12/19/2018
// Design Name:   Top_Level
// Module Name:   C:/Users/Mark/Documents/CECS 460 Projects/CECS460Project3/RX_Datapatch_TF.v
// Project Name:  CECS460Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Level
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RX_Datapatch_TF;

	// Inputs
	reg clk;
	reg rst;
	reg EIGHT;
	reg PEN;
	reg OHEL;
	reg [3:0] BAUD;
	reg RX;

	// Outputs
	wire TX;
	wire [15:0] LED;

	// Instantiate the Unit Under Test (UUT)
	Top_Level uut (
		.clk(clk), 
		.rst(rst), 
		.EIGHT(EIGHT), 
		.PEN(PEN), 
		.OHEL(OHEL), 
		.BAUD(BAUD), 
		.RX(RX), 
		.TX(TX), 
		.LED(LED)
	);
	
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		EIGHT = 0;
		PEN = 0;
		OHEL = 0;
		BAUD = 0;
		RX = 0;

		// Wait 100 ns for global reset to finish
		#100 rst = 0;
			  EIGHT = 1;
			  PEN = 1;
        
		// Add stimulus here

	end
      
endmodule

