module tb (
);
//接线
    //输入：clk reset en slt
    reg clk,reset,en,slt;
    //输出：两个
    wire [63:0]output0,output1;
    code Code_My(
        .Clk(clk),
        .Reset(reset),
        .En(en),
        .Slt(slt),
        .Output0(output0),
        .Output1(output1)
    );
//
//
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        #102 $finish;
    end
//设置时钟
    always #1 clk=~clk;
//控制输入
    initial begin
        //清零
        clk=0;
        reset=1;
        en=0;
        slt=0;
        #2;
        //开始计数
        reset=0;
        en=1;
        slt=0;
        #40;
        //开始计数
        slt=1;
        #40;
        //开始计数
        en=0;
        #10;
        reset=1;
        #10;
    end
endmodule