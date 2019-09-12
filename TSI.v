`timescale 1ns / 1ps
/****************************** C E C S  4 6 0 ******************************
 * 
 * File Name:  TSI.v
 * Project:    Full UART
 * Designer:   Mark Aquiapao
 * Email:      markaquiapao@gmail.com
 * Rev. No.:   Version 1.0
 * Rev. Date:  Dec 19, 2018 
 ****************************************************************************/
module TSI(i_clk, i_rst, i_BAUD, i_EIGHT, i_PEN, i_OHEL, i_RX, i_TX, i_LED, 
		  	  o_clk, o_rst, o_BAUD, o_EIGHT, o_PEN, o_OHEL, o_RX, o_TX, o_LED);
			  
	
	input 			i_clk, i_rst, i_EIGHT, i_PEN, i_OHEL, i_RX, i_TX;
	input	[3:0] 	i_BAUD;
	input [15:0] 	i_LED;
	
	
	output 			o_clk, o_rst, o_EIGHT, o_PEN, o_OHEL, o_RX, o_TX;
	output [3:0] 	o_BAUD;
	output [15:0] 	o_LED;
	


   BUFG BUFG_inst( .O(o_clk),//1-bitoutput:Clockoutput
                   .I(i_clk)//1-bitinput:Clockinput
                 );   
   
   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) clk(
         .O(o_rst),//Bufferoutput
         .I(i_rst) //Bufferinput(connectdirectlytotop-levelport)
      );

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) BAUD[3:0](
         .O(o_BAUD[3:0]),//Bufferoutput
         .I(i_BAUD[3:0]) //Bufferinput(connectdirectlytotop-levelport)
      );   

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) EIGHT(
         .O(o_EIGHT),//Bufferoutput
         .I(i_EIGHT) //Bufferinput(connectdirectlytotop-levelport)
      );         
      
   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) PEN(
         .O(o_PEN),//Bufferoutput
         .I(i_PEN) //Bufferinput(connectdirectlytotop-levelport)
      );   

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) OHEL(
         .O(o_OHEL),//Bufferoutput
         .I(i_OHEL) //Bufferinput(connectdirectlytotop-levelport)
      );         
   
   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) RX(
         .O(o_RX),//Bufferoutput
         .I(i_RX) //Bufferinput(connectdirectlytotop-levelport)
      );   
      
   OBUF#(
      .DRIVE(12),//Specifytheoutputdrivestrength
      .IOSTANDARD("DEFAULT"),//SpecifytheoutputI/Ostandard
      .SLEW("SLOW")//Specifytheoutputslewrate
      ) TX(
         .O(o_TX),//Bufferoutput(connectdirectlytotop-levelport)
         .I(i_TX)//Bufferinput
      );   
   
   OBUF#(
      .DRIVE(12),//Specifytheoutputdrivestrength
      .IOSTANDARD("DEFAULT"),//SpecifytheoutputI/Ostandard
      .SLEW("SLOW")//Specifytheoutputslewrate
      ) LED[15:0](
         .O(o_LED[15:0]),//Bufferoutput(connectdirectlytotop-levelport)
         .I(i_LED[15:0])//Bufferinput
      );   

endmodule
