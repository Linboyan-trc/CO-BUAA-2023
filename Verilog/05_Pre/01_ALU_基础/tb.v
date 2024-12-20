module tb();
//接线
    reg [3:0]inA,inB;
    wire [3:0]ans;
    reg [1:0]op;
    ALU ALU_My(
        .inA(inA),
        .inB(inB),
        .op(op),
        .ans(ans)
    );
//生成文件
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//生成信号
    initial begin
        inA=4'b0110;
        inB=4'b0101;
        op=2'b00;
        #16 $finish;
    end
//控制op
    always #4 op<=op+1;

endmodule