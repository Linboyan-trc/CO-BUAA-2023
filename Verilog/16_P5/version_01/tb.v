module tb (
);
    //接线
    reg clk,reset;
    mips u_mips(
        .clk (clk),
        .reset (reset)
    );
    //生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
    //初始化
    initial begin
        clk=0;
        reset=0;
        #2000 $finish;
    end
    //时钟
    always #1 clk=~clk;
    //控制输入

endmodule



