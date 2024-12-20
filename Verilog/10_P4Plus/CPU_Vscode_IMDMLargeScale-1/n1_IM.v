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
        IMdeROM[0]<=32'h3401ffff;
        IMdeROM[1]<=32'h3c02ffff;
        IMdeROM[2]<=32'h00411826;
    end

    //输出Ins
    wire [31:0]tempPC;
    assign tempPC=PC-32'h0000_3000;
    assign Ins=IMdeROM[tempPC[13:2]];
endmodule