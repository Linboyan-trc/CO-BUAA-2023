module EX(
    //时钟
    input clk,
    input reset,
    input en,

    //指令
    input [31:0]INS_D,
    input [31:0]PC_D,
    input [31:0]PC4_D,
    input [31:0]PC8_D,
    //GRF读出
    input [31:0]RD1_D,
    input [31:0]RD2_D,

    //指令
    output reg [31:0]INS_E,
    output reg [31:0]PC_E,
    output reg [31:0]PC4_E,
    output reg [31:0]PC8_E,
    //GRF读出
    output reg [31:0]RD1_E,
    output reg [31:0]RD2_E
);
    initial begin
        INS_E<=32'd0;
        PC_E<=32'd0;
        PC4_E<=32'd0;
        PC8_E<=32'd0;
        RD1_E<=32'd0;
        RD2_E<=32'd0;
    end

    always @(posedge clk) begin
        if(reset)begin
            INS_E<=32'd0;
            PC_E<=32'd0;
            PC4_E<=32'd0;
            PC8_E<=32'd0;
            RD1_E<=32'd0;
            RD2_E<=32'd0;
        end
        else if(en)begin
            INS_E<=INS_D;
            PC_E<=PC_D;
            PC4_E<=PC4_D;
            PC8_E<=PC8_D;
            RD1_E<=RD1_D;
            RD2_E<=RD2_D;
        end
    end
endmodule //ID
