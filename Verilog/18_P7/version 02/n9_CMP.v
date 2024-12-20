module CMP(
    input [31:0]Rs,
    input [31:0]Rt,
    input CMP_Select,

    output isSuc
);

    //Select 0-beq 1-bne
    assign isSuc = (CMP_Select==1'b0)?  Rs==Rt:
                                        Rs!=Rt;

endmodule //CMP

