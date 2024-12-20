module CMP(
    input [31:0]Rs,
    input [31:0]Rt,

    output isEqual
);
    assign isEqual = (Rs==Rt)?1:0;
endmodule //CMP

