module InsJudge(
    input [31:0]ins,
    output [2:0]judge
);
    //cal_r JReg            000 001
    //cal_i beq load store  010 011 100 101
    //Jal                   110
    //nop                   111

    //得到op和func
        wire [5:0]op,func;
        assign op=ins[31:26];
        assign func=ins[5:0];

        //根据op和func判断指令
        wire R,add,sub,jr;
        wire ori,lui,beq,lw,sw;
        wire jal;
            //R
            assign R    = (op==6'b000000);
            assign add  = (R)&(func==6'b100_000);
            assign sub  = (R)&(func==6'b100_010);
            assign jr   = (R)&(func==6'b001_000);
            //I
            assign ori  = (op==6'b001_101);
            assign lui  = (op==6'b001_111);
            assign beq  = (op==6'b000_100);
            assign lw   = (op==6'b100_011);
            assign sw   = (op==6'b101_011);
            //J
            assign jal  = (op==6'b000_011);

        assign judge =  (add||sub)?  3'b000:
                        (jr)?  3'b001:
                        (ori||lui)?  3'b010:
                        (beq)?  3'b011:
                        (lw)?  3'b100:
                        (sw)?  3'b101:
                        (jal)?  3'b110:
                        3'b111;
    
endmodule //InsJudge
