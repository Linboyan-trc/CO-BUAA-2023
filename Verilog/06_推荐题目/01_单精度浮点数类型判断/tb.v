module tb ();
//接线
    reg [31:0]num;
    wire [4:0]result;
    FloatType my_ft(
        .num(num),
        .float_type(result)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        num=32'd0;
        #20 $finish;
    end
//时钟
//控制输入
    initial begin
        #5;

        num=32'd0;
        #1;
        num=32'h8000_0000;
        #1;
        num=32'b0_01010000_01010101010101010101000;
        #1;
        num=32'b1_01010000_01010101010101010101000;
        #1;
        num=32'b0_00000000_01010101010101010101000;
        #1;

        num=32'b0_11111111_00000000000000000000000;
        #1;
        num=32'b0_11111111_01010101010101010101000;
        #1;
    end
endmodule



