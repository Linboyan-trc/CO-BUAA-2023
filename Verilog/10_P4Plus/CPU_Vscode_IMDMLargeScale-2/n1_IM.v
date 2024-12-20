module IM(
    input [31:0] PC,
    output [31:0] Ins
);
    //ROM
    reg [31:0] IMdeROM [0:4095];

    // //载入指令
    // initial begin
    //     $readmemh("code.txt",IMdeROM);
    // end
    //vscode专用载入指令
    initial begin
        IMdeROM[0]<=32'h3c018765;
        IMdeROM[1]<=32'h34214321;
        IMdeROM[2]<=32'hac010000;
        IMdeROM[3]<=32'h80020000;
        IMdeROM[4]<=32'h80030001;
        IMdeROM[5]<=32'h80040002;
        IMdeROM[6]<=32'h80050003;
    end

    //输出Ins
    wire [31:0]tempPC;
    assign tempPC=PC-32'h0000_3000;
    assign Ins=IMdeROM[tempPC[13:2]];
endmodule