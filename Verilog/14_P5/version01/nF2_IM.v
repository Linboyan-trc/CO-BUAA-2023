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
        IMdeROM[0]<=32'h34010001;
        IMdeROM[1]<=32'h00411020;
        IMdeROM[2]<=32'h1041fffe;
        IMdeROM[3]<=32'h00611820;
        IMdeROM[4]<=32'h10620001;
        IMdeROM[5]<=32'h0c000c03;
        IMdeROM[6]<=32'h3c080001;
        IMdeROM[7]<=32'h00000000;
    end

    //输出Ins
    wire [31:0]tempPC;
    assign tempPC=PC-32'h0000_3000;
    assign Ins=IMdeROM[tempPC[13:2]];
endmodule