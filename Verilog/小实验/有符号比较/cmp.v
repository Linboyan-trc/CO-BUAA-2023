module cmp(
    input [2:0]A,B,
    output isABigerB
);
    wire [2:0]tempA,tempB;
    assign tempA = A;
    assign tempB = B;
    assign isABigerB = tempA > $signed(tempB);
endmodule //cmp
