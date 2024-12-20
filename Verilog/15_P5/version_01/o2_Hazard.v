module Hazard(
    //D
        //Rs
        input       isRead_Rs_D,
        input [4:0] Rs_D,
        input [1:0] Tuse_Rs_D,
        //Rt
        input       isRead_Rt_D,
        input [4:0] Rt_D,
        input [1:0] Tuse_Rt_D,
    //E
        //Write
        input       isWrite_E,
        input [4:0] WriteDes_E,
        input [1:0] Tnew_E,
    //M
        //Write
        input       isWrite_M,
        input [4:0] WriteDes_M,
        input [1:0] Tnew_M,
    //输出
        output stallPC,stallID,flushEX
);
    //1.D Rs和E写冲突
    wire RsClash_DE;
    assign RsClash_DE  = 
        (   isRead_Rs_D & isWrite_E
        &   (Rs_D==WriteDes_E) & (Rs_D!=5'd0)
        &   (Tuse_Rs_D < Tnew_E)
        );   //默认为无符号比较，符合
    //2.D Rt和E写冲突
    wire RtClash_DE;
    assign RtClash_DE  = 
        (   isRead_Rt_D & isWrite_E
        &   (Rt_D==WriteDes_E) & (Rt_D!=5'd0)
        &   (Tuse_Rt_D < Tnew_E)
        );   //默认为无符号比较，符合
    //3.D Rs和M写冲突
    wire RsClash_DM;
    assign RsClash_DM  = 
        (   isRead_Rs_D & isWrite_M
        &   (Rs_D==WriteDes_M) & (Rs_D!=5'd0)
        &   (Tuse_Rs_D < Tnew_M)
        );   //默认为无符号比较，符合
    //4.D Rt和M写冲突
    wire RtClash_DM;
    assign RtClash_DM  = 
        (   isRead_Rt_D & isWrite_M
        &   (Rt_D==WriteDes_M) & (Rt_D!=5'd0)
        &   (Tuse_Rt_D < Tnew_M)
        );   //默认为无符号比较，符合
    
    //暂停
    wire stall;
    assign stall = 
        (   RsClash_DE
        ||  RtClash_DE
        ||  RsClash_DM
        ||  RtClash_DM
        );
        
    assign stallPC = stall;
    assign stallID = stall;
    assign flushEX = stall;
    
endmodule //Hazard
