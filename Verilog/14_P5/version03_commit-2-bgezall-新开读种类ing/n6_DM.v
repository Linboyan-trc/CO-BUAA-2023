/*输入:
    A WD WE
    clk reset
    输出:RD
*/
/*为了满足display要求:
    [31:0]PC也要输入进来
*/
module DM(
    input [31:0] A,WD,PC_M,
    input WE,

    input clk,reset,
    
    output [31:0] RD
);
    //RAM+初始化
    reg [31:0]DMdeRAM[0:3071];
    integer i;
    initial begin
        for(i=0;i<3072;i=i+1)begin
            DMdeRAM[i]<=32'h0000_0000;
        end
    end

    //写入
    always @(posedge clk) begin
        if (reset) begin
            for(i=0;i<3072;i=i+1)begin
                DMdeRAM[i]<=32'h0000_0000;
            end
        end
        else if(WE)begin
            DMdeRAM[A[13:2]]<=WD;
            $display("%d@%h: *%h <= %h", $time,PC_M, A, WD);
        end
    end

    //读出
    assign RD=DMdeRAM[A[13:2]];
endmodule
