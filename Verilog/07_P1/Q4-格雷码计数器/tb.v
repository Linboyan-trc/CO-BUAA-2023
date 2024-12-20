module tb (
);
//接线
    reg Clk,Reset,En;
    wire [2:0]Output;
    wire Overflow;
    gray myGray(
        .Clk(Clk),
        .Reset(Reset),
        .En(En),
        .Output(Output),
        .Overflow(Overflow)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        Clk=0;
        Reset=1;
        En=0;
        #2;
        Reset=0;
        En=1;
        #18 $finish;
    end
//时钟
    always #1 Clk=~Clk;
//控制输入
    // initial begin
    //     #15;
    //     Reset=1;
    //     #2;
    //     Reset=0;
    // end
//
//
//
//
//
//
endmodule



