`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  RX_DataPath.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Dec 3, 2018 
 *
 * Purpose: This module is used to instantiate part the Recieving Engine of the 
 * UART.
 *
 ****************************************************************************/
//*****************************************************************************
module RX_DataPath(clk, rst, BTU, START, RX, EIGHT, PEN, OHEL, DONE, CLR,  
						 REMAP_OUT, RXRDY, PERR, FERR, OVF);
//*****************************************************************************
// INPUTS AND OUTPUTS:
//*****************************************************************************				
	input 				clk, rst, BTU, START, RX, EIGHT, PEN, OHEL, DONE, CLR;
	output reg 			RXRDY, PERR, FERR, OVF;
	output wire [7:0] REMAP_OUT;
//*****************************************************************************
// REG and WIRES
//*****************************************************************************
	reg					STOP_SEL;
	reg			[9:0] SDO, REMAP;
	wire					GEN_OUTPUT, P_GEN_BIT, EVEN,
							GEN_SEL, BIT_SEL,
							SET_PAR, SET_FRAM, SET_OVF;
//*****************************************************************************
// SHIFT REGISTER:
//*****************************************************************************
	assign SH = BTU & (~START);
	always@(posedge clk, posedge rst)begin
		if(rst)	SDO <= 10'b0;else
		if(SH)	SDO <= {RX, SDO[9:1]}; // SHIFT in RX
		else		SDO <= SDO; 
	end
//*****************************************************************************
// REMAP COMBO:
//*****************************************************************************
	always@(*)begin
      case ( {EIGHT, PEN})
         2'b00: REMAP  =  {2'b11, SDO[9:2]};
         2'b01: REMAP  =  {1'b1,  SDO[9:1]};
         2'b10: REMAP  =  {1'b1,  SDO[9:1]};
         2'b11: REMAP  =  SDO;
      endcase
	end
//*****************************************************************************
	assign {REMAP_OUT, GEN_SEL, BIT_SEL} = (EIGHT) ? {REMAP[7:0], REMAP[7], REMAP[8]}:
																	 {1'b0, REMAP[6:0], 1'b0, SDO[7]};	
	assign EVEN	= ~OHEL;
	assign GEN_OUTPUT = (EVEN) ? (GEN_SEL ^ REMAP[6:0]): ~(GEN_SEL ^ REMAP[6:0]);
	assign P_GEN_BIT 	= (GEN_OUTPUT ^ BIT_SEL);
//----------------------------------------------------------------------
	always@(*)begin
		case({EIGHT, PEN})
			2'b00 :	STOP_SEL = REMAP[7];
			2'b01 :	STOP_SEL = REMAP[8];
			2'b10 :	STOP_SEL = REMAP[9];
			2'b11	:	STOP_SEL = REMAP[8];
		endcase
	end
//*****************************************************************************
// SR FLOPS:
//*****************************************************************************
//----------------------------------------------------------------------------
// RX READY:
//----------------------------------------------------------------------------
	always@(posedge clk, posedge rst)begin
		if(rst)				RXRDY <= 1'b0;else		// Reset RXRDY
		if(DONE)				RXRDY <= 1'b1;else		// Set 	RXRDY
      if(CLR)				RXRDY <= 1'b0;			   // Clear RXRDY
		else					RXRDY <= RXRDY;
	end
//----------------------------------------------------------------------------
// Parity Error:
//----------------------------------------------------------------------------
	assign SET_PAR	= PEN  & P_GEN_BIT & DONE;
	always@(posedge clk, posedge rst)begin
		if(rst)				PERR <= 1'b0;else			// Reset PERR
		if(SET_PAR)			PERR <= 1'b1;else			// Set 	PERR
      if(CLR)				PERR <= 1'b0;			   // Clear PERR
		else					PERR <= PERR;
	end
//----------------------------------------------------------------------------
// Framing Error:
//----------------------------------------------------------------------------
	assign SET_FRAM = DONE & ~STOP_SEL;
	always@(posedge clk, posedge rst)begin
		if(rst)				FERR <= 1'b0;else			// Reset FERR
		if(SET_FRAM)		FERR <= 1'b1;else			// Set 	FERR
      if(CLR)				FERR <= 1'b0;				// Clear FERR
		else					FERR <= FERR;
	end
//----------------------------------------------------------------------------
// Overflow:
//----------------------------------------------------------------------------
	assign SET_OVF	= DONE & RXRDY;
	always@(posedge clk, posedge rst)begin
		if(rst)				OVF <= 1'b0;else			// Reset OVF
		if(SET_OVF)			OVF <= 1'b1;else			// Set 	OVF
      if(CLR)				OVF <= 1'b0;				// Clear OVF
		else					OVF <= OVF;
	end
//*****************************************************************************
endmodule

