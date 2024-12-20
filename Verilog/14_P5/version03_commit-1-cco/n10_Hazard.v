module Hazard(
    input [31:0]INS_D,
    input [31:0]INS_E,
    input [31:0]INS_M,

    output stallPC,
    output stallID,
    output flushEX
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
    //E
        //1.类型
        wire isCal_r_E,isJReg_E,isCal_i_E,isBeq_E,isLoad_E,isStore_E,isJal_E;
        //2.寄存器
        wire [4:0]Rs_E,Rt_E,Rd_E;
        //3.读写
        wire isRead_E,isWrite_E;
        wire [4:0]WriteDes_E;
    //M
        //1.类型
        wire isCal_r_M,isJReg_M,isCal_i_M,isBeq_M,isLoad_M,isStore_M,isJal_M;
        //2.寄存器
        wire [4:0]Rs_M,Rt_M,Rd_M;
        //3.读写
        wire isRead_M,isWrite_M;
        wire [4:0]WriteDes_M;



    //2.对D，E，M三条指令判断
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
            .WriteDes(WriteDes_D)
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
            .WriteDes(WriteDes_E)
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
            .WriteDes(WriteDes_M)
        );

    //3.四种暂停情况
        //1.JReg            12
        wire JRegStall_12;
        assign JRegStall_12 = 
            (isJReg_D & isWrite_E & (~isJal_E) 
            & (Rs_D==WriteDes_E) & (Rs_D!=5'd0)
            )? 1:
            0;
        //2.Beq             12
        wire BeqStall_12;
        assign BeqStall_12 = 
            (isBeq_D & isWrite_E & (~isJal_E) & 
            (       
                ( (Rs_D==WriteDes_E)&(Rs_D!=5'd0) )
                ||  ( (Rt_D==WriteDes_E)&(Rt_D!=5'd0) )
            ))? 1:
            0;
        //3.Read    Load    12
        wire Read_LoadStall_12;
        assign Read_LoadStall_12 = 
            // (isRead_D & isLoad_E &
            ((isCal_r_D||isCal_i_D||isLoad_D||isStore_D) & isLoad_E &
            (
                ( (Rs_D==WriteDes_E)&(Rs_D!=5'd0) )
                ||  (  isCal_r_D & (Rt_D==WriteDes_E) & (Rt_D!=5'd0)  )
            ))? 1:
            0;
        //4.JRegBeq Load    13
        wire JRegBeq_LoadStall_13;
        assign JRegBeq_LoadStall_13 = 
            (isLoad_M &
                (
                        (isJReg_D & (Rs_D==WriteDes_M) & (Rs_D!=5'd0))
                    ||  (isBeq_D & (
                            ((Rs_D==WriteDes_M)&(Rs_D!=5'd0))
                            ||  ((Rt_D==WriteDes_M)&(Rt_D!=5'd0))
                            )
                        )
                )
            )?  1:
            0;
    
    //4.输出取或
        assign stallPC = 
            (JRegStall_12||BeqStall_12||Read_LoadStall_12||JRegBeq_LoadStall_13)?   1:
            0;
        assign stallID = 
            (JRegStall_12||BeqStall_12||Read_LoadStall_12||JRegBeq_LoadStall_13)?   1:
            0;
        assign flushEX = 
            (JRegStall_12||BeqStall_12||Read_LoadStall_12||JRegBeq_LoadStall_13)?   1:
            0;

endmodule //Hazard
