`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  AdrDecoder.v
 * Project:    Pull UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Oct 26, 2018 
 *
 * Purpose: This module is the Address Decoder that will determine which 
 * data from the Tramelblaze processor to send the exteral device(terminal).
 *
 * Notes: This is tied into the LOAD in the top level where
 *			 	LOAD = (PORT_ID == 16'b0) & WRITE_STROBE or WRITES[0]
 ****************************************************************************/
module AdrDecoder(PORT_ID, WRITE_STROBE, READ_STROBE, READS, WRITES);
		input  		[3:0]  PORT_ID;
		input   		 		 WRITE_STROBE, READ_STROBE;
		output reg	[15:0] WRITES, READS;
		
		always@(*)begin
			// Initialize WRITES and READS to 0:
			WRITES = 16'b0;
			READS	 = 16'b0;
			
			WRITES[PORT_ID] = WRITE_STROBE;
			READS[PORT_ID]	 = READ_STROBE;
		end

endmodule
