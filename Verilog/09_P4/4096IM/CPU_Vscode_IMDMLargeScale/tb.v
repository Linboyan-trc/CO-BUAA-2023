// `include "./mips.v"
module tb (
);
//接线
    reg clk,reset;
    mips myMips(
        .clk   	( clk    ),
        .reset 	( reset  )
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
        #200 $finish;
    end
//时钟
    always#1 clk=~clk;
//复位
    initial begin
        #22 reset=1;
        #2 reset=0;
    end
endmodule



