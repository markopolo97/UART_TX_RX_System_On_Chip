`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  AISO.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Feb 12, 2018 
 *
 * Purpose: This module is used to convert an asynchronous reset to a
 * synchronous out reset. We want a sychronous reset to avoid any 
 * metastability caused by the reset switch.(Code from Tramel)
 ****************************************************************************/
module AISO(clk, rst, RST_S);

	// Declare Inputs and Outputs
	input clk, rst;
	output wire RST_S;
	
	reg Q_meta, Q_ok;
    
	always@(posedge clk, posedge rst)
	
		if(rst)		{Q_meta, Q_ok} <= {1'b0, 1'b0};
		
		else 			{Q_meta, Q_ok} <= {1'b1, Q_meta};
			
	assign RST_S = (~Q_ok);
		
endmodule
