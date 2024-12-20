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

    output [1:0]GRF_1_A3_RdRtRa,
    output      GRF_2_WE,

    output      ALU_1_B,
    output      ALU_2_EXT,
    output [2:0]ALU_3_Op,
    
    output DM_WE,

    output isJr,isBranch,isJal
);
    //得到op和func
    wire [5:0]op,func;
    assign op=ins[31:26];
    assign func=ins[5:0];

    //根据op和func判断指令
    wire R,add,sub,jr;
    wire ori,lui,beq,lw,sw;
    wire jal;
    wire nop;
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
        //nop
        assign nop  = (ins==32'h0000_0000);
    
    //根据指令写输出
        //GRF:
            assign GRF_1_A3_RdRtRa  =   (add||sub)?2'b00:       //00 Rd
                                        (ori||lui||lw)?2'b01:   //01 Rt
                                        (jal)?2'b10:            //10 Ra
                                        2'b00;  
            assign GRF_2_WE     =   (add||sub||ori||lui||lw||jal)?1:0;
        //
        //ALU:
            assign ALU_1_B      =   (ori||lui||lw||sw)?1:0;      //1 imm;0 Rt
            assign ALU_2_EXT    =   (lw||sw)?1:0;                //ori lui 0扩展; lw sw符号扩展
            assign ALU_3_Op     =   (add||lw||sw)?3'b000:   //000 +
                                    (sub)?3'b001:           //001 -
                                    (ori)?3'b011:           //011 |
                                    (lui)?3'b100:           //100 lui
                                    3'b000;  
        //DM:
            assign DM_WE    =   (sw)?1:0;
        //NPC:
            assign isJr         =   (jr)?1:0;
            assign isBranch     =   (beq)?1:0;
            assign isJal        =   (jal)?1:0;
endmodule
