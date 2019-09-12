`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:34:44 12/18/2018
// Design Name:   UART_Top
// Module Name:   C:/Users/Mark/Documents/CECS 460 Projects/CECS460Project3/UART_TOP_TF.v
// Project Name:  CECS460Project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_TOP_TF;

	// Inputs
	reg clk;
	reg rst;
	reg EIGHT;
	reg PEN;
	reg OHEL;
	reg RX;
	reg [18:0] k;
	reg [15:0] READS;
	reg [15:0] WRITES;
	reg [7:0] OUT_PORT;

	// Outputs
	wire TX;
	wire [7:0] IN_PORT;
	wire PED_OUT;

	// Instantiate the Unit Under Test (UUT)
	UART_Top uut (
		.clk(clk), 
		.rst(rst), 
		.EIGHT(EIGHT), 
		.PEN(PEN), 
		.OHEL(OHEL), 
		.RX(RX), 
		.k(k), 
		.READS(READS), 
		.WRITES(WRITES), 
		.OUT_PORT(OUT_PORT), 
		.TX(TX), 
		.IN_PORT(IN_PORT), 
		.PED_OUT(PED_OUT)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		EIGHT = 0;
		PEN = 0;
		OHEL = 0;
		RX = 0;
		k = 0;
		READS = 0;
		WRITES = 0;
		OUT_PORT = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

