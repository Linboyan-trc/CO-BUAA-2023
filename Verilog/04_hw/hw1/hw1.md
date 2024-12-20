```verilog
module ballotFive (
    input inA,inB,inC,inD,inE,
    output outF
);

    wire x1,x2,x3,x4,x5,x6,x7,x8,x9,x10;
    assign x1=inA&inB&inE;
    assign x2=inA&inC&inE;
    assign x3=inA&inB&inD;
    assign x4=inA&inC&inD;
    assign x5=(~inA)&inC&inD&inE;
    assign x6=(~inA)&inB&inD&inE;
    assign x7=(~inA)&inB&inC&inE;
    assign x8=(~inA)&inB&inC&inD;
    assign x9=inA&inB&inC&(~inD);
    assign x10=inA&(~inB)&inD&inE;
   
    assign outF=x1|x2|x3|x4|x5|x6|x7|x8|x9|x10;

endmodule
```
