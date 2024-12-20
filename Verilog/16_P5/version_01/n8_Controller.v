module Controller(
//输入**********************************
    input [31:0]    ins,
//Decode**********************************
    output          NPC_isJr_01,
    output          NPC_isJ_02,
    output          NPC_isBeq_03,
    output          OutSelect_D,
    output [4:0]    A3_D,
    output [1:0]    Tuse_Rs_D,
    output [1:0]    Tuse_Rt_D,
    output [1:0]    Tnew_D,
//Execute**********************************
    output          ALU_B_01,
    output          ALU_immExt_02,
    output [2:0]    ALU_Op_03,
    output          OutSelect_E,
//Memory***********************************
    output          DM_WE_01,
    output          OutSelect_M,
//WB**********************************

//IsRead****************************
    output          isRead_Rs,
    output          isRead_Rt
);

//1.识别指令****************************************************************

    //1.op和func
    wire [5:0]  op      =   ins[31:26];
    wire [5:0]  func    =   ins[5:0];
    wire [4:0]  Rs      =   ins[25:21];
    wire [4:0]  Rt      =   ins[20:16];
    wire [4:0]  Rd      =   ins[15:11];
    
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

//2.指令分类****************************************************************

    wire isCal_r,isJReg;
    wire isCal_i,isBeq,isLoad,isStore;
    wire isLink,isJ;

    //R
    assign isCal_r  =   (add||sub);
    assign isJReg   =   jr;
    //I
    assign isCal_i  =   (ori||lui);
    assign isBeq    =   beq;
    assign isLoad   =   lw;
    assign isStore  =   sw;
    //J
    assign isLink   =   jal;
    assign isJ      =   jal;

//3.给输出赋值*************************************************************

    //Decode
        assign NPC_isJr_01  =   isJReg;
        assign NPC_isJ_02   =   isJ;
        assign NPC_isBeq_03 =   isBeq;
        assign OutSelect_D  =   isLink;
        assign A3_D = 
            (isCal_r)?          Rd:
            (isCal_i||isLoad)?  Rt:
            (isLink)?           5'd31:
                                5'd0;
        assign Tuse_Rs_D = 
            (isJReg||isBeq)?                        2'd0:
            (isCal_r||isCal_i||isLoad||isStore)?    2'd1:
                                                    2'd3;
        assign Tuse_Rt_D = 
            (isBeq)?    2'd0:
            (isCal_r)?  2'd1:
            (isStore)?  2'd2:
                        2'd3;
        assign Tnew_D = 
            (isLoad)?           2'd3:
            (isCal_r||isCal_i)? 2'd2:
            (isLink)?           2'd1:
                                2'd0;

    //Execute
        assign ALU_B_01         = (isCal_i||isLoad||isStore);
        assign ALU_immExt_02    = (isLoad||isStore);
        assign ALU_Op_03        = 
            (add||lw||sw)?  3'd0:
            (sub)?          3'd1:
            (ori)?          3'd3:
            (lui)?          3'd4:
                            3'd0;
        assign OutSelect_E      = (isCal_r||isCal_i);

    //Memory
        assign DM_WE_01     = isStore;
        assign OutSelect_M  = isLoad;

    //WB
        /*无*/

    //IsRead
        assign isRead_Rs = (isCal_r||isJReg||isCal_i||isBeq||isLoad||isStore);
        assign isRead_Rt = (isCal_r||isBeq||isStore);

endmodule //Controller
