module EXT(
    input [15:0]imm,
    input zeroOrSigned,

    output [31:0]immHasExted
);
    assign immHasExted  =   (zeroOrSigned==0)?  {16'd0,imm}:
                                                {{16{imm[15]}},imm};
    
endmodule 
