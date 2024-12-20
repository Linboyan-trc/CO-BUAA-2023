/*输入:
    ins
    输出:
        GRF:
            A3_RdRtRa_01
            GRF_WE_02
            GRF_WD_03
        ALU:
            ALU_B_04
            ALU_immExt_05
            ALU_Op_06
        DM:
            DM_WE_07
        NPC:
            isJr_08
            isBranch_09
            isJal_10
    其中位宽情况:
        A3_RdRtRa_01   1:0
        GRF_WD_03       1:0
        ALU_Op_06 000   2:0
*/
module Controller(
    input [31:0]ins,

    output GRF_WE_02,ALU_B_04,ALU_immExt_05,DM_WE_07,isJr_08,isBranch_09,isJal_10,
    output [1:0]A3_RdRtRa_01,GRF_WD_03,
    output [2:0]ALU_Op_06
);
    //得到op和func
    wire [5:0]op,func;
    assign op=ins[31:26];
    assign func=ins[5:0];

    //根据op和func判断指令
    wire R,add,sub,jr;
    wire xor_n;
    wire ori,lw,sw,beq,lui;
    wire jal;
    wire nop;
        //R
        assign R    = (op==6'b000000);
        assign add  = (R)&(func==6'b100_000);
        assign sub  = (R)&(func==6'b100_010);
        assign jr   = (R)&(func==6'b001_000);
        assign xor_n = (R)&(func==6'b100110);
        //I
        assign ori  = (op==6'b001_101);
        assign lw   = (op==6'b100_011);
        assign sw   = (op==6'b101_011);
        assign beq  = (op==6'b000_100);
        assign lui  = (op==6'b001_111);
        //J
        assign jal  = (op==6'b000_011);
        //nop
        assign nop  = (ins==32'h0000_0000);
    
    //根据指令写输出
        //GRF:
            assign A3_RdRtRa_01 =  (add||sub||xor_n)?2'b00:
                                    (ori||lw||lui)?2'b01:
                                    (jal)?2'b10:
                                    2'b00;  //00 Rd;01 Rt;10 $ra
            assign GRF_WE_02    =  (add||sub||ori||lw||lui||jal||xor_n)?1:0;
            assign GRF_WD_03    =  (add||sub||ori||lui||xor_n)?2'b00:
                                    (lw)?2'b01:
                                    (jal)?2'b10:
                                    2'b00;  //00 ALU;01 DM-lw;10 PC+4-jal
        //ALU:
            assign ALU_B_04     =  (ori||lw||sw||lui)?1:0;
            assign ALU_immExt_05    = (lw||sw)?1:0;
            assign ALU_Op_06    = (add||lw||sw)?3'b000:
                                    (sub)?3'b001:
                                    (xor_n)?3'b010:
                                    (ori)?3'b011:
                                    (lui)?3'b100:
                                    3'b000;  //000 +;001 -;011 |;100 lui
        //DM:
            assign DM_WE_07 =   (sw)?1:0;
        //NPC:
            assign isJr_08  =   (jr)?1:0;
            assign isBranch_09  =   (beq)?1:0;
            assign isJal_10 =   (jal)?1:0;
endmodule //Controller
