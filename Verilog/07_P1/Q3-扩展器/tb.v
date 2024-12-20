module tb (
);
//接线
    reg [15:0]imm;
    reg [1:0]EOp;
    wire [31:0]ext;
    ext myExt(
        .imm(imm),
        .EOp(EOp),
        .ext(ext)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
//时钟
    initial begin
        imm=16'hf001;
        #10 $finish;
    end
//控制输入
    initial begin
        EOp=2'd0;
        #1;
        EOp=2'd1;
        #1;
        EOp=2'd2;
        #1;
        EOp=2'd3;
        #1; 
    end
//
endmodule



