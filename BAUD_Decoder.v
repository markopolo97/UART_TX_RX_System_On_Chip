`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name: 	BAUD_Decoder.v
 * Project:    Pull UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 10, 2018 
 *
 * Purpose: This module is used to determine which BAUD rate to use.
 *
 * Notes: Numbers come from table that Mr.Tramel provided for the Nexys 4.
 ****************************************************************************/
module BAUD_Decoder(BAUD, k);
	input 	    [3:0]	BAUD; 
	output reg  [18:0]	k; // Output to Bit Time Counter 
	
	// Value of Switches on Board for BAUD
	parameter 	BAUD_0  = 4'b0000, 
			BAUD_1  = 4'b0001, 
			BAUD_2  = 4'b0010, 
			BAUD_3  = 4'b0011, 
			BAUD_4  = 4'b0100,
			BAUD_5  = 4'b0101,
			BAUD_6  = 4'b0110,
			BAUD_7  = 4'b0111,
			BAUD_8  = 4'b1000,
			BAUD_9  = 4'b1001,
			BAUD_10 = 4'b1010,
			BAUD_11 = 4'b1011;
	
	// BAUD Rates
	always@(*)begin
		case(BAUD)
			BAUD_0 	: k = 19'd333333;
			BAUD_1 	: k = 19'd83333;
			BAUD_2 	: k = 19'd41667;
			BAUD_3 	: k = 19'd20833;
			BAUD_4 	: k = 19'd10417;
			BAUD_5 	: k = 19'd5208;
			BAUD_6 	: k = 19'd2604;
			BAUD_7 	: k = 19'd1736;
			BAUD_8 	: k = 19'd868;
			BAUD_9 	: k = 19'd434;
			BAUD_10 : k = 19'd217;
			BAUD_11 : k = 19'd109;
			default	: k = 19'b0;
		endcase
	end

endmodule
