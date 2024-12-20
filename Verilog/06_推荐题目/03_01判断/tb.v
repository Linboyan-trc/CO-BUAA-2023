module tb (
);
//接线
    reg clk,in;
    wire out;
    fsm_1010 myF(
        .clk(clk),
        .in(in),
        .out(out)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        clk=0;
        #20 $finish;
    end
//时钟
    always #1 clk=~clk;
//控制输入
    initial begin
        in=1;
        #2 in=0;
        #2 in=1;
        #2 in=1;
        #2 in=0;
        #2 in=1;
        #2 in=0;
    end
endmodule



