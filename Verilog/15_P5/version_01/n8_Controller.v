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
//输入**********************************
    input [31:0]    ins,
    input [2:0]     stage,
    input           isSuc,
//GRF**********************************
    output [1:0]    GRF_A3_01,
    output          GRF_WE_02,
//ALU**********************************
    output          ALU_B_01,
    output          ALU_immExt_02,
    output [2:0]    ALU_Op_03,
//DM***********************************
    output          DM_WE_01,
//NPC**********************************
    output          NPC_isJr_01,
    output          NPC_isJ_02,
    output          NPC_isBeq_03,
//ins_parts****************************
    output [4:0]    Rs,
    output [4:0]    Rt,
    output [4:0]    Rd,
    output [15:0]   imm,
    output [25:0]   ins_index,
//暂停转发******************************
    //1.送出选择
    output [1:0]    Forward_outChoose,
    //2.Tuse_Rs Tuse_Rt Tnew
    output [1:0]    Tuse_Rs,
    output [1:0]    Tuse_Rt,
    output [1:0]    Tnew,
    //3.是否读写
    output          isRead_Rs,
    output          isRead_Rt,
    output          isWrite,
    output [4:0]    WriteDes
);
//1.判断指令****************************************************************
    //1.op和func
    wire [5:0]op,func;
    assign op   =ins[31:26];
    assign func =ins[5:0];

    //2.根据op和func判断指令
    wire R;
    wire add,sub,jr;

    wire ori,lw,sw,beq,lui;

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
        //J
        assign jal  = (op==6'b000_011);
        //nop
        assign nop  = (ins==32'h0000_0000);

//2.对指令分类****************************************************************
    wire isCal_r,isJReg;
    wire isCal_i,isBeq,isLoad,isStore;
    wire isJ,isLink;

    assign isCal_r  =   (add||sub);
    assign isJReg   =   jr;
        assign isCal_i  =   (ori||lui);
        assign isBeq    =   beq;
        assign isLoad   =   lw;
        assign isStore  =   sw;
    assign isJ      =   jal;
    assign isLink   =   jal;

//3.根据指令写输出*************************************************************
    //单周期
        //GRF:
            assign GRF_A3_01    =   (isCal_r)?2'b00:
                                    (isLoad||isCal_i)?2'b01:
                                    (isLink)?2'b10:
                                    2'b00;  //00 Rd;01 Rt;10 $ra
            assign GRF_WE_02    =   (isCal_r||isCal_i||isLoad||isLink);
        //ALU:
            assign ALU_B_01     =   (isCal_i||isLoad||isStore);
            assign ALU_immExt_02=   (isLoad||isStore);
            assign ALU_Op_03    =   (add||lw||sw)?3'b000:
                                    (sub)?3'b001:
                                    (ori)?3'b011:
                                    (lui)?3'b100:
                                    3'b000;  //000 +;001 -;011 |;100 lui
        //DM:
            assign DM_WE_01     =   isStore;
        //NPC:
            assign NPC_isJr_01  =   isJReg;
            assign NPC_isJ_02   =   isJ;
            assign NPC_isBeq_03 =   isBeq;
        //ins_parts
            assign Rs = ins[25:21];
            assign Rt = ins[20:16];
            assign Rd = ins[15:11];
            assign imm = ins[15:0];
            assign ins_index = ins[25:0];
    //暂停转发
        //1.送出选择
            assign Forward_outChoose =
                (isLoad)?           2'b10:
                (isCal_r||isCal_i)? 2'b01:
                                    2'b00;
        //2.Tuse_Rs 
            wire [1:0] Tuse_D_Rs,Tuse_E_Rs,Tuse_M_Rs,Tuse_W_Rs;
            assign Tuse_D_Rs    =
                (isJReg||isBeq)?                        2'b00:
                (isCal_r||isCal_i||isLoad||isStore)?    2'b01:
                                                        2'b10;
            assign Tuse_E_Rs    =
                ((Tuse_D_Rs-1'b1)==2'b11)?           2'b00:
                                            Tuse_D_Rs-1'b1;
            assign Tuse_M_Rs    =
                ((Tuse_E_Rs-1'b1)==2'b11)?           2'b00:
                                            Tuse_E_Rs-1'b1;
            assign Tuse_W_Rs    =
                ((Tuse_M_Rs-1'b1)==2'b11)?           2'b00:
                                            Tuse_M_Rs-1'b1;
            assign Tuse_Rs  =
                (stage==3'd4)?  Tuse_W_Rs:
                (stage==3'd3)?  Tuse_M_Rs:
                (stage==3'd2)?  Tuse_E_Rs:
                (stage==3'd1)?  Tuse_D_Rs:
                                    2'b11;
        //2.Tuse_Rt
            wire [1:0] Tuse_D_Rt,Tuse_E_Rt,Tuse_M_Rt,Tuse_W_Rt;
            assign Tuse_D_Rt    =
                (isBeq)?    2'b00:
                (isCal_r)?  2'b01:
                (isStore)?  2'b10:
                            2'b11;
            assign Tuse_E_Rt    =
                ((Tuse_D_Rt-1'b1)==2'b11)?           2'b00:
                                            Tuse_D_Rt-1'b1;
            assign Tuse_M_Rt    =
                ((Tuse_E_Rt-1'b1)==2'b11)?           2'b00:
                                            Tuse_E_Rt-1'b1;
            assign Tuse_W_Rt    =
                ((Tuse_M_Rt-1'b1)==2'b11)?           2'b00:
                                            Tuse_M_Rt-1'b1;
            assign Tuse_Rt  =
                (stage==3'd4)?  Tuse_W_Rt:
                (stage==3'd3)?  Tuse_M_Rt:
                (stage==3'd2)?  Tuse_E_Rt:
                (stage==3'd1)?  Tuse_D_Rt:
                                    2'b11;
        //2.Tnew
            wire [1:0] Tnew_E,Tnew_M,Tnew_W;
            assign Tnew_E =
                (isLoad)?           2'b10:
                (isCal_r||isCal_i)? 2'b01:
                                    2'b00;
            assign Tnew_M    =
                ((Tnew_E-1'b1)==2'b11)?     2'b00:
                                      Tnew_E-1'b1;
            assign Tnew_W    =
                ((Tnew_M-1'b1)==2'b11)?     2'b00:
                                      Tnew_M-1'b1;
            assign Tnew =
                (stage==3'd4)?  Tnew_W:
                (stage==3'd3)?  Tnew_M:
                (stage==3'd2)?  Tnew_E:
                                2'b00;
        //3.是否读写
            assign isRead_Rs    =
                    (isCal_r||isJReg||isCal_i||isBeq||isLoad||isStore);

            assign isRead_Rt    =
                    (isCal_r||isBeq||isStore);

            assign isWrite      =
                    (isCal_r||isCal_i||isLoad||isLink);

            assign  WriteDes    =
                    (isCal_r)?          Rd:
                    (isCal_i||isLoad)?  Rt:
                                        5'd31;

endmodule //Controller
