module DEMW(
//三件套
    input           clk,reset,en,
//INS,PC**********************
    input [31:0]    INS,
    input [31:0]    PC,
//始于D级流水
    input [4:0]     A3,
    input [1:0]     Tuse_Rs,
    input [1:0]     Tuse_Rt,
    input [1:0]     Tnew,
//上级读入***********************
    input [31:0]    RD1,
    input [31:0]    RD2,
//送出**************************
    input [31:0]    Data,
    input [31:0]    ALU,
//CP0**************************  
    input           BD,
    input [4:0]     ExcCode,

//INS,PC**********************
    output reg [31:0]   INS_n,
    output reg [31:0]   PC_n,
//始于D级流水
    output reg [4:0]    A3_n,
    output reg [1:0]    Tuse_Rs_n,
    output reg [1:0]    Tuse_Rt_n,
    output reg [1:0]    Tnew_n,
//上级读入***********************
    output reg [31:0]   RD1_n,
    output reg [31:0]   RD2_n,
//送出**************************
    output reg [31:0]   Data_n,
    output reg [31:0]   ALU_n,
//CP0**************************  
    output reg          BD_n,
    output reg [4:0]    ExcCode_n 
);
    initial begin
        INS_n       <=32'd0;
        PC_n        <=32'd0;
        A3_n        <=5'd0;
        Tuse_Rs_n   <=2'd3;
        Tuse_Rt_n   <=2'd3;
        Tnew_n      <=2'd0;
        RD1_n       <=32'd0;
        RD2_n       <=32'd0;
        Data_n      <=32'd0;
        ALU_n       <=32'd0;
        BD_n        <=1'b0;
        ExcCode_n   <=5'b0;
    end

    always @(posedge clk) begin
        if(reset)begin
            INS_n       <=32'd0;
            PC_n        <=32'd0;
            A3_n        <=5'd0;
            Tuse_Rs_n   <=2'd3;
            Tuse_Rt_n   <=2'd3;
            Tnew_n      <=2'd0;
            RD1_n       <=32'd0;
            RD2_n       <=32'd0;
            Data_n      <=32'd0;
            ALU_n       <=32'd0;
            BD_n        <=1'b0;
            ExcCode_n   <=5'b0;
        end
        else if(en)begin
            INS_n       <=INS;
            PC_n        <=PC;
            A3_n        <=A3;
            Tuse_Rs_n   <=
                ((Tuse_Rs-2'b01)==2'b11)?   2'd0:
                                            Tuse_Rs-2'b01;
            Tuse_Rt_n   <=
                ((Tuse_Rt-2'b01)==2'b11)?   2'd0:
                                            Tuse_Rt-2'b01;
            Tnew_n      <=
                ((Tnew-2'b01)   ==2'b11)?      2'd0:
                                            Tnew-2'b01;
            RD1_n       <=RD1;
            RD2_n       <=RD2;
            Data_n      <=Data;
            ALU_n       <=ALU;
            BD_n        <=BD;
            ExcCode_n   <=ExcCode;
        end
    end
    
endmodule //DEMW