module tb (
);
//接线
    reg clk,clr;
    reg [7:0]in;
    wire out;
    expr myExpr(
        .clk(clk),
        .clr(clr),
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

        clr=1;
        #2;
        clr=0;

        #30 $finish;
    end
//时钟
    always #1 clk=~clk;
//控制输入
    initial begin
        #2;

        in="1";
        #2 in="+";
        #2 in="2";
        #2 in="+";
        #2 in="3";
        #2 in="+";
        #2 in="4";
        #2;

        clr=1;
        #2;
        clr=0;

        #2 in="1";
        #2 in="+";
        #2 in="+";
        #2 in="2";
        #2;
    end
endmodule



