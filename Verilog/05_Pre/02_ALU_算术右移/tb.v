module tb (
    );
//接线
    //4个输入都要作reg
    reg [3:0]inA,inB,
    reg [1:0]inC;
    reg [1:0]op;
    //输出作为wire
    wire [3:0]ans;
    ALU ALU_My(
        .inA(inA),
        .inB(inB),
        .inC(inC),
        .op(op),
        .ans(ans)
    );
//生成执行文件    
    initial begin
        $dumpfile("reference.vcd");
        $dumpvars;
    end
//初始化
    initial begin
        inA=4'b1110;
        inB=4'b0101;
        inC=2'b10;
        op=2'b00;
        #16 $finish;
    end
//控制op
    always #4 op<=op+1;
endmodule