module IM(
    input [31:0] PC,
    output [31:0] Ins
);
    //ROM
    reg [31:0] IMdeROM [0:4095];

    //载入指令
    integer i;
    initial begin
        for(i=0;i<4096;i=i+1)begin
            IMdeROM[i] = 32'h0000_0000;
        end
        $readmemh("code.txt",IMdeROM);
    end

    //输出Ins
    wire [31:0] tempPC  =   PC-32'h0000_3000;
    assign Ins  =   IMdeROM[    tempPC[13:2]    ];
endmodule