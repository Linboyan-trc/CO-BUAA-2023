module tb (
);
//接线
    reg clk,reset;
    reg [7:0]char;
    reg [15:0]freq;
    wire [1:0]format_type;
    wire [3:0]error_code;
    // wire [31:0]test_pc;
    // wire [15:0]test_grf;
    // wire [31:0]test_addr;
    cpu_checker CPU_Checker_My(
        .clk(clk),
        .reset(reset),
        .char(char),
        .freq(freq),
        .format_type(format_type),
        .error_code(error_code)
        // .test_pc(test_pc),
        // .test_grf(test_grf),
        // .test_addr(test_addr)
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
        freq=2048;
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
        #2 char="0";
        #2 char="2";
        #2 char="4";
        #2 char="@";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="3";
        #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char=":";
        #2 char=" ";
        #2 char="$";
        // #2 char="0";
        #2 char="0";
        #2 char="0";
        #2 char="9";
        #2 char="9";
        // #2 char="0";
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



