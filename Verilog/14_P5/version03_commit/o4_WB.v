module WB(
    //时钟
    input clk,
    input reset,
    input en,

    //指令
    input [31:0]INS_M,
    input [31:0]PC_M,
    input [31:0]PC4_M,
    input [31:0]PC8_M,
    //GRF读出
    input [31:0]ALU_M,
    input [31:0]DM_M,

    //指令
    output reg [31:0]INS_W,
    output reg [31:0]PC_W,
    output reg [31:0]PC4_W,
    output reg [31:0]PC8_W,
    //GRF读出
    output reg [31:0]ALU_W,
    output reg [31:0]DM_W
);
    initial begin
        INS_W<=32'd0;
        PC_W<=32'd0;
        PC4_W<=32'd0;
        PC8_W<=32'd0;
        ALU_W<=32'd0;
        DM_W<=32'd0;
    end

    always @(posedge clk) begin
        if(reset)begin
            INS_W<=32'd0;
            PC_W<=32'd0;
            PC4_W<=32'd0;
            PC8_W<=32'd0;
            ALU_W<=32'd0;
            DM_W<=32'd0;
        end
        else if(en)begin
            INS_W<=INS_M;
            PC_W<=PC_M;
            PC4_W<=PC4_M;
            PC8_W<=PC8_M;
            ALU_W<=ALU_M;
            DM_W<=DM_M;
        end
    end
endmodule //ID
