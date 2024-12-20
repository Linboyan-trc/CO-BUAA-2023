module tb (
);
//接线
    reg clk,rst;
    reg [7:0]inChar;
    wire rslt;
    BlockChecker newBCR(
        .clk(clk),
        .reset(rst),
        .in(inChar),
        .result(rslt)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        clk=1'b0;
        rst=1'b0;
        #200 $finish;
    end
//时钟
    always #1 clk=~clk;
//控制输入
    reg [0:255]bfr;
    integer i;
    initial begin
        //初始化bfr字符串，并且把字符串开头移到bfr最低位
        bfr="a BEgIn Endc end end bEGin";
        bfr=bfr<<48;
        //for循环控制inChar
        for(i=0;i<26;i=i+1)begin
            inChar = bfr[0:7];
            bfr=bfr<<8;
            #2;
        end
        inChar=8'd0;
        #2;

        rst=1;
        #2;

        rst=0;
        bfr="a BEgIn Endc end end bEGin";
        bfr=bfr<<48;
        //for循环控制inChar
        for(i=0;i<26;i=i+1)begin
            inChar = bfr[0:7];
            bfr=bfr<<8;
            #2;
        end
        inChar=8'd0;
    end

endmodule



