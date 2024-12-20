module PC (
    input clk,
    input reset,
    input en,

    input [31:0] NPC,

    output reg [31:0] PC
);
    //PC寄存器+PC初始化
    /*reg [31:0]PCdeReg; 已经天然把输出作为了寄存器*/
    initial begin
        PC<=32'h0000_3000;
    end

    //上升沿更新+同步复位，复位为3000
    always@(posedge clk)begin
        if(reset)begin
            PC<=32'h0000_3000;
        end
        else if(en) begin
            PC<=NPC;
        end
    end
endmodule //PC
