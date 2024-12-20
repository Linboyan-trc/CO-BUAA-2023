module tb (
);
//接线
    //输入和时钟都要reg
    reg [1:0]num;
    reg clk;
    //输出wire
    wire ans;
    counting Counting_My(
        .num(num),
        .clk(clk),
        .ans(ans)
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
        clk=1'b0;
        #32 $finish;
    end
//时钟
    always #1 clk=~clk;
//输入数字
    initial begin
        //1 1 2 3 3
        //1 2 1 1 1 
        //2 2 3 3 3 
        //1
        num=2'b01;
        #2;
        num=2'b01;
        #2;
        num=2'b10;
        #2;
        num=2'b11;
        #2;
        num=2'b11;
        #2;

        num=2'b01;
        #2;
        num=2'b10;
        #2;
        num=2'b01;
        #2;
        num=2'b01;
        #2;
        num=2'b01;
        #2;

        num=2'b10;
        #2;
        num=2'b10;
        #2;
        num=2'b11;
        #2;
        num=2'b11;
        #2;
        num=2'b11;
        #2;
        
        num=2'b01;
        #2;
    end
endmodule