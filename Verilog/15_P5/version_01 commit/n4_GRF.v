/*输入:
    [4:0]A1 A2 A3 [31:0]WD WE
    clk reset
    输出:RD1 RD2
*/
/*为了满足display要求:
    [31:0]PC也要输入进来
*/
module GRF (
    input clk,
    input reset,

    input [31:0] PC_W,
    input [4:0] A1,A2,A3,
    input [31:0] WD,
    input WE,

    output [31:0]RD1,RD2
);
    //寄存器堆+循环初始化所有寄存器
    reg [31:0]GRFdeReg[0:31];
    integer i;
    initial begin
        for(i=0;i<32;i=i+1)begin
            GRFdeReg[i]<=32'h0000_0000;
        end
    end

    //写入控制
    always @(posedge clk) begin
        //同步复位
        if(reset)begin
            for(i=0;i<32;i=i+1)begin
                GRFdeReg[i]<=32'h0000_0000;
            end
        end
        //如果使能，而且不是0寄存器，就写入数据
        else if(WE)begin
            if(A3!=5'd0)begin
                GRFdeReg[A3]<=WD;
                $display("%d@%h: $%d <= %h", $time,PC_W, A3, WD);
                //$display("@%h: $%d <= %h", PC_W, A3, WD);
            end
        end
    end

    //读出控制
    assign RD1  =   ((A1==A3)&(A1!=5'd0)& WE )? WD:
                    GRFdeReg[A1];
    assign RD2  =   ((A2==A3)&(A2!=5'd0)& WE )? WD:
                    GRFdeReg[A2];
endmodule