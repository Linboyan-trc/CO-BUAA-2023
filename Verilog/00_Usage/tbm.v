module tb (
);
    //接线
    //生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
    //初始化
    //时钟
    always #1 clk=~clk;
    //控制输入

endmodule



