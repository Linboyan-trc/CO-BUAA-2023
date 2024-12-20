module Hazard(
//D************************************
    input       isRead_Rs_D,
    input [1:0] Tuse_Rs_D,
    input [4:0] Rs_D,
    input       isRead_Rt_D,
    input [1:0] Tuse_Rt_D,
    input [4:0] Rt_D,
//E************************************
    input [4:0] A3_E,
    input [1:0] Tnew_E,
//M************************************
    input [4:0] A3_M,
    input [1:0] Tnew_M,
//输出**********************************
    output stallPC,stallID,flushEX
);

//D-satge and E-stage clash **********************************

    wire clash1;
    assign clash1 = 
        (isRead_Rs_D 
        & (Rs_D==A3_E) & (A3_E!=5'd0) 
        & (Tuse_Rs_D<Tnew_E) );

    wire clash2;
    assign clash2 = 
        (isRead_Rt_D 
        & (Rt_D==A3_E) & (A3_E!=5'd0) 
        & (Tuse_Rt_D<Tnew_E) );

//D-satge and M-stage clash **********************************

    wire clash3;
    assign clash3 = 
        (isRead_Rs_D 
        & (Rs_D==A3_M) & (A3_M!=5'd0) 
        & (Tuse_Rs_D<Tnew_M) );

    wire clash4;
    assign clash4 = 
        (isRead_Rt_D 
        & (Rt_D==A3_M) & (A3_M!=5'd0) 
        & (Tuse_Rt_D<Tnew_M) );

// stall ******************************************************

    wire stall;
    assign stall = (clash1||clash2||clash3||clash4);
    assign stallPC = stall;
    assign stallID = stall;
    assign flushEX = stall;
    
endmodule //Hazard
