`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  debounce.v
 * Project:    Project_1
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Feb 12, 2018 
 *
 * Purpose: This module is used to create a digital filter to remove any 
 * transitions that are less than 20 ms caused from a mechanical switch.
 ****************************************************************************/
module debounce(clk, rst, SW, O);

    // Declare Inputs and Outputs
    input 			clk, rst, SW;
    output wire 	O;
    wire 			TICK;
    
    // Instantiate Ticker and State Machine
    Ticker 			i0(.clk(clk), .rst(rst), .tick(TICK));
    StateMachine 	i2(.clk(clk), .rst(rst), .SW(SW), .TICK(TICK), .PO(O));


endmodule
