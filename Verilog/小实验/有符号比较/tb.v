module tb (
);
    //接线
    reg [2:0]A,B;
    wire result;
    cmp myCmp(
        .A(A),
        .B(B),
        .isABigerB(result)
    );
    //生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
    //初始化
    initial begin
        A=3'b011;
        B=3'b111;
        #5 $finish;
    end
    //时钟
    // always #1 clk=~clk;
    //控制输入

endmodule



