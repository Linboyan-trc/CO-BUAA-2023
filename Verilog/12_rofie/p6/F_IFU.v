`timescale 1ns / 1ps
`include "const.v"
`define N 4096

module F_IFU (
    input clk,
    input reset,
    input WE,
    input [31:0] npc,
    output [31:0] instr,
    output reg [31:0] pc
);

    reg [31:0] im [0:`N-1];

    assign instr = im[pc[15:2] - 13'HC00];
    
    initial begin
        pc <= 32'h0000_3000;
        // $readmemh("code.txt", im);
        im[0]<=32'h3401ffff;
        im[1]<=32'h10210003;
        im[2]<=32'h3402ffff;
        im[3]<=32'h3403ffff;
        im[4]<=32'h3404ffff;
        im[5]<=32'h3405ffff;
    end
    
    always @(posedge clk) begin
        if (reset) pc <= 32'h0000_3000;
        else if(WE) pc <= npc;

    end

    _DASM Dasm(
        .pc(pc),
        .instr(instr),
        .imm_as_dec(1'b1),
        .reg_name(1'b0),
        .asm()
    );
endmodule