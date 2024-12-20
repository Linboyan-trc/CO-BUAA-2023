module IM(
    input [31:0] PC,
    output [31:0] Ins
);
    //ROM
    reg [31:0] IMdeROM [0:4095];

    //载入指令
    initial begin
        $readmemh("code.txt",IMdeROM);
    end
    // //vscode专用载入指令
    // initial begin

    // end

    //输出Ins
    wire [31:0]tempPC;
    assign tempPC=PC-32'h0000_3000;
    assign Ins=IMdeROM[tempPC[13:2]];
endmodule