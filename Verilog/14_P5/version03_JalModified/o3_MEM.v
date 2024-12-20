module MEM(
    //时钟
    input clk,
    input reset,
    input en,

    //指令
    input [31:0]INS_E,
    input [31:0]PC_E,
    input [31:0]PC4_E,
    input [31:0]PC8_E,
    //GRF读出
    input [31:0]ALU_E,
    input [31:0]Rt_E,

    //指令
    output reg [31:0]INS_M,
    output reg [31:0]PC_M,
    output reg [31:0]PC4_M,
    output reg [31:0]PC8_M,
    //GRF读出
    output reg [31:0]ALU_M,
    output reg [31:0]Rt_M
);
    initial begin
        INS_M<=32'd0;
        PC_M<=32'd0;
        PC4_M<=32'd0;
        PC8_M<=32'd0;
        ALU_M<=32'd0;
        Rt_M<=32'd0;
    end

    always @(posedge clk) begin
        if(reset)begin
            INS_M<=32'd0;
            PC_M<=32'd0;
            PC4_M<=32'd0;
            PC8_M<=32'd0;
            ALU_M<=32'd0;
            Rt_M<=32'd0;
        end
        else if(en)begin
            INS_M<=INS_E;
            PC_M<=PC_E;
            PC4_M<=PC4_E;
            PC8_M<=PC8_E;
            ALU_M<=ALU_E;
            Rt_M<=Rt_E;
        end
    end
endmodule //ID
