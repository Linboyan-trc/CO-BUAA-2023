module tb (
);
//接线
    reg [31:0]np;
    reg [7:0]vip;
    reg vvip;
    wire out;
    voteMulti myVote(
        .np(np),
        .vip(vip),
        .vvip(vvip),
        .res(out)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        #10 $finish;
    end
//时钟
//控制输入
    initial begin
        np=32'hf00f000f;
        vip=8'h0f;
        vvip=1;
        #5;
        np=32'hf00f000f;
        vip=8'h0f;
        vvip=0;
    end
endmodule



