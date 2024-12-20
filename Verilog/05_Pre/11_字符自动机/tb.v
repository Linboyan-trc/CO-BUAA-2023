module tb (
);
//接线
    //输入 char clk
    reg [7:0]char;
    reg clk;
    //输出out
    wire out;
    id_fsm Id_Fsm_My(
        .char(char),
        .clk(clk),
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
        #18 $finish;
    end
//时钟
    always #1 clk=~clk;
//控制输入char
    initial begin
        //abcd
        char=8'd97;
        #2;
        char=8'd98;
        #2;
        char=8'd99;
        #2;
        char=8'd100;
        #2;
        //1234
        char=8'd48;
        #2;
        char=8'd49;
        #2;
        char=8'd50;
        #2;
        char=8'd51;
        #2;
        //*
        char=8'd32;
        #2;
    end
endmodule