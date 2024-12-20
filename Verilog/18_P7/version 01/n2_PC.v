module PC (
    input clk,
    input reset,
    input en,

    input [31:0] NPC,

    output reg [31:0] PC
);

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
