module Forward(
    input [31:0]INS_D,
    input [31:0]INS_E,
    input [31:0]INS_M,
    input [31:0]INS_W,

    //NPC
    output [1:0]JReg_NPC_RsChoose,
    //CMP
    output [1:0]Beq_CMP_RsChoose,
    output [1:0]Beq_CMP_RtChoose,
    //ALU
    output [2:0]cal_r_cal_i_load_store_ALU_RsChoose,
    output [2:0]                 cal_r_ALU_RtChoose,
    //Store
    output [1:0]store_RtChoose_DM_M,
    output [1:0]store_RtChoose_Rt_E
);
    //1.判断信号
        //D 
            //1.类型
            wire isCal_r_D,isJReg_D,isCal_i_D,isBeq_D,isLoad_D,isStore_D,isJal_D;
            //2.寄存器
            wire [4:0]Rs_D,Rt_D,Rd_D;
            //3.读写
            wire isRead_D,isWrite_D;
            wire [4:0]WriteDes_D;
            //4.ALU
            wire isNeedALURs_D;
        //E
            //1.类型
            wire isCal_r_E,isJReg_E,isCal_i_E,isBeq_E,isLoad_E,isStore_E,isJal_E;
            //2.寄存器
            wire [4:0]Rs_E,Rt_E,Rd_E;
            //3.读写
            wire isRead_E,isWrite_E;
            wire [4:0]WriteDes_E;
            //4.ALU
            wire isNeedALURs_E;
        //M
            //1.类型
            wire isCal_r_M,isJReg_M,isCal_i_M,isBeq_M,isLoad_M,isStore_M,isJal_M;
            //2.寄存器
            wire [4:0]Rs_M,Rt_M,Rd_M;
            //3.读写
            wire isRead_M,isWrite_M;
            wire [4:0]WriteDes_M;
            //4.ALU
            wire isNeedALURs_M;
        //W
            //1.类型
            wire isCal_r_W,isJReg_W,isCal_i_W,isBeq_W,isLoad_W,isStore_W,isJal_W;
            //2.寄存器
            wire [4:0]Rs_W,Rt_W,Rd_W;
            //3.读写
            wire isRead_W,isWrite_W;
            wire [4:0]WriteDes_W;
            //4.ALU
            wire isNeedALURs_W;


    //2.对D，E，M，W三条指令判断
        //D
            InsJudge InsJudge_D(
            //input输入
                .ins(INS_D),
            //output输出
                //类型判断
                .isCal_r(isCal_r_D),
                .isJReg(isJReg_D),

                .isCal_i(isCal_i_D),
                .isBeq(isBeq_D),
                .isLoad(isLoad_D),
                .isStore(isStore_D),

                .isJal(isJal_D),
                //寄存器
                .Rs(Rs_D),
                .Rt(Rt_D),
                .Rd(Rd_D),
                //是否读、写、写寄存器地址、是否需要ALU的Rs
                .isRead(isRead_D),
                .isWrite(isWrite_D),
                .WriteDes(WriteDes_D),
                .isNeedALURs(isNeedALURs_D)
            );
        //E
            InsJudge InsJudge_E(
            //input输入
                .ins(INS_E),
            //output输出
                //类型判断
                .isCal_r(isCal_r_E),
                .isJReg(isJReg_E),

                .isCal_i(isCal_i_E),
                .isBeq(isBeq_E),
                .isLoad(isLoad_E),
                .isStore(isStore_E),

                .isJal(isJal_E),
                //寄存器
                .Rs(Rs_E),
                .Rt(Rt_E),
                .Rd(Rd_E),
                //是否读、写、写寄存器地址、是否需要ALU的Rs
                .isRead(isRead_E),
                .isWrite(isWrite_E),
                .WriteDes(WriteDes_E),
                .isNeedALURs(isNeedALURs_E)
            );
        //M
            InsJudge InsJudge_M(
            //input输入
                .ins(INS_M),
            //output输出
                //类型判断
                .isCal_r(isCal_r_M),
                .isJReg(isJReg_M),

                .isCal_i(isCal_i_M),
                .isBeq(isBeq_M),
                .isLoad(isLoad_M),
                .isStore(isStore_M),

                .isJal(isJal_M),
                //寄存器
                .Rs(Rs_M),
                .Rt(Rt_M),
                .Rd(Rd_M),
                //是否读、写、写寄存器地址、是否需要ALU的Rs
                .isRead(isRead_M),
                .isWrite(isWrite_M),
                .WriteDes(WriteDes_M),
                .isNeedALURs(isNeedALURs_M)
            );
        //W
            InsJudge InsJudge_W(
            //input输入
                .ins(INS_W),
            //output输出
                //类型判断
                .isCal_r(isCal_r_W),
                .isJReg(isJReg_W),

                .isCal_i(isCal_i_W),
                .isBeq(isBeq_W),
                .isLoad(isLoad_W),
                .isStore(isStore_W),

                .isJal(isJal_W),
                //寄存器
                .Rs(Rs_W),
                .Rt(Rt_W),
                .Rd(Rd_W),
                //是否读、写、写寄存器地址、是否需要ALU的Rs
                .isRead(isRead_W),
                .isWrite(isWrite_W),
                .WriteDes(WriteDes_W),
                .isNeedALURs(isNeedALURs_W)
            );
    
    //1.NPC的Rs选择
        //10-ALU_M 01-PC8_M 00-RD1
        wire NPC_Rs_NeedForward;
        assign NPC_Rs_NeedForward = 
            (isJReg_D & isWrite_M & (~isLoad_M)
            & ( Rs_D==WriteDes_M ) & (Rs_D!=5'd0) 
            )?  1:
            0;
        assign JReg_NPC_RsChoose = 
            ( (isCal_r_M || isCal_i_M) & NPC_Rs_NeedForward )?  2'b10:
            ( isJal_M & NPC_Rs_NeedForward )? 2'b01:
            2'b00;

    //2.CMP
        //Rs
        //10-ALU_M 01-PC8_M 00-RD1
        wire CMP_Rs_NeedForward;
        assign CMP_Rs_NeedForward = 
            ( isBeq_D & isWrite_M & (~isLoad_M)
            & (Rs_D==WriteDes_M) & (Rs_D!=5'd0) 
            )?  1:
            0;
        assign Beq_CMP_RsChoose = 
            ( (isCal_r_M || isCal_i_M) & CMP_Rs_NeedForward )?  2'b10:
            ( isJal_M & CMP_Rs_NeedForward)? 2'b01:
            2'b00;
        //Rt
        //10-ALU_M 01-PC8_M 00-RD2
        wire CMP_Rt_NeedForward;
        assign CMP_Rt_NeedForward = 
            ( isBeq_D & isWrite_M & (~isLoad_M)
            & (Rt_D==WriteDes_M) & (Rt_D!=5'd0) 
            )?  1:
            0;
        assign Beq_CMP_RtChoose =
            ( (isCal_r_M || isCal_i_M) & CMP_Rt_NeedForward )? 2'b10:
            ( isJal_M & CMP_Rt_NeedForward )? 2'b01:
            2'b00;

    //ALU
        //Rs
        //100-ALU_M 011-ALU_W 010-DM_W 001-PC8_W 000-RD1_E
        wire ALU_Rs_100_ALU_M;
        wire ALU_Rs_011_ALU_W;
        wire ALU_Rs_010_DM_W;
        wire ALU_Rs_001_PC8_W;
        assign ALU_Rs_100_ALU_M = 
            ( isNeedALURs_E & ( isCal_r_M || isCal_i_M)
            & (Rs_E == WriteDes_M) & (Rs_E!=5'd0)
            )? 1:
            0;
        assign ALU_Rs_011_ALU_W = 
            ( isNeedALURs_E & (isCal_r_W || isCal_i_W)
            & (Rs_E==WriteDes_W) & (Rs_E!=5'd0)
            )? 1:
            0;
        assign ALU_Rs_010_DM_W = 
            ( isNeedALURs_E & isLoad_W 
            & (Rs_E==WriteDes_W) & (Rs_E!=5'd0)
            )?    1:
            0;
        assign ALU_Rs_001_PC8_W = 
            (isNeedALURs_E & isJal_W 
            & (Rs_E==WriteDes_W)
            )? 1:
            0;
        assign cal_r_cal_i_load_store_ALU_RsChoose = 
            (ALU_Rs_100_ALU_M)? 3'b100:
            (ALU_Rs_011_ALU_W)? 3'b011:
            (ALU_Rs_010_DM_W)? 3'b010:
            (ALU_Rs_001_PC8_W)? 3'b001:
            3'b000;
        //Rt
        //100-ALU_M 011-ALU_W 010-DM_W 001-PC8_W 000-RD2_E
        wire ALU_Rt_100_ALU_M;
        wire ALU_Rt_011_ALU_W;
        wire ALU_Rt_010_DM_W;
        wire ALU_Rt_001_PC8_W;
        assign ALU_Rt_100_ALU_M = 
            ( isCal_r_E & ( isCal_r_M || isCal_i_M)
            & (Rt_E == WriteDes_M) & (Rt_E!=5'd0)
            )? 1:
            0;
        assign ALU_Rt_011_ALU_W = 
            ( isCal_r_E & (isCal_r_W || isCal_i_W)
            & (Rt_E==WriteDes_W) & (Rt_E!=5'd0)
            )? 1:
            0;
        assign ALU_Rt_010_DM_W = 
            ( isCal_r_E & isLoad_W 
            & (Rt_E==WriteDes_W) & (Rt_E!=5'd0)
            )?    1:
            0;
        assign ALU_Rt_001_PC8_W = 
            (isCal_r_E & isJal_W 
            & (Rt_E==WriteDes_W)
            )? 1:
            0;
        assign cal_r_ALU_RtChoose = 
            (ALU_Rt_100_ALU_M)? 3'b100:
            (ALU_Rt_011_ALU_W)? 3'b011:
            (ALU_Rt_010_DM_W)? 3'b010:
            (ALU_Rt_001_PC8_W)? 3'b001:
            3'b000;

    //Store
        //DM
        //10-ALU_W 01-DM_W 00-Rt_M
        wire DM_Rt_10_ALU_W;
        wire DM_Rt_01_DM_W;
        assign DM_Rt_10_ALU_W = 
            ( isStore_M & (isCal_r_W || isCal_i_W)
            & (Rt_M==WriteDes_W) & (Rt_M!=5'd0)
            )?1:
            0;
        assign DM_Rt_01_DM_W =
            ( isStore_M & isLoad_W
            & (Rt_M==WriteDes_W) & (Rt_M!=5'd0)
            )? 1:
            0;
        assign store_RtChoose_DM_M = 
            (DM_Rt_10_ALU_W)? 2'b10:
            (DM_Rt_01_DM_W)? 2'b01:
            2'b00;

        //Rt_E
        //11-ALU_W 10-DM_W 01-PC8_W 00-RD2_E
        wire Rt_E_11_ALU_W;
        wire Rt_E_10_DM_W;
        wire Rt_E_01_PC8_W;
        assign Rt_E_11_ALU_W = 
            (isStore_E & (isCal_r_W ||isCal_i_W)
            & (Rt_E==WriteDes_W) & (Rt_E!=5'd0)
            )?  1:
            0;
        assign Rt_E_10_DM_W =
            (isStore_E & isLoad_W
            & (Rt_E==WriteDes_W) & (Rt_E!=5'd0)
            )?  1:
            0;
        assign Rt_E_01_PC8_W =
            (isStore_E & isJal_W 
            & (Rt_E==WriteDes_W)
            )?  1:
            0;
        assign store_RtChoose_Rt_E = 
            (Rt_E_11_ALU_W)? 2'b11:
            (Rt_E_10_DM_W)?  2'b10:
            (Rt_E_01_PC8_W)? 2'b01:
            2'b00;

endmodule //Forward
