/*
    R:不需要扩展
    I:
        ori 0扩展
        lw  符号扩展
        sw  符号扩展
        beq NPC处理
        lui ALU处理
    J:不需要扩展
*/
/*输出:
    imm,zeroOrSigned
    输出:immHasExted
*/
module EXT(
    input [15:0]imm,
    input zeroOrSigned,

    output [31:0]immHasExted
);
    assign immHasExted =    (zeroOrSigned==0)?{16'd0,imm}:
                            {{16{imm[15]}},imm};
    
endmodule 
