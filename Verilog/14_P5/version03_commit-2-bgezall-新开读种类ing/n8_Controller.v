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
//ins**********************************
    input [31:0]ins,
//GRF**********************************
    output [1:0]GRF_A3_01,
    output      GRF_WE_02,
    output [1:0]GRF_WD_03,
//ALU**********************************
    output      ALU_B_01,
    output      ALU_immExt_02,
    output [2:0]ALU_Op_03,
//DM***********************************
    output      DM_WE_01,
//NPC**********************************
    output      NPC_isJr_01,
    output      NPC_isJal_02,
    output      NPC_isBranch_03,
    output      NPC_isBgezall_04,
//ins_parts****************************
    output [4:0]    Rs,
    output [4:0]    Rt,
    output [4:0]    Rd,
    output [15:0]   imm,
    output [25:0]   ins_index
);
    //1.得到op和func
    wire [5:0]op,func;
    assign op   =ins[31:26];
    assign func =ins[5:0];

    //2.根据op和func判断指令
    wire R;
    wire add,sub,jr;

    wire ori,lw,sw,beq,lui;
    wire bgezall;

    wire jal;

    wire nop;
        //R
        assign R    = (op==6'b000000);
        assign add  = (R)&(func==6'b100_000);
        assign sub  = (R)&(func==6'b100_010);
        assign jr   = (R)&(func==6'b001_000);
        //I
        assign ori  = (op==6'b001_101);
        assign lw   = (op==6'b100_011);
        assign sw   = (op==6'b101_011);
        assign beq  = (op==6'b000_100);
        assign lui  = (op==6'b001_111);
        assign bgezall = (op==6'b111_111);
        //J
        assign jal  = (op==6'b000_011);
        //nop
        assign nop  = (ins==32'h0000_0000);
    
    //根据指令写输出
        //GRF:
            assign GRF_A3_01    =   (add||sub)?2'b00:
                                    (ori||lw||lui)?2'b01:
                                    (jal||bgezall)?2'b10:
                                    2'b00;  //00 Rd;01 Rt;10 $ra
            assign GRF_WE_02    =   (add||sub||ori||lw||lui||jal||bgezall)?1:0;
            assign GRF_WD_03    =   (add||sub||ori||lui)?2'b00:
                                    (lw)?2'b01:
                                    (jal||bgezall)?2'b10:
                                    2'b00;  //00 ALU;01 DM-lw;10 PC+4-jal
        //ALU:
            assign ALU_B_01     =   (ori||lw||sw||lui)?1:0;
            assign ALU_immExt_02=   (lw||sw)?1:0;
            assign ALU_Op_03    =   (add||lw||sw)?3'b000:
                                    (sub)?3'b001:
                                    (ori)?3'b011:
                                    (lui)?3'b100:
                                    3'b000;  //000 +;001 -;011 |;100 lui
        //DM:
            assign DM_WE_01     =   (sw)?1:0;
        //NPC:
            assign NPC_isJr_01  =   (jr)?1:0;
            assign NPC_isJal_02 =   (jal)?1:0;
            assign NPC_isBranch_03 = (beq)?1:0;
            assign NPC_isBgezall_04 = (bgezall)?1:0;
        //ins_parts
            assign Rs = ins[25:21];
            assign Rt = ins[20:16];
            assign Rd = ins[15:11];
            assign imm = ins[15:0];
            assign ins_index = ins[25:0];
endmodule //Controller
