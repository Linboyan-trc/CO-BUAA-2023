module tb (
);
//接线
    reg clk,reset;
    reg [7:0]char;
    wire [1:0]format_type;
    cpu_checker CPU_Checker_My(
        .clk(clk),
        .reset(reset),
        .char(char),
        .format_type(format_type)
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
        clk=0;
        reset=1;
        #2;
        reset=0;
        #120 $finish;
    end
//时钟
    always #1 clk=~clk;
//控制输入
    initial begin
        #2 char="^";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="@";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char=":";
        #2 char=" ";
        #2 char="*";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char="1";
        #2 char=" ";
        #2 char="<";
        #2 char="=";
        #2 char=" ";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="#";
    end
//
//
//
//
//
//
endmodule



