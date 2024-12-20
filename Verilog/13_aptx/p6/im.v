`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:01 11/23/2018 
// Design Name: 
// Module Name:    im 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module im(
    input [31:0] PC,
    output[31:0] instruction
    );

	reg[31:0] im[0:4095];
	initial begin
		// $readmemh("code.txt",im);
        im[0]<=32'h3401ffff;
        im[1]<=32'h10210003;
        im[2]<=32'h3402ffff;
        im[3]<=32'h3403ffff;
        im[4]<=32'h3404ffff;
        im[5]<=32'h3405ffff;
        im[6]<=32'h10220001;
        im[7]<=32'h3406ffff;
        im[8]<=32'h34061234;
	end
	wire[31:0] pc=PC-32'h00003000;
	assign instruction = im[pc[13:2]];
	
endmodule
