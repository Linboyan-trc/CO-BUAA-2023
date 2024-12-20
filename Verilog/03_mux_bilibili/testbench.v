/*
    对a,b,[1:0]sel整体赋值，这样代码会更简洁
    通过声明变量，调用模块，连接接口的方法在testbench中调用mux器
*/
module testbench();
    reg [3:0]sel_b_a;
    wire y;
    //调用mux_bilibili 接线
    mux mux_01(
            .a(sel_b_a[0]),
            .b(sel_b_a[1]),
            .sel(sel_b_a[3:2]),
            .y(y)
        );

    //激励1：生成文件和信号
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
    //激励2：控制信号电平
    initial begin
        sel_b_a=4'b0000;
        #200 $finish;
    end
    //和激励2并行运行，使得在200ns内每10ns sel_a_b就自增一次
    always #10 begin
        sel_b_a<=sel_b_a+1;
    end

endmodule
