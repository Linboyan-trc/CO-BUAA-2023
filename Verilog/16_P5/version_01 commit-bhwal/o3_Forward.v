module Forward(
// D *******************************************
    input [4:0]     D_A1,
    input [4:0]     D_A2,
    input           D_Use_1,
    input           D_Use_2,
    input [31:0]    D_RD1,
    input [31:0]    D_RD2,
    input [4:0]     D_A3,
// E *******************************************
    input [4:0]     E_A1,
    input [4:0]     E_A2,
    input           E_Use_1,
    input           E_Use_2,
    input [31:0]    E_RD1,
    input [31:0]    E_RD2,
    input [4:0]     E_A3,
// M *******************************************
    input [4:0]     M_A1,
    input [4:0]     M_A2,
    input           M_Use_1,
    input           M_Use_2,
    input [31:0]    M_RD1,
    input [31:0]    M_RD2,
    input [4:0]     M_A3,
// W *******************************************
    input [4:0]     W_A3,
// 各级送出 **************************************
    input [31:0]    Data_E,
    input [31:0]    Data_M,
    input [31:0]    Data_W,
// 各级最终RD1，RD2 *******************************
    output [31:0]   RD1_D_final,
    output [31:0]   RD2_D_final,
    output [31:0]   RD1_E_final,
    output [31:0]   RD2_E_final,
    output [31:0]   RD1_M_final,
    output [31:0]   RD2_M_final
);

// 选择信号 **************************************************************

    wire nfd1;
    wire nfd2;
    wire nfd3;
    wire nfd4;
    wire nfd5;
    wire nfd6;
    wire nfd7;
    wire nfd8;
    wire nfd9;
    wire nfd10;

    // D-stage and E-stage or D-stage and M-satge for RD1_D_final
    assign nfd1 = (D_Use_1 & (D_A1==E_A3) & (E_A3!=5'd0));
    assign nfd2 = (D_Use_1 & (D_A1==M_A3) & (M_A3!=5'd0));

    // D-stage and E-stage or D-stage and M-satge for RD2_D_final
    assign nfd3 = (D_Use_2 & (D_A2==E_A3) & (E_A3!=5'd0));
    assign nfd4 = (D_Use_2 & (D_A2==M_A3) & (M_A3!=5'd0));

    // E-stage and M-stage or E-stage and W-satge for RD1_E_final
    assign nfd5 = (E_Use_1 & (E_A1==M_A3) & (M_A3!=5'd0));
    assign nfd6 = (E_Use_1 & (E_A1==W_A3) & (W_A3!=5'd0));

    // E-stage and M-stage or E-stage and W-satge for RD2_E_final
    assign nfd7 = (E_Use_2 & (E_A2==M_A3) & (M_A3!=5'd0));
    assign nfd8 = (E_Use_2 & (E_A2==W_A3) & (W_A3!=5'd0));

   // Mstage and W-stage for RD1_M_final Rd2_M_fianl
   assign nfd9 = (M_Use_1 & (M_A1==W_A3) & (W_A3!=5'd0));
   assign nfd10 = (M_Use_2 & (M_A2==W_A3) & (W_A3!=5'd0));
    
// 输出信号 ************************************************************

    // Decode
    assign RD1_D_final =    
        (nfd1)?     Data_E:
        (nfd2)?     Data_M:
                    D_RD1;
    assign RD2_D_final =
        (nfd3)?     Data_E:
        (nfd4)?     Data_M:
                    D_RD2;

    // Execute
    assign RD1_E_final = 
        (nfd5)?     Data_M:
        (nfd6)?     Data_W:
                    E_RD1;
    assign RD2_E_final =
        (nfd7)?     Data_M:
        (nfd8)?     Data_W:
                    E_RD2;

    // Memory
    assign RD1_M_final = 
        (nfd9)?     Data_W:
                    M_RD1;
    assign RD2_M_final = 
        (nfd10)?    Data_W:
                    M_RD2;

endmodule 