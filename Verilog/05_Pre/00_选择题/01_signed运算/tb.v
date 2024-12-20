module tb (
);
//接线
    reg clk,reset;
    reg [3:0]a,b;
    a2 A2_My(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b)
    );
//
//
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
//时钟
//控制输入
    initial begin
    // Initialize Inputs
    clk = 0;
    reset = 0;
    a = 0;
    b = 0;

    // Wait 100 ns for global reset to finish
    #100;

    // Add stimulus here
    a=3;
    b=1;
    #2;
    a=-2;
    b=1;
    #2;
    end
//
//
//
//
//
//
endmodule //tb
